var TorCoin = artifacts.require("./TorCoin.sol");
var TorCoinPresale = artifacts.require("./TorCoinPresale.sol");

module.exports = function(deployer) {

	//deployer.deploy(BountyProgram, TorCoin.address)
  	//deployer.link(TorCoin, TorCoinPresale);
  	//deployer.deploy(TorCoinPresale, "0x7ffb8a066ff2570f9166c944da09cc8d70cda5a6", TorCoin.address);

  	const startTime = web3.eth.getBlock(web3.eth.blockNumber).timestamp + 60;
    const endTime = startTime + (86400 * 1); 
 console.log('------'+TorCoin.address+'----'+startTime+'----'+endTime);
 //deployer.link(TorCoin, TorCoinPresale);

    deployer.then(function(){
      return TorCoin.deployed();
    }).then(function(instance){
      //return deployer.deploy(TorCoinPresale, startTime, endTime, 700,"0x80eC244fBb53da9c9fB55Eb382429dF750023e8c", "0x7ffb8a066ff2570f9166c944da09cc8d70cda5a6",instance.address);

      return deployer.deploy(TorCoinPresale, startTime, endTime, 700,"0xf17f52151EbEF6C7334FAD080c5704D77216b732", "0xf17f52151EbEF6C7334FAD080c5704D77216b732",instance.address);
    });

  	 
 	 
   
};


