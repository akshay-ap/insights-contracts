// SPDX-License-Identifier: Apache-2.0

pragma solidity ^0.8.12;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

interface IERC721Template is IERC721 {
    function initiailize(
        string memory _template_url,
        string memory _submission_url
    ) external returns (bool);

    function getMetadata()
        external
        view
        returns (string memory _template_url, string memory _submission_url);
}
