// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract SendWithdrawMoney {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender==owner, "not owner");
        _;
    }

    receive() external payable { }
    fallback() external payable { }

    function getBalance () public view returns (uint) {
        return address(this).balance;
    }

    function withdrawAllToCaller () public onlyOwner {
        uint balance = address(this).balance;
        require(balance>0, "No ETH to withdraw");

        (bool success, ) = payable(msg.sender).call{value: balance}("");
        require(success, "ETH transfer to caller failed");
    }

    function withdrawAllToAddress (address _to) public onlyOwner {
        uint balance = address(this).balance;
        require(balance>0, "No ETH to withdraw");

        (bool success, ) = payable(_to).call{value: balance}("");
        require(success, "ETH transfer to address failed");
    }

}

