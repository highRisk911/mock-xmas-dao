const {time, expectRevert} = require('@openzeppelin/test-helpers');
const truffleAssert = require('truffle-assertions');
const bigDecimal = require('js-big-decimal');
const web3 = require("web3");
const BN = web3.utils.BN;
const chai = require('chai');
const {deployProxy} = require("@openzeppelin/truffle-upgrades");
const expect = chai.expect;
const assert = chai.assert;
chai.use(require('bn-chai')(BN));
chai.use(require('chai-match'));



const Pirate = artifacts.require('Pirate');


function toBN(number) {
    return web3.utils.toBN(number);
}


contract('Pirate', accounts => {
    const OWNER = accounts[0];
    const TEST_USER = accounts[1];
    const SECOND_TEST_USER = accounts[2];

    let amount = 100;
    let pirateLet;

        before(async function () {
            pirateLet = await deployProxy(Pirate, ["Pirate", "ARRR", toBN(1000000)], {initializer: 'initialize' });
            console.log('Deployed', pirateLet.address);
        });



    it('Token able to transfer from oneself to other user', async () => {
        let tempBalance = await pirateLet.balanceOf(SECOND_TEST_USER);
        await pirateLet.transfer(SECOND_TEST_USER, toBN(amount), {from: OWNER});
        assert(await pirateLet.balanceOf(SECOND_TEST_USER) > tempBalance,
            "ERC20: transfer amount exceeds balance.");
    });


    it('User can add allowance for other user', async () => {
        let tempAllowance = await pirateLet.allowance(SECOND_TEST_USER, TEST_USER);
        await pirateLet.increaseAllowance(TEST_USER, toBN(100/2), {from: SECOND_TEST_USER});
        assert(await pirateLet.allowance(SECOND_TEST_USER, TEST_USER) > tempAllowance, "ERC20: transfer amount exceeds balance.");
    });


    it('User who got increase allowance can transferFrom', async () => {
        let balanceOfTestUser = await pirateLet.balanceOf(SECOND_TEST_USER);
        await pirateLet.increaseAllowance(accounts[7], toBN(60), {from: SECOND_TEST_USER});
        await pirateLet.transferFrom(SECOND_TEST_USER, TEST_USER, 100/2, {from: accounts[7]});
        assert(await pirateLet.balanceOf(SECOND_TEST_USER) > balanceOfTestUser, "ERC20: transfer amount exceeds balance.");
    });


});