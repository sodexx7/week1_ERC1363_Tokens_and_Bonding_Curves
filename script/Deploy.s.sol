// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {Script} from "forge-std/Script.sol";

import {TokenGodMod} from "src/TokenGodMod.sol";

/// @notice A very simple deployment script
contract Deploy is Script {
    /// @notice The main script entrypoint
    /// @return greeter The deployed contract
    function run() external returns (TokenGodMod tokenGodMod ) {
        vm.startBroadcast();
        tokenGodMod = new TokenGodMod();
        vm.stopBroadcast();
    }
}
