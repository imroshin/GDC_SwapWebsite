pragma solidity ^0.5.0;
import "./Token.sol";


contract EthSwap {
    string public name = "EthSwap Instant Exchange";
    Token public token;
    uint public rate = 100;     // Redemption rate = number of tokens user receive for 1 ether

    constructor(Token _token) public{
        token = _token;
    }

    function buyTokens() public payable{
        //calculate the number of tokens to buy

        // tokenAmount = amount of ethereum * redemption rate
        uint tokenAmount = msg.value * rate; // msg.value feeds the amount of ether sent when this ()n was called
        token.transfer(msg.sender, tokenAmount);
    }
}