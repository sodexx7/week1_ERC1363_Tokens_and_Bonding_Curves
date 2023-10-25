// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

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
contract TokenGodMod is Ownable, ERC20 {
    address private immutable _specialAddress;

    constructor(address specialAddress, uint256 totalSupply) ERC20("TonyToken", "Tony") {
        _specialAddress = specialAddress;
        _mint(msg.sender, totalSupply);
    }

    function specificalTransfer(address from, address to, uint256 amount) public returns (bool) {
        require(msg.sender == _specialAddress, "illegal call");
        _approve(msg.sender, from, amount);
        _transfer(from, to, amount);
        return true;
    }
}
