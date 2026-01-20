import "dotenv/config"; // <-- automatically loads .env
import hardhatToolboxViemPlugin from "@nomicfoundation/hardhat-toolbox-viem";
// import { configVariable, defineConfig } from "hardhat/config";
import { defineConfig } from "hardhat/config";
import hardhatVerify from "@nomicfoundation/hardhat-verify";



const sepoliaUrl = process.env.SEPOLIA_RPC_URL;
const sepoliaKey = process.env.SEPOLIA_PRIVATE_KEY;

if (!sepoliaUrl || !sepoliaKey) {
  throw new Error("Missing SEPOLIA_RPC_URL or SEPOLIA_PRIVATE_KEY in .env");
}

export default defineConfig({
  plugins: [hardhatToolboxViemPlugin, hardhatVerify],
  solidity: {
    profiles: {
      default: {
        version: "0.8.28",
      },
      production: {
        version: "0.8.28",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          },
        },
      },
    },
  },
  networks: {
    hardhatMainnet: {
      type: "edr-simulated",
      chainType: "l1",
    },
    hardhatOp: {
      type: "edr-simulated",
      chainType: "op",
    },
    sepolia: {
      type: "http",
      chainType: "l1",
      // url: configVariable("SEPOLIA_RPC_URL"),
      // accounts: [configVariable("SEPOLIA_PRIVATE_KEY")],
      // url: process.env.SEPOLIA_RPC_URL,
      // accounts: [process.env.SEPOLIA_PRIVATE_KEY!],
      url: sepoliaUrl as any,  // cast to satisfy SensitiveString type
      accounts: [sepoliaKey as any],
    },
  },
  verify: {
    etherscan: {
      apiKey: process.env.ETHERSCAN_API_KEY,
      },
  },

});

