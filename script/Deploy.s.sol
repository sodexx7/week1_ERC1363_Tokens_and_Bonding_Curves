// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import {Script} from "forge-std/Script.sol";

import {TokenGodMod} from "src/TokenGodMod.sol";

/// @notice A very simple deployment script
contract Deploy is Script {
    address specialAddress = address(1234);


    /// @notice The main script entrypoint
    /// @return tokenGodMod The deployed contract
    function run() external returns (TokenGodMod tokenGodMod ) {
        vm.startBroadcast();
        tokenGodMod = new TokenGodMod(specialAddress,10_000);
        vm.stopBroadcast();
    }
}
