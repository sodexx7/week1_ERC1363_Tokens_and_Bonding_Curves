// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {ERC20, ERC1363} from "../src/erc1363-payable-token/ERC1363.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/**
 *
 * @dev test Token for bondingCurve
 *
 */
contract ERC1363TokenForEchidna is ERC1363,Ownable {

    function mint(address receivedAddress,uint amount) public onlyOwner()  {
        _mint(receivedAddress, amount);

    }

    constructor() ERC20("ERC1363TokenForEchidna", "TFE") Ownable() {
    }
}
