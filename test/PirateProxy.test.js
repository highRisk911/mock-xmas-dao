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
const PirateV2 = artifacts.require('PirateV2');
const PirateAdmin = artifacts.require('PirateAdmin');
const PirateProxy = artifacts.require('PirateProxy');


function toBN(number) {
    return web3.utils.toBN(number);
}


contract('Pirate', async accounts => {
    const name = "Pirate";
    const symbol = "ARRR";
    const totalSupply = toBN(1000);

    let piratev1 = Pirate.deployed();
    await piratev1.initialize(name,symbol,totalSupply);

    let piratev2 = PirateV2.deployed();
    await piratev2.initialize(name,symbol,totalSupply);

    let pirateAdmin = PirateAdmin.deployed();

    let pirateProxy;
    await deployer.deploy(PirateProxy, piratev1.address, pirateAdmin.address, web3.utils.hexToBytes('0x')).
    then(function (instance){
        return PirateProxy.at(instance.address);
    }).then(instance => pirateProxy = instance);

    let client = Pirate.at(pirateProxy.address);

    it('v1', async ()=>{
        assert(await client.version() == "v1");
    });
});