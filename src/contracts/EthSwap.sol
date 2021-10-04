pragma solidity ^0.5.0;
import "./Token.sol";


contract EthSwap {
    string public name = "EthSwap Instant Exchange";
    Token public token;
    uint public rate = 100;     // Redemption rate = number of tokens user receive for 1 ether

    event TokensPurchased(
        address account,
        address token,
        uint amount,
        uint rate
    );

    event TokensSold(
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
        emit TokensPurchased(msg.sender, address(token), tokenAmount, rate);
    }

    function sellTokens(uint _amount) public{
        //user can't sell more tokens than they have
        require(token.balanceOf(msg.sender) >= _amount);

        //calculate the amount of ether to redeem
        uint etherAmount = _amount /rate ;

        // Require that ethSwap has enough ether
        require(address(this).balance >= etherAmount);

        //perform sale
        token.transferFrom(msg.sender,address(this), _amount); // transferFrom(from,to,value); address(this) is the address of the SC
        msg.sender.transfer(etherAmount);  // this transfer function is ether, not related to erc20 like the one above

        //Emit an event
        emit TokensSold(msg.sender, address(token), _amount, rate);

    }
}