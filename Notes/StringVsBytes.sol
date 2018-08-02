
pragma solidity ^0.4.24;

contract StringVsBytes {
  
  // example IPFS hash
  string constant _string = "QmWmyoMoctfbAaiEs2G46gpeUmhqFRDW6KWo64y5r581Vz";
  bytes constant _bytes = "QmWmyoMoctfbAaiEs2G46gpeUmhqFRDW6KWo64y5r581Vz";
  
  function getAsString() public pure returns(string) {
    return _string;
  }
    
  // Note that bytes26 means 26 characters max. Look at the output of both characters. 
  function getAsBytes() public pure returns(bytes) {
    return _bytes;
  }

  // IPFS notes
  // If you use string to store IPFS hash, you will use 46 bytes (actually 64 since they're allocated in blocks of 32 bytes)
  // When you do getAsBytes(), you get a 94 character string (46*2 + 2 characters for '0x')

  // If you want to store as bytes however, you will first need to decode the IPFS hash.
  // You can choose to decode the IPFS hash to hex or to ASCII but to store on comp, you need to store as hex.

  // If you decode the IPFS hash to hex, you will get a 68 character string.
  // The first 4 characters (1220) is used to identify 2 things.
  // 12 represents the hash function (0x12 - sha2-256)
  // 20 represents the length of the hash in hex. Convert 20 hex to binary and you get 32.
  // You can choose to remove the 1220 from the decoded hex string however you will still need to append '0x' so the computer understands.
  // Whatever you choose, you need to be consistent.  


  // https://incoherency.co.uk/base58/