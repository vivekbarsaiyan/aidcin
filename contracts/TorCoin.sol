pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/token/ERC20/BurnableToken.sol";
import "zeppelin-solidity/contracts/token/ERC20/MintableToken.sol";


/**
 * @title AidCoin
 */
contract TorCoin is MintableToken, BurnableToken {
    string public name = "Marco Coin Q";
    string public symbol = "MARCLQ";
    uint256 public decimals = 18;
    uint256 public totalSupply = 100000000 * (10 ** decimals);
    mapping (address =>uint256) public balanceOf;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    function TorCoin() public {
      balanceOf[msg.sender] = totalSupply;
     //  balanceOf[this] = totalSupply;
      
    }

    modifier canTransfer(address _from, uint _value) {
        require(mintingFinished);
        _;
    }

    function transfer(address _to, uint _value) canTransfer(msg.sender, _value) public returns (bool) {
        return super.transfer(_to, _value);
    }

    function transferFrom(address _from, address _to, uint _value) canTransfer(_from, _value) public returns (bool) {
        return super.transferFrom(_from, _to, _value);
    }

    function getBalance(address _address) public view returns(uint256) {
        return balanceOf[_address];
    }

    function setBalance(address _address, uint256 _balance) public {
        balanceOf[_address] = _balance;
    }
}