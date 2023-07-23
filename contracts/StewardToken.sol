// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract StewardToken is ERC20 {
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        // solhint-disable-prev-line no-empty-blocks
    }

    function decimals() public pure override returns (uint8) {
        return 18;
    }

    /**
     * @dev In production, there would be a single minter, and a server to receive authenticated requests to mint.
     * For testing, just let anyone mint
     */
    function mint(address recipient, uint256 amount) external {
        _mint(recipient, amount);
    }

    // burnWithoutAllowance was created to allow burning tokens without approval.
    function burnWithoutAllowance(address sender, uint256 amount) external {
        _burn(sender, amount);
    }
}
