const CryptoSavingBank = artifacts.require("CryptoSavingBank");

module.exports = function (deployer) {
  deployer.deploy(CryptoSavingBank);
};
