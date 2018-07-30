
pragma solidity ^0.4.24;

contract StringVsBytes {
    
  string constant _string = "abcdefghijklmnopqrstuvwxyz";
  bytes26 constant _bytes = "abcdefghijklmnopqrstuvwxyz";
  
  function getAsString() public pure returns(string) {
    return _string;
  }
    
  // Note that bytes26 means 26 characters max. Look at the output of both characters. 
  function getAsBytes() public pure returns(bytes32) {
    return _bytes;
  }
    
    
}