const LGA = artifacts.require("LGA");

module.exports = async function (deployer) {
  await deployer.deploy(LGA);
};
