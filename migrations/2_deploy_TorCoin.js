var TorCoin = artifacts.require("./TorCoin.sol");
//var TorCoinPresale = artifacts.require("./TorCoinPresale.sol");


//let settings = require('../tokenSettings.json');

module.exports = function(deployer) {
deployer.deploy(TorCoin);
    //var presaleRate = new web3.BigNumber(settings.presaleRatio);
//deployer.deploy(TorCoin).then(function() {
  	//deployer.link(TorCoin, TorCoinPresale);
  	//return deployer.deploy(BountyProgram, "0x7ffb8a066ff2570f9166c944da09cc8d70cda5a6", TorCoin.address);
   // return deployer.deploy(TorCoinPresale, 1519732800, 1519819200, presaleRate, "0x7ffb8a066ff2570f9166c944da09cc8d70cda5a6", "0x1a63DcF7C984C05cD9Bf0E3EF5c74573390fdC11", "0xd0fc7e0b4e439ed976bb480f0a63356528c21f0e", "0x6bc0b78eafb079800136439810a1a3c62d7df3df", "0x80ec244fbb53da9c9fb55eb382429df750023e8c", "0xd723a3549d778603c17757380185027e022d3c8e");
//  }); 
};


/*{
    "name" : "TorCoin New",
    "symbol" : "TORC",
    "maxTokenSupply" : 69440000e18,
    "decimals" : 18,

    "presaleCap" : 1666666666666666666667,
    "presaleStartTimestamp" : 1518798660,
    "presaleEndTimestamp" : 1518885060,
    "presaleRatio" : 3840,

    "companyFundWallet" : "0x7ffb8a066ff2570f9166c944da09cc8d70cda5a6",
    "companyTokenVault" : "0xd1a9A2B2E79cbF9A5a55CcB0bE8D87a549885Ba4",
    "teamWallet" : "0x1a63DcF7C984C05cD9Bf0E3EF5c74573390fdC11",
    "advisorWallet" : "0xd0fc7e0b4e439ed976bb480f0a63356528c21f0e",
    "aidPoolWallet" : "0x6bc0b78eafb079800136439810a1a3c62d7df3df",
    "companyWallet" : "0xfe4bae1004c686a51e7b59c23feb8fb86cef7947",
    "bountyWallet" : "0xd723a3549d778603c17757380185027e022d3c8e",

}*/