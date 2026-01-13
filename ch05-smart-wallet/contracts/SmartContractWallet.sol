// SPDX-License-Identifier: MIT

// These are the requirements:
// The wallet has one owner
// The wallet should be able to receive funds, no matter what (with a fallback function)
// It is possible for the owner to spend funds on any kind of address, no matter if its a 
// so-called Externally Owned Account (EOA - with a private key), or a Contract Address.
// It should be possible to allow certain people to spend up to a certain amount of funds (allowance functionality).
// It should be possible to set the owner to a different address by a minimum of 3 out of 5 guardians, in case funds are lost.

pragma solidity 0.8.30;

contract SmartContractWallet {
    address public owner;

    mapping(address => uint) public allowance;

    address[] public guardians;
    mapping(address => bool) public isGuardian;

    mapping(address => mapping(address =>bool)) public guardianVotes;
    mapping(address =>uint) public voteCount;

    constructor(address[] memory _guardians) {
        require(_guardians.length ==5, "Need exactly 5 guardians");

        owner = msg.sender;

        for (uint i=0; i<5; i++) {
            guardians.push(_guardians[i]);
            isGuardian[_guardians[i]]=true;
        }
    }

    modifier onlyOwner() {
        require(msg.sender==owner, "not owner");
        _;
    }
    modifier onlyGuardian() {
        require(isGuardian[msg.sender], "Not guardian");
        _;
    }

    receive() external payable { }
    fallback() external payable { }


    function setAllowance(address _spender, uint _amount) external onlyOwner {
        allowance[_spender]=_amount;
    }
    function _sendETH (address _to, uint amount) internal {
        require(address(this).balance>=amount, "Insufficient balance");
        (bool success, ) = payable(_to).call{value: amount}("");
        require(success, "ETH transfer failed");
    }
    function withdraw(uint amount) external {
        require(msg.sender==owner || allowance[msg.sender]>= amount, "Not allowed");
        if (msg.sender != owner) {
            allowance[msg.sender] -=amount;
        }
        _sendETH(msg.sender, amount);
    }
    function getBalance () public view returns (uint) {
        return address(this).balance;
    }



    function _resetVotes(address _newOwner) internal {
        for (uint i=0; i< guardians.length; i++) {
            guardianVotes[_newOwner][guardians[i]] = false;
        }
        voteCount[_newOwner]=0;
    }

    function proposeNewOwner(address _newOwner) external onlyGuardian {
        require(!guardianVotes[_newOwner][msg.sender], "Already voted");

        guardianVotes[_newOwner][msg.sender]=true;
        voteCount[_newOwner]++;

        if (voteCount[_newOwner]>=3) {
            owner = _newOwner;
            _resetVotes(_newOwner);
        }
    }
}
