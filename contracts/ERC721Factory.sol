// SPDX-License-Identifier: Apache-2.0

pragma solidity ^0.8.12;

import "./Deployer.sol";
import "./interfaces/IERC721TemplateClaimable.sol";

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
        string memory uri,
        string memory template_url,
        string memory submission_url,
        uint256 maxRewardPerUser,
        uint256 totalReward,
        address erc20TokenAddress,
        address oracleAddress
    ) public returns (address token) {
        token = deployERC721Contract(name, symbol, uri);
        require(token != address(0), "Nft creation failed");
        nftAddresses.push(token);

        IERC721TemplateClaimable tokenInstance = IERC721TemplateClaimable(
            token
        );

        emit NftCreated(token, name, symbol, uri);
        currentNFTCount += 1;

        require(
            tokenInstance.initiailize(
                template_url,
                submission_url,
                maxRewardPerUser,
                totalReward,
                erc20TokenAddress,
                oracleAddress
            ),
            "ERC721Factory: Unable to initialize token instance"
        );
    }

    function getCurrentNFTCount() external view returns (uint256) {
        return currentNFTCount;
    }
}
