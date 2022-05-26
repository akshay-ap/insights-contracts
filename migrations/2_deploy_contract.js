const ERC721Factory = artifacts.require("ERC721Factory");

module.exports = (deployer) => {
    const deployedERC721Factory = deployer.deploy(ERC721Factory);
}