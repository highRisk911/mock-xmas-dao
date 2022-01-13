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


const Santa = artifacts.require('Santa');


function toBN(number) {
    return web3.utils.toBN(number);
}


contract('Santa', accounts => {
    const OWNER = accounts[0];
    const TEST_USER = accounts[1];
    const SECOND_TEST_USER = accounts[2];

    let amount = 100;
    let santa;


    before(async () => {
        santa = await Santa.deployed();
    });


    it('Mint a 1000 of SANTA to TEST_USER', async () => {
        await santa.mint(TEST_USER, toBN(1000));
    });


//TODO: truffleAssert.eventEmitted need to learn


    it('Only owner can mint', async () => {
        await santa.mint(TEST_USER, toBN(1000), {from: OWNER});
        await truffleAssert.reverts(santa.mint(TEST_USER, toBN(1000),
            {from: TEST_USER}), "Only owner can summon the SANTA");
    });


    it('Only owner can burn', async () => {
        await santa.burn(TEST_USER, toBN(10), {from: OWNER});
        await truffleAssert.reverts(santa.burn(TEST_USER, toBN(10),
            {from: TEST_USER}), "Only owner can kill the SANTA");
    });


    it('Token able to transfer from oneself to other user', async () => {
        let tempBalance = await santa.balanceOf(SECOND_TEST_USER);
        await santa.transfer(SECOND_TEST_USER, toBN(amount), {from: TEST_USER});
        assert(await santa.balanceOf(SECOND_TEST_USER) > tempBalance,
            "receiver balance has not changed");
    });


    it('User can add allowance for other user', async () => {
        let tempAllowance = await santa.allowance(SECOND_TEST_USER, TEST_USER);
        await santa.increaseAllowance(TEST_USER, toBN(100/2), {from: SECOND_TEST_USER});
        assert(await santa.allowance(SECOND_TEST_USER, TEST_USER) > tempAllowance, "allowance has not changed");
    });


    it('User who got increase allowance can transferFrom', async () => {
        let balanceOfTestUser = await santa.balanceOf(SECOND_TEST_USER);
        await santa.increaseAllowance(accounts[7], toBN(60), {from: SECOND_TEST_USER});
        await santa.transferFrom(SECOND_TEST_USER, TEST_USER, 100/2, {from: accounts[7]});
        assert(await santa.balanceOf(SECOND_TEST_USER) > balanceOfTestUser, "balance has not changed");
    });


});