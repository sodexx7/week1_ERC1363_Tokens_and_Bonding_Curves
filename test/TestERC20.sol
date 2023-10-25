// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

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

contract TestERC20WithFees is ERC20 {
    constructor() ERC20("TestERC20", "TTERC") {
        _mint(msg.sender, 10_000 * 10 ** decimals());
    }

    // simply mock the transfer with some fees which be burned
    function transferFrom(address from, address to, uint256 amount) public virtual override returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount - 100);
        return true;
    }
}
