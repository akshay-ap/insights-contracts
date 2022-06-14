// SPDX-License-Identifier: Apache-2.0

pragma solidity ^0.8.12;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import "./Ownable.sol";

contract ERC721Template is ERC721, Ownable {
    string public template_url;
    string public submission_url;
    bool private _initialized;

    // Variables related to rewards
    mapping(address => bool) public hasClaimedRewards;
    mapping(address => uint256) public canClaimRewards;
    address public oracleAddress;
    address public erc20TokenAddress;
    uint256 public maxRewardPerUser;
    uint256 public totalReward;
    uint256 public totalRewardsPaid;
    uint256 public totalRewardsParked;

    event RewardPaid(address user, uint256 amount, address erc20TokenAddress);

    constructor(
        string memory name,
        string memory symbol,
        string memory URI
    ) ERC721(name, symbol) {}

    function initiailize(
        string memory _template_url,
        string memory _submission_url,
        uint256 _maxRewardPerUser,
        uint256 _totalReward,
        address _erc20TokenAddress,
        address _oracleAddress
    ) external onlyOwner returns (bool) {
        require(_initialized != true, "Contract already initialized");

        template_url = _template_url;
        submission_url = _submission_url;
        _initialized = true;
        maxRewardPerUser = _maxRewardPerUser;
        totalReward = _totalReward;
        erc20TokenAddress = _erc20TokenAddress;
        oracleAddress = _oracleAddress;
        return true;
    }

    function isInitialized() external view returns (bool) {
        return _initialized;
    }

    function getMetadata()
        external
        view
        returns (string memory _template_url, string memory _submission_url)
    {
        return (template_url, submission_url);
    }

    modifier onlyOracle() {
        require(msg.sender == oracleAddress, "Not oracle address");
        _;
    }

    function claimReward() external {
        require(
            hasClaimedRewards[msg.sender] == false,
            "User already claimed rewards"
        );

        hasClaimedRewards[msg.sender] = true;
        uint256 rewardAmount = canClaimRewards[msg.sender];
        totalRewardsPaid += rewardAmount;

        IERC20(erc20TokenAddress).transfer(msg.sender, rewardAmount);
        emit RewardPaid(msg.sender, rewardAmount, erc20TokenAddress);
    }

    function updateClaimable(address user, uint256 reward) external onlyOracle {
        require(
            hasClaimedRewards[user] == false,
            "User already claimed rewards"
        );

        require(reward <= maxRewardPerUser, "Reward amount exceeds limit");
        require(
            totalRewardsParked + reward <= totalReward,
            "Reward amount exceeds total limit"
        );
        totalRewardsParked += reward;
        canClaimRewards[user] = reward;
    }

    function getRewardStatus() external view returns (bool, uint256) {
        return (hasClaimedRewards[msg.sender], canClaimRewards[msg.sender]);
    }

    function getRewardStatusForUser(address user)
        external
        view
        returns (bool, uint256)
    {
        return (hasClaimedRewards[user], canClaimRewards[user]);
    }
}
