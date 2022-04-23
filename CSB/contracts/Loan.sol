pragma solidity ^0.8.0;

contract Loan {
    address public owner;
    uint timestamp;
    uint quantity;
    uint months;
    uint TotalLoan;
    uint quote;
    uint RemainingLoan;
    uint QuotesRemaining;

    function Loan(uint quantity,uint months){
        timestamp=block.timestamp;
        owner=msg.sender;
        TotalLoan = calculateLoanQuote(quantity, months);
        quote=TotalLoan/months;
        RemainingLoan=TotalLoan;
        QuotesRemaining=months;

    }

    function calculateLoan(uint cantidad, uint months){
        require(msg.sender==owner);
        uint loan;
        if (months==12){//0.1
            loanQuote=quantity+10*quantity/100;

        }
        else if(months==24){
        //0.15
          //interestRate=3/2 ether/10;
            loanQuote=quantity+15*quantity/100;
        }
        else if(months==36){
          //0.2
         // interestRate= 2 ether/10;
            loanQuote=quantity+20*quantity/100;
            }
        return loan;
    }

    function payQuote() {
        require(msg.sender==owner);
        if (QuotesRemaining > 0) {
            RemainingLoan -= quote;
            QuotesRemaining -= 1;
        }
    }

}
