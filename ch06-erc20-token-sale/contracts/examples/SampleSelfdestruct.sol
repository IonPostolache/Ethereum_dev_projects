// SPDX-License-Identifier: MIT

pragma solidity 0.8.33;

contract StartStopUpdateExample {
    receive() external payable {}

    function destroySmartContract() public {
        selfdestruct(payable(msg.sender));
    }
}
