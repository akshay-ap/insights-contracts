// SPDX-License-Identifier: Apache-2.0

pragma solidity ^0.8.12;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./Ownable.sol";

contract ERC721Template is ERC721, Ownable {
    string public template_url;
    string public submission_url;

    bool private _initialized;

    constructor(
        string memory name,
        string memory symbol,
        string memory URI
    ) ERC721(name, symbol) {}

    function initiailize(
        string memory _template_url,
        string memory _submission_url
    ) external returns (bool) {
        require(_initialized != true, "Contract already initialized");

        template_url = _template_url;
        submission_url = _submission_url;
        _initialized = true;
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
}
