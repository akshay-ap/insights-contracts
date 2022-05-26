// SPDX-License-Identifier: Apache-2.0

pragma solidity ^0.8.12;

import "./Deployer.sol";

contract ERC721Factory is Deployer {
    constructor() {}

    uint256 public currentNFTCount;
    address[] public nftAddresses;

    event NftCreated(
        address newTokenAddress,
        string tokenName,
        string tokenSymbol,
        string tokenURI
    );

    address private templateERC721;

    function deployNft(
        string memory name,
        string memory symbol,
        string memory uri
    ) public returns (address token) {
        token = deployERC721Contract(name, symbol, uri);
        require(token != address(0), "Nft creation failed");
        nftAddresses.push(token);
        emit NftCreated(token, name, symbol, uri);
        currentNFTCount += 1;
    }

    function getCurrentNFTCount() external view returns (uint256) {
        return currentNFTCount;
    }
}
