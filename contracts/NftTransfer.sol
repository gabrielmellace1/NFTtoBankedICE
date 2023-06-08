// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./EIP712MetaTransaction.sol";

contract NFT2BankedICE is Ownable, EIP712MetaTransaction {
    address public beneficiary;
    mapping(address => bool) public whitelistedNFTs;

    event NftTransferred(
        address indexed from,
        address indexed to,
        address indexed nftAddress,
        uint256 tokenId
    );

    constructor() EIP712Base("NFT2BankedICE", "v1.0") {
        beneficiary = 0xEA5Fed1D0141F14DE11249577921b08783d6A360; // Set the beneficiary address here
    }

    function changeBeneficiary(address _newBeneficiary) external onlyOwner {
        beneficiary = _newBeneficiary;
    }

    function addWhitelistedNFT(address _nftAddress) external onlyOwner {
        whitelistedNFTs[_nftAddress] = true;
    }

    function removeWhitelistedNFT(address _nftAddress) external onlyOwner {
        whitelistedNFTs[_nftAddress] = false;
    }

    function transferNFT(address _nftAddress, uint256 _tokenId) external {
        require(whitelistedNFTs[_nftAddress], "NFT is not whitelisted");
        IERC721 nftContract = IERC721(_nftAddress);
        nftContract.safeTransferFrom(msg.sender, beneficiary, _tokenId);
        emit NftTransferred(msg.sender, beneficiary, _nftAddress, _tokenId);
    }
}

//npx hardhat verify --network polygon 0x356fA7B4f7bC97d2a1B41fF2bBC2215ffE7bb052
