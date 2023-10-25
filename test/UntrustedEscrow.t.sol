// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "forge-std/Test.sol";

import {UntrustedEscrow} from "src/UntrustedEscrow.sol";
import {TestERC20, TestERC20WithFees} from "./TestERC20.sol";

import "forge-std/Vm.sol";
import "forge-std/console.sol";

contract UntrustedEscrowTest is Test {
    using SafeERC20 for ERC20;

    UntrustedEscrow untrustedEscrow;
    TestERC20 testERC20;
    TestERC20WithFees testERC20WithFees;

    address testAddress_buyer1 = address(1);
    address testAddress_seller1 = address(11);
    address testAddress_buyer2 = address(2);
    address testAddress_seller2 = address(21);

    address testAddress_seller3 = address(31);

    function setUp() external {
        untrustedEscrow = new UntrustedEscrow();
        testERC20 = new TestERC20();
        testERC20WithFees = new TestERC20WithFees();
    }

    // one buyer deposit and the corrospending seller can withdraw the realted balance after 3 days
    function test_DepositAndWithDraw() external {
        uint256 depositAmount = 100 * 10 ** testERC20.decimals();

        testERC20.transfer(testAddress_buyer1, depositAmount);

        // buyer,seller address
        test_deposit(testAddress_seller1, address(testERC20), depositAmount);
        assertEq(untrustedEscrow.escrowCoinInfo(testAddress_seller1, testAddress_buyer1).balance, depositAmount);

        // two place check balance of testERC20
        // 1:testERC20 check balance of testERC20
        // 2: UntrustedEscrow keep track of the info
        console.log("untrustedEscrow-balance", testERC20.balanceOf(address(untrustedEscrow)));

        // modity blocktimestamp
        vm.warp(block.timestamp + 1 seconds + 3 days);
        test_withdraw(testAddress_buyer1, testAddress_seller1);
        assertEq(untrustedEscrow.escrowCoinInfo(testAddress_seller1, testAddress_buyer1).balance, 0);
    }

    function test_DepositAndWithDrawWithFees() external {
        uint256 depositAmount = 100 * 10 ** testERC20WithFees.decimals();

        testERC20WithFees.transfer(testAddress_buyer1, depositAmount);

        // buyer,seller address
        test_deposit(testAddress_seller1, address(testERC20WithFees), depositAmount);
        // should consider the feess, delete 100
        console.log(
            "untrustedEscrow.escrowCoinInfo(testAddress_seller1, testAddress_buyer1).balance",
            untrustedEscrow.escrowCoinInfo(testAddress_seller1, testAddress_buyer1).balance
        );
        assertEq(untrustedEscrow.escrowCoinInfo(testAddress_seller1, testAddress_buyer1).balance, depositAmount - 100);

        // two place check balance of testERC20
        // 1:testERC20 check balance of testERC20
        // 2: UntrustedEscrow keep track of the info
        // console.log("untrustedEscrow-balance", testERC20WithFees.balanceOf(address(untrustedEscrow)));

        // modity blocktimestamp
        vm.warp(block.timestamp + 1 seconds + 3 days);
        test_withdraw(testAddress_buyer1, testAddress_seller1);
        assertEq(untrustedEscrow.escrowCoinInfo(testAddress_seller1, testAddress_buyer1).balance, 0);
    }

    // one buyer deposit more times and the corresponding seller can withdraw all balance
    function test_DepositMoreTimesAndWithDraw() external {
        uint256 depositAmount = 100 * 10 ** testERC20.decimals();

        testERC20.transfer(testAddress_buyer1, depositAmount);

        // buyer,seller address
        test_deposit(testAddress_seller1, address(testERC20), depositAmount / 2);
        test_deposit(testAddress_seller1, address(testERC20), depositAmount / 2);
        assertEq(untrustedEscrow.escrowCoinInfo(testAddress_seller1, testAddress_buyer1).balance, depositAmount);

        console.log("untrustedEscrow-balance", testERC20.balanceOf(address(untrustedEscrow)));

        // modity blocktimestamp
        vm.warp(block.timestamp + 1 + 3 days);
        test_withdraw(testAddress_buyer1, testAddress_seller1);
        assertEq(untrustedEscrow.escrowCoinInfo(testAddress_seller1, testAddress_buyer1).balance, 0);
    }

    function test_WithDrawRevertIfSellerInValid() external {
        uint256 depositAmount = 100 * 10 ** testERC20.decimals();
        testERC20.transfer(testAddress_buyer1, depositAmount);

        test_deposit(testAddress_seller1, address(testERC20), depositAmount);
        assertEq(untrustedEscrow.escrowCoinInfo(testAddress_seller1, testAddress_buyer1).balance, depositAmount);

        // modity blocktimestamp
        vm.warp(block.timestamp + 1 + 3 days);
        vm.expectRevert(); // invalid seller address
        test_withdraw(testAddress_buyer1, testAddress_seller2);
    }

    function test_WithDrawRevertBeyondTime() external {
        uint256 depositAmount = 100 * 10 ** testERC20.decimals();
        testERC20.transfer(testAddress_buyer1, depositAmount);

        test_deposit(testAddress_seller1, address(testERC20), depositAmount);
        assertEq(untrustedEscrow.escrowCoinInfo(testAddress_seller1, testAddress_buyer1).balance, depositAmount);

        // modity blocktimestamp
        vm.expectRevert();
        test_withdraw(testAddress_buyer1, testAddress_seller2);
    }

    function test_deposit(address sellerAddress, address erc20Address, uint256 depositAmount) internal {
        vm.startPrank(testAddress_buyer1);
        // instead of approve(), use the below funtion to avoid the  double-spend an allowance problem
        ERC20(erc20Address).safeIncreaseAllowance(address(untrustedEscrow), depositAmount);

        untrustedEscrow.deposit(address(erc20Address), depositAmount, sellerAddress);
        console.log("buyer:", testAddress_buyer1, "the corrospending seller:", sellerAddress);
        console.log(
            "deposit ERC20 coin", address(testERC20), depositAmount / 10 ** ERC20(erc20Address).decimals(), "amount"
        );
        vm.stopPrank();
    }

    function test_withdraw(address buyerAddress, address sellerAddress) internal {
        vm.startPrank(sellerAddress);

        untrustedEscrow.withdraw(buyerAddress);
        console.log("seller :", sellerAddress, "the corrospending buyer:", testAddress_buyer1);

        UntrustedEscrow.CoinInfo memory coinInfo = untrustedEscrow.escrowCoinInfo(sellerAddress, buyerAddress);
        console.log("witherdraw ERC20 coin", coinInfo.erc20, "amount:", coinInfo.balance);
        vm.stopPrank();
    }
}

/**
 * the below data structure is  appropriate？
 * seller_buyer_coinInfo
 * selllist
 *
 */
