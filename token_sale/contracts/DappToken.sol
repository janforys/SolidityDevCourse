pragma solidity ^0.4.2;

contract DappToken {

    uint256 public totalSupply;
    string public name = "DApp Token";
    string public standard = "DApp Token v1.0";
    string public symbol = "DApp";

    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 _value
    );

    mapping(address => uint256) public balanceOf;
    // Constructor
    constructor(uint256 _initialSupply) public {
        balanceOf[msg.sender] = _initialSupply;
        totalSupply = _initialSupply;
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value);
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        Transfer(msg.sender, _to, _value);
        return true;
    }
    
}