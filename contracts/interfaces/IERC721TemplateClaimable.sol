// SPDX-License-Identifier: Apache-2.0

pragma solidity ^0.8.12;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

interface IERC721TemplateClaimable is IERC721 {
    function initiailize(
        string memory _template_url,
        string memory _submission_url,
        uint256 _maxRewardPerUser,
        uint256 _totalReward,
        address _erc20TokenAddress,
        address _oracleAddress
    ) external returns (bool);

    function getMetadata()
        external
        view
        returns (string memory _template_url, string memory _submission_url);

    function getRewardStatus() external view returns (bool, uint256);

    function getRewardStatusForUser(address user)
        external
        view
        returns (bool, uint256);

    function updateClaimable(address user, uint256 reward) external;

    function claimReward() external;
}
