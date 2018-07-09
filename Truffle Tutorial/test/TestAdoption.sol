pragma solidity ^0.4.17;

// https://truffleframework.com/tutorials/pet-shop

import "truffle/Assert.sol"; // assertions included with Truffle, global truffle file
import "truffle/DeployedAddresses.sol"; // This SC gets the address of the deployed contract, global truffle file
import "../contracts/Adoption.sol";

contract TestAdoption {
  Adoption adoption = Adoption(DeployedAddresses.Adoption()); // create a global variable containing the SC to be tested. Use DeployedAddresses to get address of the deployed SC.

	// Testing the adopt() function, adopt function is supposed to return a petId
	function testUserCanAdoptPet() public {
		uint returnedId = adoption.adopt(8);
		uint expected = 8;
		Assert.equal(returnedId, expected, "Adoption of pet ID 8 should be recorded.");
	}

	// Testing retrieval of a single pet's owner
	function testGetAdopterAddressByPetId() public {
		// Expected owner is this contract
		address expected = this;
		address adopter = adoption.adopters(8);
		Assert.equal(adopter, expected, "Owner of pet ID 8 should be recorded.");
	}

	// Testing retrieval of all pet owners
	function testGetAdopterAddressByPetIdInArray() public {
		// Expected owner is this contract but why?
		address expected = this;

		// Store adopters in memory rather than contract's storage
		address[16] memory adopters = adoption.getAdopters();

		Assert.equal(adopters[8], expected, "Owner of pet ID 8 should be recorded.");
	}
}