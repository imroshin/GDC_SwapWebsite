pragma solidity ^0.5.0;
import "./Token.sol";


contract EthSwap {
    string public name = "EthSwap Instant Exchange";
    Token public token;
    uint public rate = 100;     // Redemption rate = number of tokens user receive for 1 ether

    event TokenPurchased(
        address account,
        address token,
        uint amount,
        uint rate
    );

    constructor(Token _token) public{
        token = _token;
    }

    function buyTokens() public payable{
        //calculate the number of tokens to buy

        // tokenAmount = amount of ethereum * redemption rate
        uint tokenAmount = msg.value * rate; // msg.value feeds the amount of ether sent when this ()n was called

        // Require that swap contract has enough tokens
        require(token.balanceOf(address(this)) >= tokenAmount);
        // transfer tokens to the user
        token.transfer(msg.sender, tokenAmount);

        //Emit an event
        emit TokenPurchased(msg.sender, address(token), tokenAmount, rate);
    }
}