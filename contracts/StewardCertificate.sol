// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract StewardCertificate is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // Store the metadata for each token
    mapping(uint256 => string) private _metadata;

    constructor() ERC721("Ethix Steward Certificate", "ESTC") {
        // solhint-disable-previous-line no-empty-blocks
    }

    /**
     * 
     * @param burner - address of the person who burned Steward Tokens
     * @param tokenMetadata - metadata for this NFT:
     * { "image": "<IPFS hash>",
     *   "name": "Name of person who burned Steward Tokens",
     *   "amount": "<number of Steward Tokens burned>"
     *   "message": "Statement from the burner; e.g., offset made on behalf of..."}
     */
    function mint(address burner, string memory tokenMetadata) public returns (uint256) {
        _tokenIds.increment();

        uint256 newCertId = _tokenIds.current();
        _mint(burner, newCertId);
        _setTokenURI(newCertId, tokenMetadata);

        return newCertId;
    }

    function _setTokenURI(uint256 tokenId, string memory tokenMetadata) private {
        _metadata[tokenId] = tokenMetadata;
    }

    /// @inheritdoc IERC721Metadata
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        _requireMinted(tokenId);

        return _metadata[tokenId];
    }
}
