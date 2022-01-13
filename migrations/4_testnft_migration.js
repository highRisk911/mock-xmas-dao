const TestNFT = artifacts.require("TestNFT");

module.exports = async function (deployer) {
  await deployer.deploy(TestNFT);
};
