pragma solidity ^0.4.18;

import "./TorCoin.sol";


/**
 * @title BountyProgram
 */
contract BountyProgram is Ownable {

    address bountyWallet;
    mapping (address => uint256) public claimedBountyTokens;

    // reserved tokens
    uint256 public bountyTokens       =   1000000 * (10 ** 18);

    TorCoin public token;
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    function BountyProgram(address _bountyWallet, address _token) public {
        require(_bountyWallet != address(0));
        require(_token != address(0));

        bountyWallet = _bountyWallet;
        token = TorCoin(_token);

        token.setBalance(_token, token.getBalance(_token) - bountyTokens);
        token.setBalance(bountyWallet, token.getBalance(bountyWallet) + bountyTokens);
        Transfer(_token, bountyWallet, bountyTokens);

        //token.mint(bountyWallet, BountyTokens);
    }

    function multisend(address[] users, uint256[] amounts) public onlyOwner {
        require(users.length > 0);
        require(amounts.length > 0);
        require(users.length == amounts.length);

        for (uint i = 0; i < users.length; i++) {
            address to = users[i];
            uint256 value = amounts[i] * (10 ** 18);

            if (claimedBountyTokens[to] == 0) {
                claimedBountyTokens[to] = value;
                token.transferFrom(bountyWallet, to, value);
            }
        }
    }
}