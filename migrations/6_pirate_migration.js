const { deployProxy } = require('@openzeppelin/truffle-upgrades');
const web3 = require("web3");

const Pirate = artifacts.require('Pirate');
const PirateProxy = artifacts.require('PirateProxy');
const PirateAdmin = artifacts.require('PirateAdmin');
const PirateV2 = artifacts.require('PirateV2');
const PirateV3 = artifacts.require('PirateV3');

module.exports = async function (deployer, network, accounts) {

    let admin = accounts[0];
    console.log("Admin address: "+admin);

    const name = "Pirate";
    const symbol = "ARRRR";
    const totalSupply = 10000;


    //create admin
    let proxyAdmin;
    await deployer.deploy(PirateAdmin).then(instance => proxyAdmin = instance);
    console.log("PROXY Admin address: "+ proxyAdmin.address);


    //create basic implementation
    let pirate = await deployer.deploy(Pirate);
    await pirate.initialize(name, symbol, totalSupply);
    console.log("Pirate v1 impl address: "+ Pirate.address);


    //create proxy
    let proxyContainer;
    await deployer.deploy(PirateProxy, pirate.address, proxyAdmin.address, web3.utils.hexToBytes('0x')).
        then(function (instance){
            return PirateProxy.at(instance.address);
    }).then(instance => proxyContainer = instance);
    console.log("PirateContainer address: "+ proxyContainer.address);


    //v2 implementation
    let pirateV2 = await deployer.deploy(PirateV2,{initializer: "initialize"});
    await pirateV2.initialize(name, symbol, totalSupply);
    console.log("PirateV2 address: "+ pirateV2.address);

    //testUpgrading
     await proxyAdmin.upgrade(proxyContainer.address, pirateV2.address);
      console.log("PirateContainer updated address: "+ proxyContainer.address+"\nimplementation: "+ await proxyAdmin.getProxyImplementation(proxyContainer.address));


    //v3 implementation
    let pirateV3 = await deployer.deploy(PirateV3,{initializer: "initialize"});
    await pirateV3.initialize(name, symbol, totalSupply);
    console.log("PirateV3 address: "+ pirateV3.address);

    //v3 upgrade
    await proxyAdmin.upgrade(proxyContainer.address, pirateV3.address);
    console.log("PirateContainer updated address: "+ proxyContainer.address+"\nimplementation: "+ await proxyAdmin.getProxyImplementation(proxyContainer.address));
};
