// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;


import "../../../openzeppelin-contracts-master/contracts/token/ERC20/ERC20.sol";


contract Santa is ERC20{


    address private owner;
    uint256 private tokenSupply = 0;


    constructor(
        string memory _name,
        string memory _symbol
    ) ERC20(_name, _symbol){
        owner = msg.sender;
    }


    function mint(address account, uint256 amount) external virtual {
        require(msg.sender == owner, "Only owner can summon the SANTA");
        _mint(account, amount);
    }


    function burn(address account, uint256 amount) external virtual {
        require(msg.sender == owner, "Only owner can kill the SANTA");
        _burn(account, amount);
    }


    function name() public view override returns(string memory) {
        return super.name();
    }


    function symbol() public view override returns(string memory) {
        return super.symbol();
    }


    function whoIsMsgSender() external view returns(string memory){
        return toAsciiString(msg.sender);

    }


    function whoIsMsgSenderFunc() external view returns(string memory){
        return toAsciiString(_msgSender());

    }

    function toAsciiString(address _address) internal pure returns (string memory) {
        bytes memory resultString = new bytes(40);
        for (uint i = 0; i < 20; i++) {
            bytes1 b = bytes1(uint8(uint(uint160(_address)) / (2**(8*(19 - i)))));
            bytes1 hi = bytes1(uint8(b) / 16);
            bytes1 lo = bytes1(uint8(b) - 16 * uint8(hi));
            resultString[2*i] = char(hi);
            resultString[2*i+1] = char(lo);
        }
        return string(resultString);
    }

    function char(bytes1 b) internal pure returns (bytes1 c) {
        if (uint8(b) < 10) return bytes1(uint8(b) + 0x30);
        else return bytes1(uint8(b) + 0x57);
    }

    function getOwner() external view returns(address){
        return owner;

    }

}
