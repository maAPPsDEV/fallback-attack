const Fallback = artifacts.require("Fallback");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("Fallback", function (/* accounts */) {
  it("should assert true", async function () {
    await Fallback.deployed();
    return assert.isTrue(true);
  });
});
