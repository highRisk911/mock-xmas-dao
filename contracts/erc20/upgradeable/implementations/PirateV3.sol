// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
 
import "../../../../openzeppelin-contracts-upgradeable-master/contracts/access/AccessControlUpgradeable.sol";
import "../../../../openzeppelin-contracts-upgradeable-master/contracts/token/ERC20/extensions/ERC20PausableUpgradeable.sol";


contract PirateV3 is ERC20PausableUpgradeable, AccessControlUpgradeable{

    string public word;

    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant BLACKLIST_ROLE = keccak256("BLACKLIST_ROLE");
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");

    function initialize(string memory name, string memory symbol, uint256 totalSupply) public initializer{
         __ERC20Pausable_init();
        __ERC20_init_unchained(name, symbol);
        __AccessControl_init_unchained();
        _setupRole(ADMIN_ROLE, _msgSender());
        _mint(_msgSender(), totalSupply);
        word = "freedom";
    }



    function mint(address receiver, uint256 amount) public onlyRole(MINTER_ROLE){
        require(hasRole(MINTER_ROLE, msg.sender), "Caller is not a minter");
        _mint(receiver, amount);
    }


    function deleteFromBlackList(address account) public onlyRole(ADMIN_ROLE){
        _revokeRole(BLACKLIST_ROLE, account);
    }


    function addToBlackList(address account) public onlyRole(ADMIN_ROLE){
        _grantRole(BLACKLIST_ROLE, account);
    }


    function isBlacklisted(address account) public view returns(bool){
        return hasRole(BLACKLIST_ROLE, account);
    }


    function burn(address account, uint256 amount) public onlyRole(ADMIN_ROLE){
        _burn(account, amount);
    }

    function version() public pure returns(string memory){
        return "v3";
    }

}
