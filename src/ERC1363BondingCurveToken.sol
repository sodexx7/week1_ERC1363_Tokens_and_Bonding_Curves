// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import {BancorFormula} from "./bancorprotocol/BancorFormula.sol";
import {Initializable} from "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ERC20,ERC1363,IERC1363Receiver} from "./erc1363-payable-token/ERC1363.sol";

/**
 * @title linear Bonding Curve
 * @author Tony
 * @notice 
 * @dev  Bonding curve contract based on Bacor formula,my current implemention is linear bonding curve.
 * 
 * There are two points should address:
 * 1: How to calculate how many  ERC1363BondingCurveToken should be minted  based on the buyer's token amount.
 * Use Bacor formula, and set the initialPoolBalance,initialSupply,RESERVE_RATION to make the linear curve. the details can see the test case.
 *
 * 2: If the initialSupply and initialPoolBalance are zero, It's can't calculate the price.So It's necessay to init these value and it's also a part of setting
 * the Bacor formula.
 *
 *
 * inspired by bancor protocol and Slava Balasanov
 * https://github.com/tarrencev/curve-bonded-tokens/blob/master/contracts/BondingCurveToken.sol
 * https://github.com/bancorprotocol/contracts-solidity/blob/v1.22.10/solidity/contracts/converter/BancorFormula.sol (Bancor offical code )
 *
 * other references
 * https://github.com/relevant-community/bonding-curve/blob/master/contracts/BondingCurve.sol
 * https://github.com/ConsenSys/curationmarkets/blob/master/CurationMarkets.sol
 *
 * ERC1363
 * https://github.com/vittominacori/erc1363-payable-token/blob/v4.9.3/contracts/token/ERC1363/ERC1363.sol
 */

contract ERC1363BondingCurveToken is Initializable,Ownable, ERC1363, BancorFormula {

    /*
    reserve ratio, represented in ppm, 1-1000000
    1/3 corresponds to y= multiple * x^2
    1/2 corresponds to y= multiple * x
    2/3 corresponds to y= multiple * x^1/2
    multiple will depends on contract initialization,
    specificallytotalAmount and poolBalance parameters
    we might want to add an 'initialize' function that will allow
    the owner to send ether to the contract and mint a given amount of tokens
    */
    uint32 private immutable RESERVE_RATION = 500_000;

    // prevent the sandSwitch, more explanation can see test_PrteventSandSwitchByBuyBCT in ERC1363BondingCurveToken.t.sol
    uint256 private gasPrice = 0 wei; // maximum gas price for bancor transactions

    /* Reserve Token */
    ERC1363 private reserveToken;

    event CurvedMint(address sender, uint256 amount, uint256 deposit);
    event CurvedBurn(address sender, uint256 amount, uint256 reimbursement);


    // verifies that the gas price is lower than the universal limit
    modifier validGasPrice() {
        assert(tx.gasprice <= gasPrice);
        _;
    }

    modifier validBurn(uint256 amount) {
        require(amount > 0 && balanceOf(msg.sender) >= amount);
        _;
    }

    modifier validMint(uint256 amount) {
        require(amount > 0);
        _;
    }

    constructor() ERC20("ERC1363BondingCurveToken", "BCT1363") {}

    /**
     *   
     * @param _reserveToken:This token and the minted token as the bondingCurve pair
     * @param _initialPoolBalance: the init balance of the reserveToken
     * @param _initialSupply: the init supply of the bondingCurve Token
     * @param _gasPrice  maximum gas price for bancor transactions
     * @dev  
     * 
     * 
     */
    function initialize(address _reserveToken,uint256 _initialPoolBalance,uint256 _initialSupply, uint256 _gasPrice) external onlyOwner  {
        reserveToken = ERC1363(_reserveToken);
        gasPrice = _gasPrice;
        _mint(msg.sender, _initialSupply);
        require(
            reserveToken.transferFrom(msg.sender, address(this), _initialPoolBalance),
            "ERC163BondingToken: Failed to transfer tokens for intial pool."
        );
    }

     function onTransferReceived(address spender, address sender, uint256 amount, bytes calldata data)
        external
        returns (bytes4)
    {
        _curvedMintFor(sender, amount);// do more check??? TODO
        return IERC1363Receiver.onTransferReceived.selector;
    }
   
    /**
     * @dev Burn tokens
     * @param amount Amount of tokens to withdraw
     */
    function burn(uint256 amount) external {
          uint256 reimbursement = _curvedBurnFor(msg.sender, amount);
          reserveToken.transfer(msg.sender, reimbursement);
    }

    /**
     * @dev
     * while calculating the return amount based on the bondingCurve, poolBalance and totalSupply all means current point.
     * Not the finished point after the order completed.
     * 
     * When using ERC1363 and calculating the minted amont, because bondingCurve has already received the ERC1363 token, So should use:
     * poolBalance()-amount
     */
     function calculateCurvedMintReturn(uint256 amount) public view returns (uint256) {
        return calculatePurchaseReturn(totalSupply(), poolBalance()-amount, RESERVE_RATION, amount);
    }

    function calculateCurvedBurnReturn(uint256 amount) public view returns (uint256) {
        return calculateSaleReturn(totalSupply(), poolBalance(), RESERVE_RATION, amount);
    }

    function poolBalance() public view returns (uint256) {
        return reserveToken.balanceOf(address(this));
    }


     function _curvedMintFor(address user, uint256 deposit)
        private
        validGasPrice
        validMint(deposit)
        returns (uint256)
    {
        uint256 amount = calculateCurvedMintReturn(deposit);
        _mint(user, amount);
        emit CurvedMint(user, amount, deposit);
        return amount;
    }

    function _curvedBurnFor(address user, uint256 amount) private validGasPrice validBurn(amount) returns (uint256) {
        uint256 reimbursement = calculateCurvedBurnReturn(amount);

        _burn(user, amount);
        emit CurvedBurn(user, amount, reimbursement);
        return reimbursement;
    }

     /**
     * @dev Allows the owner to update the gas price limit
     * @param _gasPrice The new gas price limit
     */
    function _setGasPrice(uint256 _gasPrice) external onlyOwner  {
        require(_gasPrice > 0);
        gasPrice = _gasPrice;
    }
}
