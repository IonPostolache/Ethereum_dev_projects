// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.28;

import "forge-std/Script.sol";
import "../src/Spacebear.sol";

contract SpacebearScript is Script {
    function setUp() public {}

    function run() public {
        // string memory seedPhrase = vm.readFile(".env");
        // uint256 privateKey = vm.deriveKey(seedPhrase, 0);
        // uint256 privateKey = vm.envUint("SEPOLIA_RPC_URL");
        // string memory rpcUrl = vm.envString("SEPOLIA_RPC_URL");
        uint256 privateKey = uint256(vm.envBytes32("SEPOLIA_PRIVATE_KEY"));

        vm.startBroadcast(privateKey);
        // Spacebear spacebear = new Spacebear();
        // Spacebear spacebear = new Spacebear(msg.sender);
        new Spacebear(msg.sender);

        vm.stopBroadcast();
    }
}