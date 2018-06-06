pragma solidity ^0.4.2;

contract DappToken {

    uint256 public totalSupply;
    string public name = "DApp Token";
    string public standard = "DApp Token v1.0";
    string public symbol = "DApp";

    mapping(address => uint256) public balanceOf;
    // Constructor
    constructor(uint256 _initialSupply) public {
        balanceOf[msg.sender] = _initialSupply;
        totalSupply = _initialSupply;
    }
    // Set total number of tokens
    // Read total number of tokens
}