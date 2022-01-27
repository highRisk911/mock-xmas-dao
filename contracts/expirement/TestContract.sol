// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./TestA.sol";
import "./TestB.sol";

contract TestContract is TestA, TestB{
    function Test() public override(TestA, TestB) pure returns(string memory){
        return "testC";
    }
}
