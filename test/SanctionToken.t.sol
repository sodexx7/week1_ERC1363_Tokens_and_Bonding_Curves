// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "forge-std/Test.sol";

import "forge-std/Vm.sol";
import "forge-std/console.sol";

import {SanctionToken} from "src/SanctionToken.sol";


contract SanctionTokenTest is Test {
    SanctionToken sanctionToken;

    address bannedAddress = address(1234);
    address validAddress = address(12345);
    address validAddress2 = address(123456);

    function setUp() external {
        sanctionToken = new SanctionToken(10_000,"SanctionToken","ST");
        
    }

    function testManageBannedAddress() external {
        sanctionToken.manageBannedAddress(bannedAddress, true);
    }
    // function testManageBannedAddressEvent() external {
    //     sanctionToken.manageBannedAddress(bannedAddress, true);
    // }

    function testNormalReceive() external {
        sanctionToken.transfer(validAddress, 10);
        assertEq(sanctionToken.balanceOf(validAddress),10);
    }

    function testNormalTransfer() external {
        sanctionToken.transfer(validAddress, 10);
        vm.prank(validAddress);
        sanctionToken.transfer(validAddress2, 10);
        assertEq(sanctionToken.balanceOf(validAddress2),10);
    }

    function testRevert_Receive() external {
        sanctionToken.manageBannedAddress(bannedAddress, true);
        vm.expectRevert(abi.encodeWithSignature("AddressCannotReceive()"));
        sanctionToken.transfer(bannedAddress, 10);
    }

    function testRevert_Transfer() external {
        sanctionToken.transfer(bannedAddress, 10);
        sanctionToken.manageBannedAddress(bannedAddress, true);
        vm.prank(bannedAddress);
        vm.expectRevert(abi.encodeWithSignature("AddressCannotSend()"));
        sanctionToken.transfer(0xb4c79daB8f259C7Aee6E5b2Aa729821864227e84, 10);
    }
}