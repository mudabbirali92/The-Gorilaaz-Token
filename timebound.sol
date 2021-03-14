pragma solidity ^0.6.0;

import "./CappedToken.sol";
contract TimeLockedWallet is CappedToken
{
    event Receved(address , uint );
    event Withdrew(address,uint);
    
    constructor() public
    {
        owner=msg.sender;
    }
    
    address public creator;
    uint public unlockDate;
    uint public createdAt;
    
    function TimeLocked(address _creator, address _owner, uint _unlockDate) public
    {
        creator = _creator;
        owner = _owner;
        unlockDate = now+_unlockDate;
        createdAt = now;// this keywor now we captured the current date when this contract is deployed...
    }
   
    function info() public view returns(address, address, uint, uint, uint) 
    {
        return (creator, owner, unlockDate, createdAt, address(this).balance);
    }
    
    function withdraw() public
    {
        require(msg.sender==owner,"Only owner is allowed to withdraw the amount");
        require(now >= unlockDate);
        msg.sender.transfer(address(this).balance);
        Withdrew(msg.sender, address(this).balance);
    }
   }