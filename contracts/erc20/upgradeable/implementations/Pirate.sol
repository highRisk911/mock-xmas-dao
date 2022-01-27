// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "../../../../openzeppelin-contracts-upgradeable-master/contracts/token/ERC20/ERC20Upgradeable.sol";




contract Pirate is ERC20Upgradeable{

//    uint256 public number;

    function initialize(string memory name, string memory symbol, uint256 totalSupply) public initializer{
        __ERC20_init(name, symbol);
        _mint(_msgSender(), totalSupply);
//        number = 10;
    }


    function version() public pure returns(string memory){
        return "v1";
    }

//    function getNumber() public payable{
//        emit checkNumber(number);
//    }
//
//    event checkNumber(uint256 _number);


}
