pragma solidity ^0.6.0;

interface ERC20
{
    // returns amount of existence tokens...
    function totalSupply() external view returns(uint256);
    // returns the balanceOf of specified address...
    function balanceOf(address _address) external view returns(uint256);
    // returen true if amount is successfully transfered to sepecified address...
    function transfer(address recipient, uint amount) external returns (bool);
    // allow spender to send ether on behalg of owner of the account or address..
    function allowance(address owner, address spender) external view returns(uint);
    // emits on approving specific address to become a sender on your behalf...
    function approve(address spender, uint amount) external returns (bool);
    // with allownace method you will be transfering amount from onwers account to recipient...
    function transferFrom(address spender, address recipient, uint amount) external returns(bool);
    
    event Transfer(address indexed from ,address indexed to, uint256 value);
    
    event Approval (address indexed owner, address indexed spender, uint256 value);
    event Bought(address indexed owner,address indexed buyer,uint256 value);
    event Sold(uint256 amount); 
}