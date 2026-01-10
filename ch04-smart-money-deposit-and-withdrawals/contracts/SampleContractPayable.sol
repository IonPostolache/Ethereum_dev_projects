// SPDX-License-Identifier: MIT
// In the previus code I didn't receive back the ETH sent when sending >1 ETH.
// In this version I've updated the code so that it works.
// I am using Remix IDE Desktop, while in the course was Remix IDE in the browser.

pragma solidity 0.8.30;

contract SampleContract {
    string public myString = "Hello World";
    
    function updateString (string memory _newString) public payable {
        if(msg.value==1 ether) {
            myString=_newString; 
        } else {
            uint256 refund = msg.value;
            require (address(this).balance>= refund, "Not enough balance to refund");
            payable (msg.sender).transfer(refund);
        }
    }
}