// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "../../../../openzeppelin-contracts-master/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";

contract PirateProxy is TransparentUpgradeableProxy {
    constructor(
        address _logic,
        address admin_,
        bytes memory _data
    ) payable TransparentUpgradeableProxy(_logic, admin_, _data) {
    }
}
