// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./BondingCurveToken.sol";
import "./erc1363-payable-token/ERC1363.sol";
import "./erc1363-payable-token/ERC1363.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

import "forge-std/console.sol";

/**
 * @title ERC1363BondingCurveToken
 * @dev Bonding curve contract based on Bacor formula,my current implemention is linear bonding curve.
 *
 * 
 * There are two points should address:
 * 1: How to calculate how many  ERC1363BondingCurveToken should be mint  based on the buyer's token amount?
 * Use Bacor formula, and set the initialPoolBalance,initialSupply,reserveRatio to make the linear curve. the details can see the test case. 
 * 
 * 2: If the initialSupply and initialPoolBalance are zero, It's can't calculate the price.So It's necessay to init these value and it's also a part of setting 
 * the Bacor formula.
 * 
 * 
 * 
 *
 * inspired by bancor protocol and Slava Balasanov
 * https://github.com/tarrencev/curve-bonded-tokens/blob/master/contracts/BondingCurveToken.sol
 * https://github.com/bancorprotocol/contracts-solidity/blob/v1.22.10/solidity/contracts/converter/BancorFormula.sol (Bancor offical code )
 * 
 * other references
 * https://github.com/relevant-community/bonding-curve/blob/master/contracts/BondingCurve.sol
 * 
 * ERC1363
 * https://github.com/vittominacori/erc1363-payable-token/blob/v4.9.3/contracts/token/ERC1363/ERC1363.sol
 * 
 * TODO
 * 1: how to prevent from the sandswitch? gasprice?
 * 2: Are there some problem with the increament counts each time? done
 * 3. Some uncessary code should elimate
 * 4. The seller beyond the pool. how to deal with the situaiton? done
 * 5. fraction done
 */
contract ERC1363BondingCurveToken is Ownable, ERC1363, BondingCurveToken {

    error NoEnoughtBCTToken();
    /* Reserve Token */
    ERC1363 public reserveToken;


    modifier enoughEnoughtBCTToken(uint256 amount) {
        if(amount> balanceOf(msg.sender)){
            revert NoEnoughtBCTToken();
        }
        _;
    }

     constructor() ERC20("ERC1363BondingCurveToken", "BCT1363") {
        
    }

    function initialize(ERC1363 _reserveToken, uint256 _initialPoolBalance, uint256 _initialSupply, uint32 _reserveRatio, uint256 _gasPrice) onlyOwner public {
        reserveToken = _reserveToken;
        require(reserveToken.transferFrom(msg.sender, address(this), _initialPoolBalance), "ERC20BondingToken: Failed to transfer tokens for intial pool.");
        BondingCurveToken.initialize(_initialSupply, _reserveRatio, _gasPrice);
  }

    function mint(uint256 amount) public {
        _curvedMint(amount);
        require(reserveToken.transferFromAndCall(msg.sender,address(this), amount));
    }

    function burn(uint256 amount) enoughEnoughtBCTToken(amount)public {
         _curvedBurn(amount);
    }

    /**
     * @dev Mint tokens
     *
     * @param amount Amount of tokens to deposit
    //  */
    function _curvedMint(uint256 amount) internal virtual override returns (uint256) {
        super._curvedMint(amount);
    }

    function poolBalance() public view virtual override returns (uint256){
        return reserveToken.balanceOf(address(this));
    }
    /**
     * @dev Burn tokens
     *
     * @param amount Amount of tokens to burn
     */
    function _curvedBurn(uint256 amount) internal virtual override returns (uint256) {
        uint256 reimbursement = super._curvedBurn(amount);
        reserveToken.transfer(msg.sender, reimbursement);
    }

    function onTransferReceived(address spender, address sender, uint256 amount, bytes calldata data)
        external
        returns (bytes4)
    {
        // todo, if want to directly send token and trigger the swap funciton
        return IERC1363Receiver.onTransferReceived.selector;
    }

}
