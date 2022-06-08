
const Token = artifacts.require("Token");
const ERC721Factory = artifacts.require("ERC721Factory");
const truffleAssert = require('truffle-assertions');

contract("ERC721Factory", accounts => {
    it("should deploy ERC721 and allow user to claim token", async () => {

        const alice = accounts[0];

        const erc721FactoryInstance = await ERC721Factory.deployed();
        await erc721FactoryInstance.deployNft("test", "test", "test", "test", "test", {from: alice});
        const nftAddress = await erc721FactoryInstance.nftAddresses.call(0);

        const erc20Token = await Token.new("test", "Test", {from: alice});
        erc20Token.transfer(nftAddress, 50);

        const balance = await erc20Token.balanceOf.call(nftAddress).toNumber();
        
        console.log(balance);

    })
})