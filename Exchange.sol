pragma solidity ^0.6.0;

import "./GorillazToken.sol";

contract ExchangeToken is TheGorillazToken
{
    
    constructor () TheGorillazToken() public
    {
        
    }
        // it will receive ethers if spender spends with ether gainast tokens...
    receive () external payable
    {
        emit Received("Ethers Received by Smart contract");
    }
    
    function contracBalance() public view returns(uint)
    {
        return address(this).balance;
    }
    
    
    // function to buy tokens against ether and the price of 1 ether is 10 GORILLA Tokens
    function buyTokens() payable public returns(bool,uint)
    {
     address inverstor=msg.sender;
     require(msg.value<balances[owner],"The amount you entered is greater than avaialbe balance");
     uint tokens=msg.value*rate;// the price of my token...
     balances[owner]=balances[owner]-tokens;
     balances[inverstor]=balances[inverstor]+tokens;
     emit Bought(owner,inverstor,tokens);// will be triggered to broadcast the caller that amount has been trasnsferred...
     return (true,tokens);
     }
    
    
    // function to buy tokens against ether and the price of 1 ether is 10 GORILLA Tokens
    function sellTokens(uint tokens) public returns(bool,uint)
    {
        require(balances[msg.sender]>tokens,"Sorry! Either you have exceed your avaialbe amount or you are not part of this token");
        balances[msg.sender]=balances[msg.sender]-tokens;
        uint ethers=tokens/rate;// that is similar to tokens/ 10....
        payable(msg.sender).transfer(ethers);
        balances[owner]=balances[owner]+tokens;
        emit Sold(tokens);
        return (true,ethers);
    
    }
    
    // remember when ethers are zero in contract's address then you wont be able to sell your tokens cuz contract doesnt have any ethers to exchange with... 
}