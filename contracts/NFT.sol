// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NFT is ERC1155 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenId;

    constructor() ERC1155("Yoncity") {}

    event TokenMinted (
      uint256 indexed tokenId,
      address indexed owner,
      uint256 amount,
      string name,
      string description,
      string image_url
    );

    event LoungeAccessModified (
        uint indexed tokenId,
        bool access
    );

    mapping(uint => bool) private _loungeAccess;

    function mint(uint256 amount, string memory name, string memory description, string memory image_url) external returns(uint256) {
        _tokenId.increment();
        
        uint256 newTokenId = _tokenId.current();
        
        _mint(msg.sender, newTokenId, amount, "");

        emit TokenMinted(newTokenId, msg.sender, amount, name, description, image_url);

        return newTokenId;
    }


    function grantOrRevokeloungeAccess(uint256 tokenId, bool access) external {
        _loungeAccess[tokenId] = access;

        emit LoungeAccessModified(tokenId, access);
    }
}
 