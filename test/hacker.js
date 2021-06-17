const Fallback = artifacts.require("Fallback");
const Hacker = artifacts.require("Hacker");
const { BN } = require("@openzeppelin/test-helpers");
const { expect } = require("chai");

contract("Hacker", function (accounts) {
  const [owner, hacker] = accounts;

  it("should success to attack", async function () {
    const targetInstance = await Fallback.new({ from: owner });
    const hackerInstance = await Hacker.new({ from: hacker });
    const result = await hackerInstance.attack(targetInstance.address, { from: hacker, value: web3.utils.toWei("1", "ether") });
    expect(result.receipt.status).to.be.equal(true);
    const targetOwner = await targetInstance.owner();
    expect(targetOwner).to.be.equal(hackerInstance.address);
    const targetBalance = await web3.eth.getBalance(targetInstance.address);
    expect(targetBalance).to.be.bignumber.equal(new BN(0));
  });
});
