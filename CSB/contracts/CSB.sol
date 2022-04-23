// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
import "./Loan.sol";

contract CryptoSavingBank {

  address public owner;
  mapping (address => uint) public account;
  Loan loan;
  event deposit (address reminente, uint quantity);
  event withdraw (address receptor, uint quantity);
  event askloan (address prestatario, address prestamista, uint quantity, uint months);

  // Devolucion de prestamo
  event devolver (address prestatario, address prestamista, uint quantity);

  modifier restricted() {
    require(
      msg.sender == owner,
      "This function is restricted to the contract's owner"
    );
  }
  constructor()
  {
    owner = msg.sender;
  }

  function Deposit(uint quantity) public payable
  {
    require(msg.sender==owner);
    emit deposit(msg.sender, quantity);
    account[msg.sender] += quantity;
  }

  function Withdraw(uint quantity) public
  {
    require(msg.sender==owner);
    require(account[msg.sender] >= quantity, "Esta retirando una cantidad superior a la que dispone");
    emit withdraw(msg.sender, quantity);
    account[msg.sender] -= quantity;
  }

  function Askloan(address banco, uint quantity, uint MonthsToReturn) public payable
  {
    require((msg.sender==owner) && (account[banco]>= quantity));
    loan= new Loan(quantity, MonthsToReturn);
    emit askloan(msg.sender, banco, quantity, MonthsToReturn);
    account[msg.sender] += quantity;
    account[banco] -= quantity;

  }

  function Devolver (address banco, uint quantity) public
  {
    //0.1 Eth;  1 eth = 10^8 wei; todos los numeros representados en wei
    uint interes = 1 ether/10;
    require(msg.sender==owner);
    require(account[msg.sender]>=(quantity + interes * quantity), "No dispone de suficiente fondo para devolver");
    emit devolver(msg.sender, banco, quantity);
    account[msg.sender] -= (quantity + interes * quantity);
    account[banco] += (quantity + interes * quantity);
  }
}
