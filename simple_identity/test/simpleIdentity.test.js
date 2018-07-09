var SimpleIdentity = artifacts.require('SimpleIdentity')

contract('SimpleIdentity', function(accounts) {

    const owner = accounts[0]
    const alice = accounts[1]
    const bob = accounts[2]

    var numIdentities

    // Testing the addIdentity() function
    it("Add an identity with the provided name and age", async() => {
        const simpleIdentity = await SimpleIdentity.deployed()

        var eventName = ""

        var event = simpleIdentity.LogNewIdentity()

        // Trying to add first identity
        await event.watch((err, res) => {
            // Watching for the numIdentities arg in the event
            // convert to a string with radix / base 10
            // Radix base2 = in binary notation e.g. 0 or 1
            // If you still don't know what I'm talking about, run your solidity code in remix and see log. 
            numIdentities = res.args.numIdentities.toString(10)
            eventName = res.event
        })

        const name = "Alice"
        const age = 20

        await simpleIdentity.addIdentity(name, age, {from: alice})

        const result = await simpleIdentity.getIdentity({from:alice})
        assert.equal(result[0], name, 'the name of the identity added does not match the expected value')
        assert.equal(result[1], age, 'the age of the identity added does not match the expected value')
        assert.equal(numIdentities, 1, 'the number of identities in the contract does not match the expected value')
        assert.equal(eventName, "LogNewIdentity", 'adding an identity should emit a LogNewIdentity event')

        // Trying to add an identity when there's already one
        try {
          await simpleIdentity.addIdentity("Alice 2", 22, {from: alice})
          assert.fail('Expected revert not received');
        }
        catch (error) {
          const revertFound = error.message.search('revert') >= 0;
          assert(revertFound, `Expected "revert", got ${error} instead`);
        }
        

    })

    // Testing the updateName() functions
    it("Update an existing identity with the updated name", async() => {
        const simpleIdentity = await SimpleIdentity.deployed()

        var eventName = ""

        var event = simpleIdentity.LogUpdatedIdentityName()

        await event.watch((err, res) => {
            numIdentities = res.args.numIdentities.toString(10)
            eventName = res.event
        })

        const updatedName = "Alice Updated"

        await simpleIdentity.updateName(updatedName, {from: alice})

        const result = await simpleIdentity.getIdentity({from:alice})
        assert.equal(result[0], updatedName, 'the updated name of the identity added does not match the expected value')
        assert.equal(eventName, "LogUpdatedIdentityName", 'adding an identity should emit a LogUpdatedIdentityName event')

        // Trying to update an identity's name when identity doesn't exist
        try {
          await simpleIdentity.updateName("Bob", {from: bob})
          assert.fail('Expected revert not received');
        }
        catch (error) {
          const revertFound = error.message.search('revert') >= 0;
          assert(revertFound, `Expected "revert", got ${error} instead`);
        }

    })

    // Testing the updateAge() functions
    it("Update an existing identity with the updated age", async() => {
        const simpleIdentity = await SimpleIdentity.deployed()

        var eventName = ""

        var event = simpleIdentity.LogUpdatedIdentityAge()

        await event.watch((err, res) => {
            numIdentities = res.args.numIdentities.toString(10)
            eventName = res.event
        })

        const updatedAge = 22

        await simpleIdentity.updateAge(updatedAge, {from: alice})

        const result = await simpleIdentity.getIdentity({from:alice})
        assert.equal(result[1], updatedAge, 'the updated age of the identity added does not match the expected value')
        assert.equal(eventName, "LogUpdatedIdentityAge", 'adding an identity should emit a LogUpdatedIdentityAge event')

        // Trying to update an identity's age when identity doesn't exist
        try {
          await simpleIdentity.updateAge(25, {from: bob})
          assert.fail('Expected revert not received');
        }
        catch (error) {
          const revertFound = error.message.search('revert') >= 0;
          assert(revertFound, `Expected "revert", got ${error} instead`);
        }

    })

    // Testing the removeIdentity() functions
    it("Delete an existing identity", async() => {
        const simpleIdentity = await SimpleIdentity.deployed()

        var eventName = ""

        var event = simpleIdentity.LogDeletedIdentity()

        await event.watch((err, res) => {
            numIdentities = res.args.numIdentities.toString(10)
            eventName = res.event
        })

        await simpleIdentity.removeIdentity({from: alice})

        assert.equal(numIdentities, 0, 'the number of identities in the contract does not match the expected value')
        assert.equal(eventName, "LogDeletedIdentity", 'adding an identity should emit a LogDeletedIdentity event')

        // Trying to remove an identity when identity doesn't exist
        try {
          await simpleIdentity.removeIdentity({from: bob})
          assert.fail('Expected revert not received');
        }
        catch (error) {
          const revertFound = error.message.search('revert') >= 0;
          assert(revertFound, `Expected "revert", got ${error} instead`);
        }

    })

});
