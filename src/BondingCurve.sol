// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@bancorprotocol/converter/BancorFormula.sol";

contract BondingCurve is BancorFormula {

   
}


 /*
   * @dev reserve ratio, represented in ppm, 1-1000000
   * 1/3 corresponds to y= multiple * x^2
   * 1/2 corresponds to y= multiple * x
   * 2/3 corresponds to y= multiple * x^1/2
   * multiple will depends on contract initialization,
   * specificallytotalAmount and poolBalance parameters
   * we might want to add an 'initialize' function that will allow
   * the owner to send ether to the contract and mint a given amount of tokens
   * 
   * 
   * uint32 public reserveRatio;
   * 
  */


//  todo
// 1. Simplicity the thoughts
// 2. 
  