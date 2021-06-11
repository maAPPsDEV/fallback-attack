const Fallback = artifacts.require("Fallback")
const Hacker = artifacts.require("Hacker")

module.exports = function(_deployer, _network, _accounts) {
  // Use deployer to state migration tasks.
  _deployer.deploy(Fallback)

  // Deploy Hacker contract from another account.
  _deployer.deploy(Hacker, {from: _accounts[1]})
};
