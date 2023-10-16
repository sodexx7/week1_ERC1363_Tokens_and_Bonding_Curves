// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import {BancorFormula} from "./bancorprotocol/BancorFormula.sol";
import {Initializable} from "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ERC20, ERC1363, IERC1363Receiver} from "./erc1363-payable-token/ERC1363.sol";

/**
 * @title linear Bonding Curve
 * @author Tony
 * @notice
 * @dev  Bonding curve contract based on Bacor formula,my current implemention is linear bonding curve.
 *
 * There are two points should address:
 * 1: How to calculate how many  ERC1363BondingCurveToken should be minted  based on the buyer's token amount.
 * Use Bacor formula, and set the initialreserveBalance,initialSupply,RESERVE_RATION to make the linear curve. the details can see the test case.
 *
 * 2: If the initialSupply and initialreserveBalance are zero, It's can't calculate the price.So It's necessay to init these value and it's also a part of setting
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

contract ERC1363BondingCurveToken is Initializable, Ownable, ERC1363, BancorFormula {
    /*
    reserve ratio, represented in ppm, 1-1000000
    1/3 corresponds to y= multiple * x^2
    1/2 corresponds to y= multiple * x
    2/3 corresponds to y= multiple * x^1/2
    multiple will depends on contract initialization,
    specificallytotalAmount and reserveBalance parameters
    we might want to add an 'initialize' function that will allow
    the owner to send ether to the contract and mint a given amount of tokens
    */
    uint32 private immutable RESERVE_RATION = 500_000;

    // prevent the sandSwitch, more explanation can see test_PrteventSandSwitchByBuyBCT in ERC1363BondingCurveToken.t.sol
    uint256 private _gasPriceInWei; // maximum gas price for bancor transactions

    /* Reserve Token */
    ERC1363 private _reserveToken;

    /**
     *
     * @param sender the buyer
     * @param mintAmount how many bondingCurve Token will be minted
     * @param depositAmount how many reserveToken  will be deposited
     */
    event CurvedMint(address indexed sender, uint256 indexed mintAmount, uint256 depositAmount);
    /**
     *
     * @param sender the seller
     * @param burnAmount how many bondingCurve Token will be sell
     * @param redeemAmount how many reserveToken will be send to the bondingCurve contract
     */
    event CurvedBurn(address indexed sender, uint256 indexed burnAmount, uint256 redeemAmount);

    // prevent sandswtich, when one sells BCTToken, shouldn't beyond the time that he bought the BCTToken last time.
    error SellerBeyondCoolDownTime(address seller, uint256 lastBuyTime);

    // verifies that the gas price is lower than the universal limit
    modifier validGasPrice() {
        require(tx.gasprice <= _gasPriceInWei, "Below the required gas price");
        _;
    }

    modifier validEnoughBCT(uint256 burnAmount) {
        require(burnAmount > 0 && balanceOf(msg.sender) >= burnAmount, "No enough BCTTtoken to burn");
        _;
    }

    modifier validMint(uint256 depositAmount) {
        require(depositAmount > 0, "Should transfer enough reserveToken");
        _;
    }

    constructor() ERC20("ERC1363BondingCurveToken", "BCT1363") {}

    /**
     *
     * @param reserveToken:This token and the minted token as the bondingCurve pair
     * @param initialreserveBalance: the init balance of the reserveToken
     * @param initialSupply: the init supply of the bondingCurve Token
     * @param gasPrice  maximum gas price for bancor transactions
     * @dev  This funciton config the necessary params for the bondingCurve. should execute only one time
     *
     */
    function initialize(address reserveToken, uint256 initialreserveBalance, uint256 initialSupply, uint256 gasPrice)
        external
        onlyOwner
        initializer
    {
        _reserveToken = ERC1363(reserveToken);
        _gasPriceInWei = gasPrice;
        _mint(msg.sender, initialSupply);
        require(
            _reserveToken.transferFrom(msg.sender, address(this), initialreserveBalance),
            "ERC163BondingToken: Failed to transfer tokens for intial pool."
        );
    }

    /**
     *
     * @dev Implemet the function onTransferReceived in  IERC1363Receiver, when received the ERC1363token,It wiill mint the bondingCurve token
     */
    function onTransferReceived(
        address,
        /**
         * spender*
         */
        address sender,
        uint256 depositAmount,
        bytes calldata
    )
        /**
         * data*
         */
        external
        returns (bytes4)
    {
        require(msg.sender == address(_reserveToken), "illeage call");

        _curvedMintFor(sender, depositAmount); // do more check??? TODO

        return IERC1363Receiver.onTransferReceived.selector;
    }

    /**
     * @dev Allows the owner to update the gas price limit
     * @param _gasPrice The new gas price limit
     */
    function _setGasPrice(uint256 _gasPrice) external onlyOwner {
        require(_gasPrice > 0);
        _gasPriceInWei = _gasPrice;
    }

    /**
     * @dev Burn tokens
     * @param burnAmount Amount of bodingCurve tokens to burn
     *
     * @notice if _lastBuyBCTTime[msg.sender] is zero, perhaps other people send the seller BCTToken. just ignore.
     */
    function burn(uint256 burnAmount) external validGasPrice validEnoughBCT(burnAmount) {
        uint256 redeemAmount = _curvedBurnFor(msg.sender, burnAmount);
        require(_reserveToken.transfer(msg.sender, redeemAmount));
    }

    /**
     * @dev
     * while calculating the return amount based on the bondingCurve, reserveBalance and totalSupply all means current point.
     * Not the finished point after the order completed.
     *
     * When using ERC1363 and calculating the minted amont, because bondingCurve has already received the ERC1363 token, So should use:
     * reserveBalance()-amount
     */
    function calculateCurvedMintReturn(uint256 depositAmount) public view returns (uint256) {
        return calculatePurchaseReturn(totalSupply(), reserveBalance() - depositAmount, RESERVE_RATION, depositAmount);
    }

    function calculateCurvedBurnReturn(uint256 burnAmount) public view returns (uint256) {
        return calculateSaleReturn(totalSupply(), reserveBalance(), RESERVE_RATION, burnAmount);
    }

    function reserveBalance() public view returns (uint256) {
        return _reserveToken.balanceOf(address(this));
    }

    function _curvedMintFor(address user, uint256 depositAmount)
        internal
        validGasPrice
        validMint(depositAmount)
        returns (uint256)
    {
        uint256 mintAmount = calculateCurvedMintReturn(depositAmount);
        _mint(user, mintAmount);

        emit CurvedMint(user, mintAmount, depositAmount);
        return mintAmount;
    }

    function _curvedBurnFor(address user, uint256 burnAmount) internal returns (uint256) {
        uint256 redeemAmount = calculateCurvedBurnReturn(burnAmount);

        _burn(user, burnAmount);
        emit CurvedBurn(user, burnAmount, redeemAmount);
        return redeemAmount;
    }
}
