pragma solidity ^0.4.13;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/SimpleIdentity.sol";

contract TestSimpleIdentity {

    // Test for failing conditions in this contracts
    // Test that every modifier is working and the correct events are emitted
    // Test that each function is working correctly

    // addIdentity 
    // test for successfully adding an identity
    // test for failure if the user already has a previous identity 

    // removeIdentity
    // test for successfully removing an identity
    // test for failure if the user does not have a previous identity

    // updateName / updateAge
    // test for failure if the user's name / age is not updated correctly

}
