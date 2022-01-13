const {time, expectRevert} = require('@openzeppelin/test-helpers');
const truffleAssert = require('truffle-assertions');
const bigDecimal = require('js-big-decimal');
const web3 = require("web3");
const BN = web3.utils.BN;
const chai = require('chai');
const expect = chai.expect;
const assert = chai.assert;
chai.use(require('bn-chai')(BN));
chai.use(require('chai-match'));


const TestNFT = artifacts.require('TestNFT');


function toBN(number) {
    return web3.utils.toBN(number);
}

contract('TestNFT', accounts =>{
    const OWNER = accounts[0];
    const TESTER = accounts[1];
    const RECEIVER = accounts[4];

    const URI = "https://ipfs.io/ipfs/QmcETaxUd1n6dcbq2QHnnV8wA5dKymgnV1ykuBkYiziPjK?filename=TestNFT.json";
    let nftInstance;




    before(async () => {
        nftInstance = await TestNFT.deployed();
    });

    it("NFT minting", async () =>{
        await nftInstance.awardItem(TESTER, URI, {from: OWNER});
        await truffleAssert.reverts(nftInstance.awardItem(TESTER, URI, {from: TESTER}) ,"revert Ownable: caller is not the owner");
    });

    let itemId;

    it("NFT-owner is tester", async () => {
        itemId =  await nftInstance.getItemId();
        //expect(await nftInstance.ownerOf(await nftInstance.getItemId())).be.eq(TESTER);
        await assert(await nftInstance.ownerOf(itemId) === TESTER, "Tester is not a nft-owner");
    });


    it("Transfer NFT from Tester to Receiver", async () => {
        await nftInstance.approve(RECEIVER, itemId, {from: TESTER});
        await nftInstance.safeTransferFrom(TESTER, RECEIVER, itemId, {from:TESTER});
        await assert(await nftInstance.ownerOf(itemId) === RECEIVER, "Transfer error: Receiver is not a new owner");
        await truffleAssert.reverts(nftInstance.approve(RECEIVER, itemId, {from: TESTER}),"ERC721: approval to current owner" );
    });




});