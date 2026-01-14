// SPDX-License-Identifier: MIT

pragma solidity 0.8.30;

contract ContractOne {

    mapping (address => uint) public addressBalances;

    function deposit() public payable  {
        addressBalances[msg.sender] +=msg.value;
    }
}

contract ContractTwo {

    receive() external payable {}

    function depositOnContractOne(address _contractOne) public {
        ContractOne one = ContractOne(_contractOne);
        one.deposit{value: 10, gas: 100000}();
    }
}

