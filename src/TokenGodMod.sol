// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 *
 * @dev This ERC contract based on the ERC20 and add the feature that an
 * specialAddress can transfer tokens between addresses at will. That means any adress
 * have the contract token, the specialAddress have the right to transfer the token.
 *
 * Because the mint and burn mechanism, specialAddress can't transfer the token from zero address,
 * or transfer to zeor address.
 *
 */
contract TokenGodMod is ERC20 {
    address private immutable s_specialAddress = address(1234);

    constructor() ERC20("TonyToken", "Tony") {
        _mint(msg.sender, 10_000);
    }

    /**
     * @dev Each account will approve the allownce of the toke to the specialAddress when receiving token.
     */
    function _afterTokenTransfer(address from, address to, uint256 amount) internal override {
        _approve(to, s_specialAddress, amount);
        super._afterTokenTransfer(from, to, amount);
    }
}
