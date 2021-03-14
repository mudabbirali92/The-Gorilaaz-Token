pragma solidity ^0.6.0;
import "./timebound.sol";

contract OwnerShip is TimeLockedWallet
{
    constructor () TimeLockedWallet() public
    {
       owner=msg.sender; 
    }
     function transferOwnership(address _newOwner) public returns (bool)
     {
         require(msg.sender==owner,"Only owner can transfer the OwnerShip of this token!");
         owner=_newOwner;
         return true;
     }
         
}