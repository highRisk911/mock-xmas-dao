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


const TestContract = artifacts.require('TestContract');

contract('TestContract', accounts =>{
    let test;

    before(async () =>{
        test = await TestContract.deployed();
    });



    it('lol', async () => {
        console.log(await test.Test());
    });
});