pragma solidity ^0.4.18;

import "./TorCoin.sol";
import "zeppelin-solidity/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "zeppelin-solidity/contracts/crowdsale/validation/TimedCrowdsale.sol";
//import "zeppelin-solidity/contracts/token/ERC20/TokenTimelock.sol";


/**
 * @title TorCoinPresale
 * @dev Extension of Crowdsale with a max amount of tokens raised
 */
contract TorCoinPresale is Ownable, CappedCrowdsale, TimedCrowdsale {
    using SafeMath for uint256;

    // max tokens cap
    uint256 public tokenCap = 10000000 * (10 ** 18);

    // amount of sold tokens
    uint256 public soldTokens;

    uint256 public openingTime;
    uint256 public closingTime;

    // Team wallet
    address public teamWallet;

    // Min/max purchase
  uint256 public minContribution = 0.5 ether;
  uint256 public maxContribution = 1500 ether;

  // amount of raised money in wei
  uint256 public weiRaised;
  mapping (address => uint256) public contributions;

  uint256 public rate;

  // Finalization flag for when we want to withdraw the remaining tokens after the end
  bool public crowdsaleFinalized = false;
   

    // reserved tokens
    uint256 public teamTokens       =   10000000 * (10 ** 18);
   
   TorCoin public token;

    modifier beforeEnd() {
        require(now < closingTime);
        _;
    }

    function TorCoinPresale(
        uint256 _openingTime,
        uint256 _closingTime,
        uint256 _rate,
        address _wallet,
        address _teamWallet,
        MintableToken _token
    ) public
    Crowdsale(_rate, _wallet, _token)
    CappedCrowdsale(tokenCap)
    TimedCrowdsale(_openingTime, _closingTime)
    {
     
        teamWallet = _teamWallet;

        openingTime = _openingTime;
        closingTime = _closingTime;
        
       rate = _rate;
       token = TorCoin(_token);
       //
       
    }

    
    // low level token purchase function
      function buyTokens(address beneficiary) public payable {
       require(beneficiary != address(0));
       
        require(validPurchase());

        uint256 weiAmount = msg.value;

        // calculate token amount to be created
        uint256 tokens = getTokenAmount(weiAmount);

        // update total and individual contributions
        weiRaised = weiRaised.add(weiAmount);
        contributions[beneficiary] = contributions[beneficiary].add(weiAmount);

        // Send tokens
        token.transfer(beneficiary, tokens);
        TokenPurchase(msg.sender, beneficiary, weiAmount, tokens);

        // Send funds
        wallet.transfer(msg.value);
      }

    

    // close token sale and transfer ownership, also move unclaimed airdrop tokens
    function closeTokenSale(address _icoContract) public onlyOwner {
        require(hasClosed());
        require(_icoContract != 0x0);

        token.mint(teamWallet, teamTokens);
        // transfer token ownership to ico contract
        token.transferOwnership(_icoContract);
    }

    // overriding Crowdsale#hasEnded to add tokenCap logic
    // @return true if crowdsale event has ended or cap is reached
    function hasClosed() public view returns (bool) {
        bool capReached = soldTokens >= tokenCap;
        return super.hasClosed() || capReached;
    }

    // @return true if crowdsale event has started
    function hasStarted() public view returns (bool) {
        return now >= openingTime && now < closingTime;
    }

    // Bonuses for larger purchases (in hundredths of percent)
  function bonusPercentForWeiAmount(uint256 weiAmount) public pure returns(uint256) {
   // if (weiAmount >= 500 ether) return 1000; // 10%
   // if (weiAmount >= 250 ether) return 750;  // 7.5%
   // if (weiAmount >= 100 ether) return 500;  // 5%
   // if (weiAmount >= 50 ether) return 375;   // 3.75%
   // if (weiAmount >= 15 ether) return 250;   // 2.5%
    if (weiAmount >= 5 ether) return 125;    // 1.25%
    return 0; // 0% bonus if lower than 5 eth
  }

  // Returns you how much tokens do you get for the wei passed
  function getTokenAmount(uint256 weiAmount) internal view returns(uint256) {
    uint256 tokens = weiAmount.mul(rate);
    uint256 bonus = bonusPercentForWeiAmount(weiAmount);
    tokens = tokens.mul(10000 + bonus).div(10000);
    return tokens;
  }

  // Returns true if the transaction can buy tokens
  function validPurchase() internal view returns (bool) {
    bool withinPeriod = now >= openingTime && now <= closingTime;
    bool moreThanMinPurchase = msg.value >= minContribution;
    bool lessThanMaxPurchase = contributions[msg.sender] + msg.value <= maxContribution;
    bool withinCap = weiRaised.add(msg.value) <= cap;

    return withinPeriod && moreThanMinPurchase && lessThanMaxPurchase && withinCap && !crowdsaleFinalized;
  }
}