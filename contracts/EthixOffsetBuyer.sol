// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "./StewardToken.sol";
import "./StewardCertificate.sol";

interface IOffsetHelper {
    function autoOffsetExactOutToken(
        address _fromToken,
        address _poolToken,
        uint256 _amountToOffset
    ) external returns (address[] memory tco2s, uint256[] memory amounts);

    function calculateNeededTokenAmount(
        address _fromToken,
        address _poolToken,
        uint256 _toAmount
    ) external view returns (uint256);
}

contract EthixOffsetBuyer {
    using SafeERC20 for IERC20;

    struct NFTParams {
        uint256 amount;
        string name;
        string image;
        string message;
    }

    IUniswapV2Router02 private immutable _dexRouter;
    IOffsetHelper private immutable _offsetHelper;
    address private immutable _nctToken;
    address private immutable _stewardToken;
    address private immutable _stewardCertificate;
    string private _certificateImage;

    constructor(
        IOffsetHelper offsetHelper,
        address nctToken,
        address stewardToken,
        address stewardCertificate,
        IUniswapV2Router02 dexRouter,
        string memory certificateImage
    ) {
        _dexRouter = dexRouter;
        _offsetHelper = offsetHelper;
        _nctToken = nctToken;
        _stewardToken = stewardToken;
        _stewardCertificate = stewardCertificate;
        _certificateImage = certificateImage;
    }

    /**
     * @dev Divide the total tons in two; buy and retire NCDT with the first half, and EST with the second half.
     *
     * @param fromToken - token used to buy the offsets (e.g., mcUSD)
     * @param amount - amount of offsets to buy
     */
    function buyOffset(address fromToken, uint256 amount, string memory name, string memory message)
        external returns (address[] memory tco2s, uint256[] memory amounts)
    {
        require(amount > 1, "Insufficient offset amount");

        uint256 nctOffsetAmount = amount / 2;
        uint256 stewardOffsetAmount = amount - nctOffsetAmount;

        // Buy/retire NCT - amount of fromToken to require the given offset size
        uint256 amountRequiredForNCT = _offsetHelper.calculateNeededTokenAmount(fromToken, _nctToken, nctOffsetAmount);
        uint256 amountRequiredForSteward = _calculateExactOutSwap(fromToken, _stewardToken, stewardOffsetAmount);

        require(
            IERC20(fromToken).balanceOf(msg.sender) >= amountRequiredForNCT + amountRequiredForSteward,
            "Insufficient funds"
        );

        // Handle NCT
        (tco2s, amounts) = _offsetHelper.autoOffsetExactOutToken(fromToken, _nctToken, nctOffsetAmount);

        // Handle Steward
        _swapExactOutToken(fromToken, _stewardToken, stewardOffsetAmount);

        // Burn and mint NFT
        StewardToken(_stewardToken).burnWithoutAllowance(address(this), stewardOffsetAmount);

        NFTParams memory params = NFTParams({
            amount: stewardOffsetAmount,
            name: name,
            message: message,
            image: _certificateImage
        });

        StewardCertificate(_stewardCertificate).mint(msg.sender, string(abi.encode(params)));
    }

    function _calculateExactOutSwap(
        address _fromToken,
        address _poolToken,
        uint256 _toAmount
    ) private view returns (uint256) {
        address[] memory path = _getDirectPath(_fromToken, _poolToken);
        uint256 len = path.length;

        uint256[] memory amounts = _dexRouter.getAmountsIn(_toAmount, path);

        // sanity check arrays
        require(len == amounts.length, "Arrays unequal");
        require(_toAmount == amounts[len - 1], "Output amount mismatch");

        return amounts[0];
    }

    /**
     * @notice Swap eligible ERC20 tokens for Toucan pool tokens (BCT/NCT) on SushiSwap
     * @dev Needs to be approved on the client side
     * @param _fromToken The address of the ERC20 token used for the swap
     * @param _poolToken The address of the pool token to swap for,
     * for example, NCT or BCT
     * @param _toAmount The required amount of the Toucan pool token (NCT/BCT)
     */
    function _swapExactOutToken(
        address _fromToken,
        address _poolToken,
        uint256 _toAmount
    ) private {
        // calculate path & amounts
        address[] memory path = _getDirectPath(_fromToken, _poolToken);
        uint256 amountIn = _calculateExactOutSwap(
            _fromToken,
            _poolToken,
            _toAmount
        );

        // transfer tokens
        IERC20(_fromToken).safeTransferFrom(
            msg.sender,
            address(this),
            amountIn
        );

        // approve router
        IERC20(_fromToken).approve(address(_dexRouter), amountIn);

        // swap
        uint256[] memory amounts = _dexRouter.swapTokensForExactTokens(
            _toAmount,
            amountIn, // max. input amount
            path,
            address(this),
            block.timestamp
        );

        // remove remaining approval if less input token was consumed
        if (amounts[0] < amountIn) {
            IERC20(_fromToken).approve(address(_dexRouter), 0);
        }
    }

    function _getDirectPath(address _fromToken, address _toToken) private view returns (address[] memory) {
        // create path & calculate amounts - with Steward Token, there is only one pool: so only one path.
        address[] memory path = new address[](2);
        path[0] = _fromToken;
        path[1] = _toToken;

        return path;
    }
}
