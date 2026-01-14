// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.5.0
pragma solidity 0.8.33;

abstract contract ERC20 {
    function transferFrom(address _from, address _to, uint _value) public virtual returns (bool success);
    function decimals() public virtual view returns (uint8);
}

contract TokenSale {

    uint public tokenPriceInWei = 1 ether;

    ERC20 public token;
    address public tokenOwner;

    constructor(address _token) {
        tokenOwner = msg.sender;
        token = ERC20(_token);
    }

    function purchaseACoffe () public payable {
        require(msg.value >= tokenPriceInWei, "Not enough money sent");
        uint tokensToTransfer = msg.value/tokenPriceInWei;
        uint remainder = msg.value - tokensToTransfer * tokenPriceInWei;
        token.transferFrom(tokenOwner, msg.sender, tokensToTransfer * 10 ** token.decimals());
        (bool success, ) = payable(msg.sender).call{value: remainder}("");
        require(success, "ETH refund failed");
    }
}
