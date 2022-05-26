// SPDX-License-Identifier: Apache-2.0

pragma solidity ^0.8.12;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./Ownable.sol";

contract ERC721Template is ERC721, Ownable {
    constructor() ERC721("Template", "Temp") {}
}
