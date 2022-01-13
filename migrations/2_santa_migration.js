const Santa = artifacts.require("Santa");

module.exports = async function (deployer) {
  await deployer.deploy(Santa, "DedMoroz", "HOHO");
};
