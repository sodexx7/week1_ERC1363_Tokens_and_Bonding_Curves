// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "forge-std/Test.sol";

import {TonyToken} from "src/TonyToken.sol";
import "forge-std/Vm.sol";

contract TonyTokenTest is Test {
    TonyToken tonyToken;

    address bannedAddress = address(1234);
    address validAddress = address(12345);

    function setUp() external {
        tonyToken = new TonyToken();
    }

    function testManageBannedAddress() external {
        tonyToken.manageBannedAddress(bannedAddress, true);
    }

    function testNormalReceive() external {
        tonyToken.transfer(validAddress, 10);
        // todo assert
    }

    function testNormalTransfer() external {
        tonyToken.transfer(validAddress, 10);
        vm.prank(validAddress);
        tonyToken.transfer(0xb4c79daB8f259C7Aee6E5b2Aa729821864227e84, 10);
        // todo assert
    }

    function testRevert_Receive() external {
        tonyToken.manageBannedAddress(bannedAddress, true);
        vm.expectRevert(abi.encodeWithSignature("AddressCannotReceive()"));
        tonyToken.transfer(bannedAddress, 10);
    }

    function testRevert_Transfer() external {
        tonyToken.transfer(bannedAddress, 10);
        tonyToken.manageBannedAddress(bannedAddress, true);
        vm.prank(bannedAddress);
        vm.expectRevert(abi.encodeWithSignature("AddressCannotSend()"));
        tonyToken.transfer(0xb4c79daB8f259C7Aee6E5b2Aa729821864227e84, 10);
    }
}

// 1. basic test
//      admin can special address, which can't send or receive
//    more variations
//      1: the same special address can send or receive if not being set the specifical address
//      2: other no-spefifical address work ok
// 2. reference: the basic things ****
//      https://www.rareskills.io/post/foundry-testing-solidity
//      https://www.rareskills.io/post/foundry-forge-coverage
// 3. famaliar with the basic usages of the foundary
// 4. check override

// todo
//  1) revert test pass or fail
//  2) mapping value  get by storage
//  3) event test
//  4) capping amount modify
//  5) log test
//  6) more standard fondry test functions
