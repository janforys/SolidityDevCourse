pragma solidity ^0.4.17;

contract Lottery
{
   address public manager;
   address[] public players;
   
   function Lottery() public{
        manager = msg.sender;
   }
   
   function Enter() public payable{
       require(msg.value > .01 ether);
       players.push(msg.sender);
   }
   
   function Random() public view returns (uint){      // returns us a random number
       return uint(sha3(block.difficulty, now, players));    // hashing function that returns an uint
   }
   
   function pickWinner() public{
       require(msg.sender == manager);
       uint index = Random() % players.length;
       players[index].transfer(this.balance);
       players = new address[](0);
   }
   
   modifier restricted(){
       require(msg.sender == manager);
       _;
   }
 
   function getPlayers() public view returns(address[]) {
         return players;
   }
}
