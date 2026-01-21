// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;
 
import "forge-std/Test.sol";
import "../src/Spacebear.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
 
contract SpacebearsTest is Test, IERC721Receiver {
 
    Spacebear spacebear;
    
    function setUp() public {
        spacebear = new Spacebear(address(this));
    }
 
    function testNameIsSpacebear() public view {
        assertEq(spacebear.name(), "Spacebear");
    }

    function testMintingNFTs() public {
        spacebear.safeMint(address(this));
        assertEq(spacebear.ownerOf(0), address(this));
        assertEq(spacebear.tokenURI(0), "https://ethereum-blockchain-developer.com/2022-06-nft-truffle-hardhat-foundry/nftdata/spacebear_1.json");
    }

    function testNftCreationWrongOwner() public {
        vm.startPrank(address(0x1));
        vm.expectRevert(abi.encodeWithSignature("OwnableUnauthorizedAccount(address)", address(0x1)));
        spacebear.safeMint(address(0x1));
        vm.stopPrank();
    }

    function testNftBuyToken() public {
        vm.deal(address(0x1), 1 ether);
        vm.startPrank(address(0x1));
        spacebear.buyToken{value: 0}();
        vm.stopPrank();
        assertEq(spacebear.ownerOf(0), address(0x1));
    }

    function onERC721Received(address, address, uint256, bytes calldata) public pure returns (bytes4) {
        return IERC721Receiver.onERC721Received.selector;
    }
}