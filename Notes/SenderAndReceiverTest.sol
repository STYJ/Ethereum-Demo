pragma solidity ^0.4.24;

contract Sender {
    
    constructor () public payable {
        // Constructor is payable so you can initiate the contract with some ether.
    }
    
    function send(address _receiver, uint amt) public payable {
        _receiver.transfer(amt);
    }
    
    // If the transaction that you used to initiate send contains ether (msg.value) then it will take those from msg.value first before taking those in this contract's balance.
    // If you initiate a 5 eth transfer and provide 5 ether in the txn, this contract's balance is intact.
    // If you initiate a 5 eth transfer but provide 0 ether in the txn, this contract's balance will - 5 ether.
    // If you initiate an 8 eth transfer but provide 5 ether in the txn, this contract's balance will - 3 ether.
    
    function send(address _receiver) public payable {
        _receiver.transfer(msg.value);
    }
    
    function checkBalance() public view returns (uint256) {
        return address(this).balance;
        
    }
}

contract Receiver {

    event LogDeposit(address _sender);
    
    function checkBalance() public view returns (uint256) {
        return address(this).balance;
        
    }
    
    // If you comment out this function, Receiver contract cannot receive ether.
    function () public payable {
        emit LogDeposit(msg.sender);
    }
    
    
}