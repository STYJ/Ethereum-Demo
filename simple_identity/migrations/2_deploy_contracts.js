//var SimpleBank = artifacts.require("./SimpleBank.sol");
var SimpleIdentity = artifacts.require("./SimpleIdentity.sol");

module.exports = function(deployer) {
  //deployer.deploy(SimpleBank);
  deployer.deploy(SimpleIdentity);
};
