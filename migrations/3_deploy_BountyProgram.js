var TorCoin = artifacts.require("./TorCoin.sol");
var BountyProgram = artifacts.require("./BountyProgram.sol");

module.exports = function(deployer) {

	//deployer.deploy(BountyProgram, TorCoin.address)
  	deployer.link(TorCoin, BountyProgram);
  	deployer.deploy(BountyProgram, "0x821aEa9a577a9b44299B9c15c88cf3087F3b5544", TorCoin.address);
 
};
