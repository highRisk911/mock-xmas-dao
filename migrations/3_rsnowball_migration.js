const RSnowball = artifacts.require("RSnowball");

module.exports = async function (deployer) {
  await deployer.deploy(RSnowball, "SnowballTest", "SBL");
};
