// SPDX-License-Identifier: MIT

pragma solidity 0.8.30;

contract SampleFallback {
    uint public lasValueSent;
    string public lastFunctionCalled;

    uint public myUint;

    function setMyUint(uint _myNewUint) public  {
        myUint=_myNewUint;
    }

    receive() external payable {
        lasValueSent=msg.value;
        lastFunctionCalled = "receive";
    }

    fallback() external payable {
        lasValueSent = msg.value;
        lastFunctionCalled="fallback";
     } 

}