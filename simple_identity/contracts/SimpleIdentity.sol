pragma solidity ^0.4.10;

contract SimpleIdentity{

	mapping(address => Identity) private identities;
	int public numIdentities;
	address public contractOwner;

	// Struct for Identity
	struct Identity {
		string name;
		int age;
	}

	// Events
	event LogNewIdentity(string _name, int _age, int numIdentities);
	event LogDeletedIdentity(string _deletedName, int _deletedAge, int numIdentities);
	event LogUpdatedIdentityName(string _updatedName, int _age, int numIdentities);
	event LogUpdatedIdentityAge(string _name, int _updatedAge, int numIdentities);

	// Modifiers
	// Checks that age is > 0
	// This check is useless if your parameter is of type uint because when a negative value is casted to a uint, you get a very large int number
	// This require statement can never fail. 
	// The solution to this is to use int instead of uint. 
	// By default, int is int256
	modifier positiveAge(int _age)
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
	function addIdentity(string _name, int _age) 
		public 
		noPreviousIdentity() 
		positiveAge(_age)
		returns (int)
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
		returns (int)
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
		returns (string, int)
	{
		emit LogUpdatedIdentityName(_name, identities[msg.sender].age, numIdentities);
		identities[msg.sender].name = _name;
		// Cannot return struct unless it's used within contract so you have to return individual elements
		return(identities[msg.sender].name, identities[msg.sender].age);
	}

	// Update age
	function updateAge(int _age)
		public
		identityExist()
		positiveAge(_age)
		returns (string, int)
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
		returns (string, int)
	{
		return(identities[msg.sender].name, identities[msg.sender].age);
	}


}