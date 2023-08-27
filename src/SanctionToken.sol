// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/**
 *
 * @dev This contract based on the ERC20 and add the feature that the owner
 * of this contract can ban the specifical address from sending and receiving tokens.
 *
 */
contract SanctionToken is ERC20, Ownable {
    // mapping specifical address to be banned or valid
    mapping(address => bool) private s_bannedAddresses;

    event BannedAddressEvent(address indexed admin, address indexed to, bool isInValid);

    error AddressCannotSend();
    error AddressCannotReceive();

    constructor(uint256 _initSupply, string memory _name, string memory _symbol) ERC20(_name, _symbol) {
        _mint(msg.sender, _initSupply);
    }

    /**
     * @dev the bannedAddress shouldn't be the zero address. Firstly it doesn't fit the actual case;
     * Secondly it's related with the burning and minting. The buring can't tranfer token to zero address,
     * The minting can't transfer from zero address.
     */
    function manageBannedAddress(address bannedAddress, bool isInValid) external onlyOwner {
        require(bannedAddress != address(0), "can't ban the zero address");

        s_bannedAddresses[bannedAddress] = isInValid;
        emit BannedAddressEvent(msg.sender, bannedAddress, isInValid);
    }

    /**
     * @dev Apply the hook(_beforeTokenTransfer),which has effects on transfer token, mint, burn. For mint and
     * burn, should add one check to make sure the specifical address can't as the `to`(zero address) address while
     * minting or can't as the `from`(zero address)  address while buring.
     *
     */
    function _beforeTokenTransfer(address from, address to, uint256 amount) internal override {
        if (s_bannedAddresses[from]) {
            revert AddressCannotSend();
        }
        if (s_bannedAddresses[to]) {
            revert AddressCannotReceive();
        }
        super._beforeTokenTransfer(from, to, amount);
    }
}
