// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;


import "../../openzeppelin-contracts-master/contracts/token/ERC1155/ERC1155.sol";


contract LGA is ERC1155{
    //NFT part of the smart contract
    uint256 public constant LYNNFIELD = 0;
    uint256 public constant SANDY_BRIDGE = 1;
    uint256 public constant IVY_BRIDGE = 2;

    constructor() ERC1155("https://ipfs.io/ipfs/QmcETaxUd1n6dcbq2QHnnV8wA5dKymgnV1ykuBkYiziPjK?filename=TestNFT.json")
    {
        mintLynnield();

    }

    //For get a more newer generation like a Sandy Bridge than Lynnfield - you must firstly create an older gen
    function mintLynnield() public{
        require(balanceOf(msg.sender,LYNNFIELD) == 0,"you already have a LYNNFIELD ");
        _mint(msg.sender,LYNNFIELD,1,"0x000");
    }

    function mintSANDY_BRIDGE() public{
        require(balanceOf(msg.sender,LYNNFIELD) > 0,"you need have a LYNNFIELD");
        require(balanceOf(msg.sender,SANDY_BRIDGE) == 1,"you already have a SANDY_BRIDGE");
        _mint(msg.sender,SANDY_BRIDGE,1,"0x000");
    }

    function mintIVY_BRIDGE() public{
        require(balanceOf(msg.sender,SANDY_BRIDGE) > 0,"you need have a SANDY_BRIDGE");
        require(balanceOf(msg.sender,IVY_BRIDGE) == 2,"you already have a IVY_BRIDGE");
        _mint(msg.sender,IVY_BRIDGE,1,"0x000");
    }




}
