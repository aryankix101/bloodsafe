var BloodDonation = artifacts.require("./BloodDonation.sol");

module.exports = function(deployer) {
  deployer.deploy(BloodDonation);
};
