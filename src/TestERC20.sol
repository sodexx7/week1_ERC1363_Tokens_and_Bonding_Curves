// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**
 *
 * @dev test Token for UntrustedEscrow
 *
 */
contract TestERC20 is ERC20 {
    constructor() ERC20("TestERC20", "TTERC") {
        _mint(msg.sender, 10_000 * 10 ** decimals());
    }
}
