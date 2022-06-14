const Token = artifacts.require("Token");
const IERC721TemplateClaimable = artifacts.require("IERC721TemplateClaimable");
const ERC721Factory = artifacts.require("ERC721Factory");
const truffleAssert = require("truffle-assertions");

contract("ERC721Factory", (accounts) => {
  it("should deploy ERC721 and allow user to claim token", async () => {
    const alice = accounts[0];
    const oracleAddress = accounts[1];
    const bob = accounts[2];

    const erc20Token = await Token.new("test", "Test", { from: alice });
    const erc721FactoryInstance = await ERC721Factory.deployed();
    await erc721FactoryInstance.deployNft(
      "test",
      "test",
      "test",
      "test",
      "test",
      50,
      1,
      erc20Token.address,
      oracleAddress,
      { from: alice }
    );

    const nftAddress = await erc721FactoryInstance.nftAddresses.call(0);

    await erc20Token.transfer(nftAddress, 50);

    const erc721Contract = await IERC721TemplateClaimable.at(nftAddress);
    const balance = (await erc20Token.balanceOf.call(nftAddress)).toString();
    expect(balance).to.equal("50");

    await erc721Contract.updateClaimable(bob, 1, { from: oracleAddress });
    await erc721Contract.claimReward({ from: bob });

    const newBalance = (await erc20Token.balanceOf.call(nftAddress)).toString();
    expect(newBalance).to.equal("49");

    const bobBalance = (await erc20Token.balanceOf.call(bob)).toString();
    expect(bobBalance).to.equal("1");

    // should fail if this is called again: await erc721Contract.claimReward({ from: bob });
  });
});
