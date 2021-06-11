// SPDX-License-Identifier: MIT
pragma solidity >=0.8.5 <0.9.0;

contract Fallback {

  mapping(address => uint) public contributions;
  address payable public owner;

  constructor() {
    owner = payable(msg.sender);
    contributions[msg.sender] = 1000 * (1 ether);
  }

  modifier onlyOwner {
    require(
      msg.sender == owner,
      "caller is not the owner"
    );
    _;
  }

  event NewOwner(address _newOwner);

  function contribute() public payable {
    require(msg.value < 0.001 ether);
    contributions[msg.sender] += msg.value;
    if (contributions[msg.sender] > contributions[owner]) {
      owner = payable(msg.sender);
      emit NewOwner(msg.sender);
    }
  }

  function getContribution() public view returns (uint) {
    return contributions[msg.sender];
  }

  function withdraw() public onlyOwner {
    owner.transfer(address(this).balance);
  }

  fallback() external payable {
    require(msg.value > 0 && contributions[msg.sender] > 0);
    owner = payable(msg.sender);
    emit NewOwner(msg.sender);
  }
}
