// SPDX-License-Identifier: Apache-2.0

pragma solidity ^0.8.12;

import "./ERC721Template.sol";

contract Deployer {
    constructor() {}

    function deployERC721Contract(
        string memory name,
        string memory symbol,
        string memory uri
    ) public returns (address token) {
        token = address(new ERC721Template(name, symbol, uri));
    }
}
