import { network } from "hardhat";

async function main() {
  const connected = await network.connect();
  const viem = connected.viem;

  // Get deployer wallet
  const [deployer] = await viem.getWalletClients();

  if (!deployer?.account) {
    throw new Error("Deployer wallet has no account");
  }

  const deployerAddress = deployer.account.address;

  console.log("Deploying Spacebear...");

  console.log("Deployer:", deployerAddress);

  // Create properly-typed clients
  const deployerClient = await viem.getWalletClient(deployerAddress);
  const publicClient = await viem.getPublicClient();

  // Deploy contract
  const spacebear = await viem.deployContract("Spacebear", [deployerAddress], {
    client: { public: publicClient, wallet: deployerClient },
  });

  console.log("✅ Spacebear deployed");
  console.log("Contract address:", spacebear.address);

  // Optional: sanity check
  const owner = await spacebear.read.owner();
  console.log("Contract owner:", owner);
}

main().catch((error) => {
  console.error("❌ Deployment failed");
  console.error(error);
  process.exit(1);
});
