// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "../../openzeppelin-contracts-master/contracts/token/ERC721/ERC721.sol";
import "../../openzeppelin-contracts-master/contracts/access/Ownable.sol";
import "../../openzeppelin-contracts-master/contracts/utils/Counters.sol";
import "../../openzeppelin-contracts-master/contracts/token/ERC721/extensions/ERC721URIStorage.sol";


contract TestNFT is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("NFTest", "HWNFT") {}

    function awardItem(address player, string memory tokenURI)
    onlyOwner public returns (uint256)
    {


        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(player, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }

    function getItemId() public view returns(uint256){
        return _tokenIds.current();
    }
}
