const Fallback = artifacts.require("Fallback");
const utils = require("./helpers/utils");
const { BN } = require("@openzeppelin/test-helpers");
const { expect } = require("chai");

contract("Fallback", function (accounts) {
  const [owner] = accounts;
  let instance;

  beforeEach(async () => {
    instance = await Fallback.new({ from: owner });
    // instance = await Fallback.deployed();
  });
  it("contract's owner should be the address who deployed the contract.", async () => {
    const contractOwner = await instance.owner();
    expect(contractOwner).to.equal(owner);
  });
  context("contribute", async () => {
    it("should be able to contribute.", async () => {
      const result = await instance.contribute({ from: owner, value: web3.utils.toWei("0.0005", "ether") });
      expect(result.receipt.status).to.equal(true);
    });
    it("should not be able to contribute with more than 0.001 ethers.", async () => {
      await utils.shouldThrow(instance.contribute({ from: owner, value: web3.utils.toWei("0.002", "ether") }));
    });
    it("owner's contribution should be 1000 ethers.", async () => {
      const contribution = await instance.getContribution({ from: owner });
      expect(contribution).to.be.bignumber.equal(new BN(web3.utils.toWei("1000", "ether")));
    });
  });
  it("owner should be able to send ether.", async () => {
    const result = await instance.sendTransaction({ from: owner, value: web3.utils.toWei("1", "ether") });
    expect(result.receipt.status).to.equal(true);
  });
});
