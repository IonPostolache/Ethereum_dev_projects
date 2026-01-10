// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract SendWithdrawMoney {
    uint public depositOnSC;
    uint public myBalance;
    uint public withdrawFromSC;

    function setDepositValue(uint _depositOnSC) public {
        depositOnSC = _depositOnSC;
    }
    receive() external payable {
        myBalance= msg.value;
    }
    fallback() external payable { 
        myBalance=msg.value;
    }
    function withdrawAll() public payable {
        withdrawFromSC=msg.value;
        require (address(this).balance>=withdrawFromSC, "Not enough balance to withdraw");
        payable (msg.sender).transfer(withdrawFromSC);
    }
}

