const Hacker = artifacts.require("Hacker")

module.exports = function(_deployer, _network, _accounts) {
  const [_, hacker] = _accounts;

  // Deploy Hacker contract from another account.
  _deployer.deploy(Hacker, {from: hacker})
};
