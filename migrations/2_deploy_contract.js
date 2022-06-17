const ERC721Factory = artifacts.require("ERC721Factory");
const Token = artifacts.require("Token");

module.exports = (deployer, network, accounts) => {
  const alice = accounts[0];
  const deployedERC721Factory = deployer.deploy(ERC721Factory, { from: alice });
  const deployedERC20 = deployer.deploy(Token, "Test", "Test", { from: alice });

  // const deployedERC20Token = deployer.deploy(Token, {from: alice});
};
