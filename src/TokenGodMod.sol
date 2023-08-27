// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

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
contract TokenGodMod is Ownable,ERC20 {
    address private  s_specialAddress;

    constructor(address specialAddress,uint256 totalSupply) ERC20("TonyToken", "Tony") {
        s_specialAddress = specialAddress;
        _mint(msg.sender, totalSupply);
    }
    
    /**
     * @dev Each account will approve the allownce of the toke to the specialAddress when receiving token.
     */
    function _afterTokenTransfer(address from, address to, uint256 amount) internal override {
        _approve(to, s_specialAddress, amount);
        super._afterTokenTransfer(from, to, amount);
    }

   
}
