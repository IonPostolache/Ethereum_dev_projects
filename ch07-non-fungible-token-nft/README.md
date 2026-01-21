
## Project Overview – ERC721 NFT (Spacebear)


This project demonstrates the development, testing, and deployment of an **ERC721 NFT** contract called **Spacebear**, implemented using OpenZeppelin contracts and showcased with both **Hardhat 3** and **Foundry**.


### Project Structure
ch07-non-fungible-token-nft/
├── hardhat/        # Hardhat 3 implementation (Viem-based)
└── foundry/        # Foundry implementation (Forge + Script)


---

## Features

### Smart Contract
- ERC721 NFT using OpenZeppelin
- Owner-restricted minting (`Ownable`)
- Token URI storage (`ERC721URIStorage`)
- Base URI support
- Deployed and verified on Sepolia

---

### Hardhat (Hardhat 3)
- Viem-based Hardhat 3 setup
- Local unit tests
- Deployment script
- Sepolia deployment & verification

**Contract Address (Hardhat):**  
https://sepolia.etherscan.io/address/0xaafaa42d54e973912af41e84abf0a1ddf602b508#code

---

### Foundry
- OpenZeppelin as a git dependency
- Forge unit tests
- Forge scripting for deployment
- `.env`-based secrets management
- Sepolia deployment & automatic Etherscan verification

**Contract Address (Foundry):**  
https://sepolia.etherscan.io/address/0x7451d8a0f78e2bb717139d14eb11b5f1eba45721
