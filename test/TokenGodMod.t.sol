// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "forge-std/Test.sol";

import {TokenGodMod} from "src/TokenGodMod.sol";
import "forge-std/Vm.sol";
import "forge-std/console.sol";

contract TokenGodModTest is Test {
    TokenGodMod tokenGodMod;

    address specialAddress = address(1234);
    address testAddress1 = address(12345);
    address testAddress2 = address(123456);

    function setUp() external {
        tokenGodMod = new TokenGodMod(specialAddress,10_000);
    }

    // specialAddress transfer all TokenGodMod's balance of  address(0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496) to testAddress1
    function test_TransferAll() external {
        console.log("balance", tokenGodMod.balanceOf(0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496));
        vm.prank(specialAddress);
        tokenGodMod.transfer(testAddress1, tokenGodMod.balanceOf(0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496));
        assertEq(tokenGodMod.balanceOf(testAddress1), 10000);
        assertEq(tokenGodMod.balanceOf(0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496), 0);
    }

    //  testAddress2 have 200 TokenGodMod, specialAddress transfer 100 TokenGodMod from testAddress2 to testAddress1.
    function test_TransferPart() external {
        tokenGodMod.transfer(testAddress2, 200);
        vm.prank(specialAddress);
        tokenGodMod.transferFrom(testAddress2, testAddress1, 100);
        assertEq(tokenGodMod.balanceOf(testAddress2), 100);
        assertEq(tokenGodMod.balanceOf(testAddress1), 100);
    }
}
