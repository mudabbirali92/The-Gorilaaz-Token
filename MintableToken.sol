pragma solidity ^0.6.0;

//import "./GorillazToken.sol";
import "./Exchange.sol";

contract MintableToken is ExchangeToken
{
    constructor (uint256 totalSupply) ExchangeToken() public // if you dont declare the constructor of parent class then error will be generetaed 
    // by prompting that you need to mark it as absratact contract...
    {
        
    }
    function mint(address recipient, uint256 amount) public returns (uint256)
    {
        require(msg.sender==owner,"Only owner is allowed to deploy it");
        require (recipient!=address(0),"Invalide Address");
        require (amount > 0,"Please provide some mintable amount");
        _totalTokenSupply=_totalTokenSupply+amount;
        balances[recipient]=balances[recipient]+amount;
        emit Transfer(address(this), recipient, amount);
        // so from above statements w can conclude that whosoever mine the token, will be transfer from this contract addrss to miner ie."to" in thiscase... 
    }
}