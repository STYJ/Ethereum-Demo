pragma solidity ^0.4.24;

contract testingArarys {
    
    
    struct User {
        address[ARRAY_MAX_SIZE] pendingApproval; // used to keep track of what is the mapping
        uint numAddresses;
        mapping(address => uint) index;
        
    }

    
    mapping(address => User) private users;
    uint constant ARRAY_MAX_SIZE = 3;
    
    constructor() public {
        
    }
    
    function requestForApproval(address _requestee) public {
        
        // Check that max number hasn't been hit.
        require((users[_requestee].numAddresses + 1) <= ARRAY_MAX_SIZE);
        
        // Check that requestor hasn't requested previously.
        uint index = users[_requestee].index[msg.sender]; // will default to 0 if uninitialized
        require(users[_requestee].pendingApproval[index] != msg.sender);
        
        // Since the index in pendingApproval is not the requestor, get new index
        index = users[_requestee].numAddresses;
        users[_requestee].pendingApproval[index] = msg.sender; // Add requestor to pendingApproval
        users[_requestee].index[msg.sender] = index; // updating index mapping
        users[_requestee].numAddresses ++; // increment number of addresses
        
        // emit event
    }
    
    // Note that order within the array doesn't matter for me that's why I'm able to do this.
    function removeRequest(address _requestor) public {
        
        // Check that the min num hasn't been hit
        require((users[msg.sender].numAddresses - 1) >= 0);
        
        // Check that the requestor exists
        uint index = users[msg.sender].index[_requestor];
        require(users[msg.sender].pendingApproval[index] == _requestor);
        
        // Replace last address with the requestor's index from pendingApproval, update index mapping then remove last index
        uint lastIndex = users[msg.sender].numAddresses - 1;
        address lastAddress = users[msg.sender].pendingApproval[lastIndex];
        users[msg.sender].pendingApproval[index] = lastAddress;
        users[msg.sender].index[lastAddress] = index;
        
        // delete last index and reduce size
        delete users[msg.sender].pendingApproval[lastIndex];
        users[msg.sender].numAddresses --;
        
    }
    
    function getRequests(address _requestee) public view returns (address[ARRAY_MAX_SIZE], uint) {
        return (users[_requestee].pendingApproval, users[_requestee].numAddresses);
    }
}