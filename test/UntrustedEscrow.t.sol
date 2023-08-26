// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "forge-std/Test.sol";

import {UntrustedEscrow} from "src/UntrustedEscrow.sol";
import {TestERC20} from "src/TestERC20.sol";

import "forge-std/Vm.sol";
import "forge-std/console.sol";

contract UntrustedEscrowTest is Test {
    using SafeERC20 for ERC20;
    UntrustedEscrow untrustedEscrow;
    TestERC20 testERC20;

    address testAddress1 = address(1);
    address testAddress_seller1 = address(11);
    address testAddress2 = address(2);
    address testAddress_seller2 = address(21);

    address testAddress_seller3 = address(31);

    function setUp() external {
        untrustedEscrow = new UntrustedEscrow();
        testERC20 = new TestERC20();
        
        // testERC20.transfer(testAddress1, 1000 * 10 ** testERC20.decimals());

    }

    // one buyer deposit and the corrospending seller can withdraw the realted balance after 3 days
    function test_DepositAndWithDraw() external {
        uint256 depositAmount = 100*10**testERC20.decimals();
        
        
        testERC20.transfer(testAddress1,depositAmount);

        // buyer,seller address
        

        test_deposit(testAddress_seller1,address(testERC20),depositAmount);
        assertEq(untrustedEscrow.escrowCoinInfo(testAddress_seller1,testAddress1).balance,depositAmount);


        // two place check balance of testERC20  for: UntrustedEscrow. o
        // 1:testERC20 check balance of testERC20  for: UntrustedEscrow
        console.log("untrustedEscrow-balance",testERC20.balanceOf(address(untrustedEscrow)));

        // 2: UntrustedEscrow keep track of the info
        
        // modity blocktimestamp
        vm.warp(block.timestamp+1 + 3 days);
        test_withdraw(testAddress1,testAddress_seller1);
        assertEq(untrustedEscrow.escrowCoinInfo(testAddress_seller1,testAddress1).balance,0);
    }

     function test_WithDrawRevertIfSellerInValid()  external {
        uint256 depositAmount = 100*10**testERC20.decimals();
        testERC20.transfer(testAddress1,depositAmount);
        

        test_deposit(testAddress_seller1,address(testERC20),depositAmount);
        assertEq(untrustedEscrow.escrowCoinInfo(testAddress_seller1,testAddress1).balance,depositAmount);

      
        // modity blocktimestamp
        vm.warp(block.timestamp+1 + 3 days);
        vm.expectRevert(); // invalid seller address
        test_withdraw(testAddress1,testAddress_seller2);
        
    }

      function test_WithDrawRevertBeyondTime() external {
        uint256 depositAmount = 100*10**testERC20.decimals();
        testERC20.transfer(testAddress1,depositAmount);
        

        test_deposit(testAddress_seller1,address(testERC20),depositAmount);
        assertEq(untrustedEscrow.escrowCoinInfo(testAddress_seller1,testAddress1).balance,depositAmount);

        // modity blocktimestamp
        vm.expectRevert();
        test_withdraw(testAddress1,testAddress_seller2);
        
    }

    function test_deposit(address sellerAddress,address erc20Address,uint256 depositAmount)  internal {
        vm.startPrank(testAddress1);
        // instead of approve(), use the below funtion to avoid the  double-spend an allowance problem
        ERC20(erc20Address).safeIncreaseAllowance(address(untrustedEscrow),depositAmount);

        untrustedEscrow.deposit(address(erc20Address),depositAmount,sellerAddress);
        console.log("buyer:",testAddress1,"the corrospending seller:",sellerAddress);
        console.log("deposit ERC20 coin",address(testERC20),depositAmount/10**ERC20(erc20Address).decimals(),"amount");
        vm.stopPrank();
    }

    function test_withdraw(address buyerAddress,address sellerAddress)  internal {
        vm.startPrank(sellerAddress);

        untrustedEscrow.withdraw(buyerAddress);
        console.log("seller :",sellerAddress,"the corrospending buyer:",testAddress1);

        UntrustedEscrow.CoinInfo memory coinInfo = untrustedEscrow.escrowCoinInfo(sellerAddress,buyerAddress);
        console.log("witherdraw ERC20 coin",coinInfo.erc20,"amount:",coinInfo.balance);
        vm.stopPrank();
        
    }
}


/**
 * tood
 * 1.code adjust
 * 2. coinfo data structure adjust
 * 3. how to test these security issues
 *
 * 
 * doing
 * 
 * security issues
 * 1. arbitrary ERC20
 * 
 * 
 * 1.basic features
 *  basic logic
 * 2.security issues
 *  1)  ERC20 security issues
 *      1: instead of approve(), use safeIncreaseAllowance to avoid the  double-spend an allowance problem
 *      2: safeTransferFrom or safeTransferFrom, which add more check that not return bool.
 *      3. For Reentrant problem, use  RnonReentrant(ReentrancyGuard), and  do the checks_effects_interactions no matter in the deposit or withdraw funciton
 * 
 *  2) Other security issues
 *      1:buy can put an arbitrary ERC20 token, current solidity version > 0.8.0. There are no overflow or underflow.
 *      2. add  Pausable,Ownable. which the owner can pause all the funcitons preventing the unexpected behaviour. 
 *      3: The specifical ERC20 supply mechniasm. the supply is changing according to some conditions. which will leads to the conflict between the UntrustedEscrow's
 *   balance and the corrospending erc20's balance. For now. no better sultion. just ignore. TODO
 *              // specifical ERC20 implementation
 *               // 1:Fee-on-transfer tokens , this mechniasm leads to the actual received amount less than the input amount?
 *               //  shoud consider, It seems make the contract more complex.
 *               // 2: Rebasing tokens
 *               //  automatically decrease or increase based on their mechanism, which leads to eller_buyer_coin[sellerAddress][msg.sender] balance not 
 *               // ERC20(erc20Token).balanceOf(address(this)) can track the balance, but if more buyers send same erc20 tokens???
 *      
 * 
 * 
 * 
 * * possible security issues:
 * 1)business loigc
 * 
 * 
 * 
 * 
 * 
 * now doing:
 * 1)basic feature done
 * 1. buy and transfer done
 * 2. seller withdraw only after 3 days. done
 * 3. add modify buyer and sellers  doing
 * 
 *      
 * 4. name beauty
 * 
 *
 * todo
 * 1.test case add test balanceOf funcitons
 * 2. which quesitons should summary?
 * 
 *
 */
