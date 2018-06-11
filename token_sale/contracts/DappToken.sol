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

    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;
    
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

    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_value <= balanceOf[_from]);    // Require _from has enough tokens
        require(_value <= allowance[_from][msg.sender]);    // Require allowance is big enough
        balanceOf[_from] -= _value;     
        balanceOf[_to] += _value;        // Change the balance
        allowance[_from][msg.sender] -= _value;     // Update the allowance
        Transfer(_from, _to, _value);   // Transfer event
        return true;    // Return a boolean
    }
    
}