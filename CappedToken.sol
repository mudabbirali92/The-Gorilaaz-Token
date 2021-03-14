pragma solidity ^0.6.0;
/*
Now we will capp te token means at some limit no one can min the token s further just like in case of bitcoin 
i.e. having cap value 21 million bitcoins...
So for this example we can just cap the token to 2 times the initial supply of the token...
Remeber: to cap your token you will need to have a mint function written. Otherwise you can not capp t unitil you mint it
mint means mining the token..
*/ 
import "./MintableToken.sol";

contract CappedToken is MintableToken
{
    constructor () MintableToken(_totalTokenSupply) public// now here we will be using the totalsupply of base ERC20
    // that is why we declared the uint256 totalsupply in the constructor of MintableToken contract ....
    {
        cap=_totalTokenSupply*2;
    }
    uint public cap;
    function generateToken(address to, uint amount) external
    {
        // Now we will allow miners to mine but will limit them that they can not mine more than caped limit
        // in which our available total supply 
        require(_totalTokenSupply+amount<=cap,"Amount exceeds! amount you required for mining exceeds the cap limit");
        mint(to,amount);// this method has been used from parent class named MintableToken...
    }
    
}