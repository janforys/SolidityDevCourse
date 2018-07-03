pragma solidity ^0.4.17;


contract CrowdfundFactory {
    address[] public deployedCrowdfunds;
    
    function createCrowdfund(uint minimum) public {
        address newCrowdfund = new Crowdfund(minimum, msg.sender);
        deployedCrowdfunds.push(newCrowdfund);
    }
    
    function getDeployedCrowdfunds() public view returns (address[]) {
        return deployedCrowdfunds;
    }
}

contract Crowdfund {
    struct Request {
        string description;
        uint value;
        address recipient;
        bool isComplete;
        uint approvalCount;
        mapping(address => bool) approvals;
    }
    
    Request[] public requests;
    address public manager;
    uint public minimumContribution;
    mapping(address => bool) public approvers;
    uint public approversCount;
    
    modifier restricted() {
        require(msg.sender == manager);
        _;
    }
    
    function Crowdfund(uint minimum, address creator) public {
        manager = creator;
        minimumContribution = minimum;
    }
    
    function contribute() public payable {
        require(msg.value > minimumContribution);
        approvers[msg.sender] = true;
        approversCount++;
    }
    
    function createRequest(string description, uint value, address recipient) 
        public restricted {
        Request memory newRequest = Request({
           description: description,
           value: value,
           recipient: recipient,
           isComplete: false,
           approvalCount: 0
        });
        
        requests.push(newRequest);
    }
    
    function approveRequest(uint index) public {
        Request storage request = requests[index];
        
        require(approvers[msg.sender]);
        require(!request.approvals[msg.sender]);
        
        request.approvals[msg.sender] = true;
        request.approvalCount++;
    }
    
    function finalizeRequest(uint index) public restricted {
        Request storage request = requests[index];
        
        require(request.approvalCount > (approversCount / 2));
        require(!request.isComplete);
        
        request.recipient.transfer(request.value);
        request.isComplete = true;
    }
}