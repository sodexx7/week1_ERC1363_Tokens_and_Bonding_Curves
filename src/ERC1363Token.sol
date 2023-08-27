// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./erc1363-payable-token/ERC1363.sol";

/**
 *
 * @dev test Token for bondingCurve
 *
 */
contract ERC1363Token is ERC1363 {
    constructor() ERC20("TonyTokenERC1363", "TT1363") {
        _mint(msg.sender, 10_000 * 10 ** decimals());
    }

}
