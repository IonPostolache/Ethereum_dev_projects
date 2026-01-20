import { describe, it, before } from "node:test";
import { network } from "hardhat";
import assert from "node:assert/strict";
import type { WalletClient } from "viem";

describe("Spacebear NFT", function () {
  let viem: Awaited<ReturnType<typeof network.connect>>["viem"];
  let networkHelpers: Awaited<ReturnType<typeof network.connect>>["networkHelpers"];
  let owner: WalletClient;
  let user: WalletClient;

  let ownerAddr: `0x${string}`;
  let userAddr: `0x${string}`;

  before(async () => {
    const connected = await network.connect();
    viem = connected.viem;
    networkHelpers = connected.networkHelpers;

    const wallets = await viem.getWalletClients();
    if (wallets.length < 2) throw new Error("Not enough wallets");

    const rawOwner = wallets[0];
    const rawUser = wallets[1];

    // ensure accounts exist
    if (!rawOwner.account || !rawUser.account) throw new Error("Wallet missing account");

    // extract addresses once
    ownerAddr = rawOwner.account.address;
    userAddr = rawUser.account.address;

    // create properly-typed wallet clients for the addresses
    owner = await viem.getWalletClient(ownerAddr);
    user = await viem.getWalletClient(userAddr);
  });

  // Deploy Spacebear contract once per fixture
  async function deployFixture() {
    async function fixture() {
      const publicClient = await viem.getPublicClient();
      const ownerClient = await viem.getWalletClient(ownerAddr);
      const spacebear = await viem.deployContract("Spacebear", [ownerAddr], {
        client: { public: publicClient, wallet: ownerClient },
      });
      return { spacebear };
    }

    return networkHelpers.loadFixture(fixture);
  }

  it("Owner can mint NFT", async function () {
    const { spacebear } = await deployFixture();

    // Mint NFT to user
    await spacebear.write.safeMint(
      [userAddr , "https://my-nft-uri.com/1.json"],
      { account: owner.account! }
    );

    // Check balance
    const balance = await spacebear.read.balanceOf([userAddr]);
    if (balance !== 1n) throw new Error("Mint failed");
  });

  it("Non-owner cannot mint", async function () {
    const { spacebear } = await deployFixture();

    // Expect revert when non-owner tries to mint
    await assert.rejects(
      () =>
        spacebear.write.safeMint(
          [userAddr, "https://my-nft-uri.com/2.json"],
          { account: user.account! }
        ),
      /OwnableUnauthorizedAccount/
    );
  });
});
