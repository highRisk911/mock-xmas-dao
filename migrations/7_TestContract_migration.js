const Migrations = artifacts.require("TestContract");

module.exports = function (deployer) {
  deployer.deploy(Migrations);
};
