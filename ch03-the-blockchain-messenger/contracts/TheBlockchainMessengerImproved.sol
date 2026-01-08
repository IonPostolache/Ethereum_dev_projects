// SPDX-License-Identifier: MIT

pragma solidity 0.8.30;

contract BlockchainMessenger {
    // Address of the person who deployed the contract
    address public owner;

    // The stored message
    string private message;

    // Number of times the message was modified
    uint256 public messageUpdateCount;

    // Event emitted whenever the message changes
    event MessageUpdated(
        address indexed updater,
        string newMessage,
        uint256 updateCount
    );

    // Constructor runs once, at deployment
    constructor(string memory initialMessage) {
        owner=msg.sender;
        message = initialMessage;
        messageUpdateCount = 0;
    }

    // Modifier to restrict access to owner only
    modifier onlyOwner() {
        require (msg.sender==owner, "Not the contract owner");
        _;
    }

    // Anyone can read the message
    function readMessage() external view returns (string memory) {
        return message;
    }

    // Only the owner can update the message
    function updateMessage(string calldata newMessage) external onlyOwner{
        message = newMessage;
        messageUpdateCount++;

        emit MessageUpdated(msg.sender, newMessage, messageUpdateCount);
    }


}

