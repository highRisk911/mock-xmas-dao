// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;


import "../../../openzeppelin-contracts-master/contracts/utils/Context.sol";
import "../../../openzeppelin-contracts-master/contracts/token/ERC20/IERC20.sol";
import "../../../openzeppelin-contracts-master/contracts/token/ERC20/extensions/IERC20Metadata.sol";


//npx truffle run verify Snowball

contract RSnowball is IERC20, Context, IERC20Metadata {

    string private _name;
    string private _symbol;


    address private owner;


    uint256 private _totalSupply;


    mapping(address => uint256) private balancesOfAccounts;
    mapping(address => mapping(address => uint256)) private _allowances;


    constructor(
        string memory name_,
        string memory symbol_
    ){
        owner = msg.sender;
        _name = name_;
        _symbol = symbol_;
        _totalSupply = 0;
    }


    function burn(address account, uint256 amount) external  virtual {
        _burn(account, amount);
    }


    function mint(address account, uint256 amount) external  virtual {
        require(account == owner, "Only owner can mint");
        _mint(account, amount);
    }


    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "mint to zero address");

        //beforeTokenTransfer hook

        _totalSupply += amount;
        balancesOfAccounts[account] += amount;

        emit Transfer(address(0), account, amount);

        //afterTokenTransfer hook
    }


    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "burn from the zero address");


        //before token hook

        uint256 accountBalance = balancesOfAccounts[account];
        require(accountBalance >= amount, "burn amount bigger than amount");
             
        unchecked{
            balancesOfAccounts[account] = accountBalance - amount;
        }

        _totalSupply -= amount;

        emit Transfer(account, address(0), amount);
        //afterTokenTransfer hook
    }


    function name() public view virtual override returns (string memory) {
        return _name;
    }


    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }


    function decimals() public view virtual override returns (uint8) {
        return 18;
    }


    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }


    function balanceOf(address account) external view returns (uint256){
        return balancesOfAccounts[account];
    }


    function transfer(address recipient, uint256 amount) external returns (bool){
        _transfer(_msgSender(), recipient, amount);
        return true; 
    }


    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal virtual {

        require(sender != address(0), "error: approve from zero address");
        require(recipient != address(0), "error: approve to zero address");

        require(balancesOfAccounts[sender] >= amount, "Sender haven't enough amount");
        //need hook beforeTokenTransfer

        uint256 senderBalance = balancesOfAccounts[sender];

    unchecked {
        balancesOfAccounts[sender] = senderBalance - amount;
    }

        balancesOfAccounts[recipient] += amount;

        emit Transfer(sender, recipient, amount);

        //afterTokenHook
    }


    function allowance(address _owner, address spender) external view returns (uint256){
        return _allowances[_owner][spender];
    }


    function approve(address spender, uint256 amount) external returns (bool){
        _approve(_msgSender(), spender, amount);
        return true;
    }


    function _approve(
        address _owner,
        address spender,
        uint256 amount
    ) internal virtual {


        require(_owner != address(0), "approve from zero address");
        require(spender != address(0), "approve to zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }


    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public virtual override returns (bool){
        _transfer(sender, recipient, amount);

        uint256 currentAllowance = _allowances[sender][_msgSender()];
        require(currentAllowance >= amount, "transfer amount exceeds allowance");

        unchecked {
            _approve(sender, _msgSender(), currentAllowance - amount);
    }
        return true;
    }


    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender] + addedValue);
        return true;
    }


    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {

        uint256 currentAllowance = _allowances[_msgSender()][spender];

        require(currentAllowance >= subtractedValue, "decreased allowance less than zero");

        unchecked {
            _approve(_msgSender(), spender, currentAllowance - subtractedValue);
    }
        return true;
    }

}
