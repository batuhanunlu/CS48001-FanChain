// deploy the contract that we created in contracts folder called Voting
var Election = artifacts.require("./Voting.sol");
module.exports = function(deployer) {
  deployer.deploy(Voting);
};
