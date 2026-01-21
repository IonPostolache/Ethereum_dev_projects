import { network } from "hardhat";

async function main() {
  const connected = await network.connect();
  const viem = connected.viem;

  const [deployer] = await viem.getWalletClients();

  if (!deployer?.account) {
    throw new Error("No deployer account found");
  }

  console.log("Deployer address:", deployer.account.address);
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});



