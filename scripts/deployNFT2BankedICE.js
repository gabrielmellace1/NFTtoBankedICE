const { ethers } = require("hardhat");
const hre = require("hardhat");

async function main() {
  // Compile the contracts
  await hre.run("compile");

  // Deploy the contract
  const NFT2BankedICE = await ethers.getContractFactory("NFT2BankedICE");



  const nft2bankedice = await NFT2BankedICE.deploy();

  await nft2bankedice.deployed();
  console.log("NFT2BankedICE deployed to:", nft2bankedice.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });


  //npx hardhat run --network polygon scripts/deploy-proxy-marketplace.js
  //npx hardhat verify --network polygon 0x5e81C3DE07c01909DA41a7145f785FaeE7a72b81