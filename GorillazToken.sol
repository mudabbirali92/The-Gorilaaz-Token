pragma solidity ^0.6.0;

import "./Interface ERC20.sol";

contract TheGorillazToken is ERC20
{
    //mapping for EOA...
    mapping (address=>uint256) internal balances;
    // maapping for those address whom owner has allowed to make transactions...
    mapping(address=>mapping(address=>uint256))private allowances;
    
    uint256 internal _totalTokenSupply;// we are decalring it as internal cuz its child class i.e. cap will be using this varibale...
    
    address public owner;
    string public name;
    string public symbol;
    //uint256 public decimal;
    event Received(string);
    uint256 public rate;
    
    constructor() public
    {
        
        owner=msg.sender;
        //decimal=17;// That our 1 Gorilla token is equal to 1000 mini Gorilla token just like 1 $ is 100 cents that is 2 decimal fraction...
        symbol="TGT";
        name="THE GORILLA TOKEN";
        _totalTokenSupply=100 ether;//100000*10**(decimal);
        balances[owner]=_totalTokenSupply;
        emit Transfer(address(this),owner,_totalTokenSupply);// address(this) means the address of this contract that is deployed 
        // not the address who deploys..
        
    }
    
    function setPrice(uint256 _1_Ether_is_xx_Tokens)public returns(string memory,uint256)
    {
        uint256 show;
        require(msg.sender==owner,"Sorry! owner can set the Price of Token");
        require(_1_Ether_is_xx_Tokens < _totalTokenSupply,"Rate must be less than the total Supply of your available Token");
        rate=_1_Ether_is_xx_Tokens;
        show=1 ether*rate;
        return("Rate of 1 Ether is",show);
    }
    

    function totalSupply()  public view override returns(uint256)
    {
        return _totalTokenSupply;
    }
    
    function balanceOf(address tokenOwner) public override view returns(uint256)
    {
        return (balances[tokenOwner]);
        //return _address.balance;
    }
    
    function transfer(address recipient, uint tokens) public virtual override returns (bool)
    {
        address sender=msg.sender;
        require(recipient!=address(0),"recipient should'nt be Null");
        require(tokens<=balances[sender]);
        require(sender!=address(0),"sender should'ny=t be NULL");
        //require(balances[sender]>tokens,"Amount you are transfering is greater than avaialbe balance");
        
        // it will reduce the amount of token availabel from sender's account...
        balances[sender]=balances[sender]-tokens;
        
        balances[recipient]=balances[recipient]+tokens;
        
        emit Transfer(sender,recipient,tokens);// will be triggered to broadcast the caller that amount has been trasnsferred...
        
        return true;
    }
    function allowance(address tokenOwner, address _spender) public override view returns(uint)
    {
        return allowances[tokenOwner][_spender];// it will return the amount that is allowed...
    }
    
    function approve(address spender, uint amount) public override returns (bool)
    {
        // this method will approve that to hich specific address the owner has allowed an amount to be spent later... 
        address tokenOwner=msg.sender;
        allowances[tokenOwner][spender]=amount;
        
        emit Approval(tokenOwner,spender,amount);
        return true;
    }
    
    function transferFrom(address tokenOwner, address recipient, uint tokens) public override returns(bool)
    {
        address spender=msg.sender;
        uint _allowances = allowances[tokenOwner][spender];
        require(_allowances>tokens,"transfer amount exceeds your current balance");
        _allowances = _allowances-tokens;
        
        balances[tokenOwner]=balances[tokenOwner]-tokens;
        balances[recipient]=balances[recipient]+tokens;
        
        emit Transfer(tokenOwner,recipient,tokens);
        allowances[tokenOwner][spender]=_allowances;
        
        emit Approval(tokenOwner,spender,tokens);
         return true;
    }

    
}