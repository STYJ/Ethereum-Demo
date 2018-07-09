pragma solidity ^0.4.10;

contract SimpleIdentity{

	mapping(address => Identity) private identities;
	uint public numIdentities;
	address public contractOwner;

	// Struct for Identity
	struct Identity {
		string name;
		uint age;
	}

	// Events
	event LogNewIdentity(string _name, uint _age, uint numIdentities);
	event LogDeletedIdentity(string _deletedName, uint _deletedAge, uint numIdentities);
	event LogUpdatedIdentityName(string _updatedName, uint _age, uint numIdentities);
	event LogUpdatedIdentityAge(string _name, uint _updatedAge, uint numIdentities);

	// Modifiers
	// Checks that age is > 0
	// This check is useless, you should check on the web3 end.
	// The reason being if you pass a negative number into uint, it will be converted into a very large positive uint
	// The require statement will never fail. 
	// For example, if you did positiveAge(-4) and within some other function, you added 10 to the age, your age will be 6. 
	// This is a very clear example of integer overflow. Without the +10 (or any number bigger than the modulus of your negative number)
	// you will return an extremely large positive uint.
	modifier positiveAge(uint _age)
	{
		require(_age > 0);
		_;
	}
	// Checks that this address doesn't have any previous identity
	modifier noPreviousIdentity()
	{
		require(bytes(identities[msg.sender].name).length == 0 && identities[msg.sender].age == 0);
		_;
	}
	// Checks that this address contain an identity
	modifier identityExist()
	{
		require(bytes(identities[msg.sender].name).length != 0 && identities[msg.sender].age != 0);
		_;
	}

	constructor() 
		public
	{
		contractOwner = msg.sender;
		numIdentities = 0;
	}

	// Add identity
	function addIdentity(string _name, uint _age) 
		public 
		noPreviousIdentity() 
		// positiveAge(_age)
		returns (uint)
	{
		numIdentities += 1;
		emit LogNewIdentity(_name, _age, numIdentities);
		identities[msg.sender] = Identity({name: _name, age:_age});
		return numIdentities;
	}

	// Remove identity
	function removeIdentity()
		public
		identityExist()
		returns (uint)
	{
		numIdentities -= 1;
		emit LogDeletedIdentity(identities[msg.sender].name, identities[msg.sender].age, numIdentities);
		delete identities[msg.sender];
		return numIdentities;
	}

	// Update name
	function updateName(string _name)
		public
		identityExist()
		returns (string, uint)
	{
		emit LogUpdatedIdentityName(_name, identities[msg.sender].age, numIdentities);
		identities[msg.sender].name = _name;
		// Cannot return struct unless it's used within contract so you have to return individual elements
		return(identities[msg.sender].name, identities[msg.sender].age);
	}

	// Update age
	function updateAge(uint _age)
		public
		identityExist()
		// positiveAge(_age)
		returns (string, uint)
	{
		emit LogUpdatedIdentityAge(identities[msg.sender].name, _age, numIdentities);
		identities[msg.sender].age = _age;
		return(identities[msg.sender].name, identities[msg.sender].age);
	}

	// Get identity and for testing purposes!
	function getIdentity()
		public
		view
		identityExist()
		returns (string, uint)
	{
		return(identities[msg.sender].name, identities[msg.sender].age);
	}


}