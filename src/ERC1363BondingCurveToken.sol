// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./bancorprotocol/BancorFormula.sol";
import "./erc1363-payable-token/ERC1363.sol";
import "forge-std/console.sol";
import "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title Bonding Curve
 * 
 *  @dev Bonding curve contract based on Bacor formula,my current implemention is linear bonding curve.
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
 *
 * TODO
 * 4. The seller beyond the pool. how to deal with the situaiton? done
 * 5. fraction done
 * 
 * 
 */
contract ERC1363BondingCurveToken is Initializable,Ownable, ERC1363, BancorFormula {
     error NoEnoughtBCTToken();
    
    /* Reserve Token */
    ERC1363 public reserveToken;


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
    uint32 public reserveRatio;

    /*
    - Front-running attacks are currently mitigated by the following mechanisms:
    TODO - minimum return argument for each conversion provides a way to define a minimum/maximum price for the transaction
    - gas price limit prevents users from having control over the order of execution
    */
    uint256 public gasPrice = 0 wei; // maximum gas price for bancor transactions

    event CurvedMint(address sender, uint256 amount, uint256 deposit);
    event CurvedBurn(address sender, uint256 amount, uint256 reimbursement);


    function initialize(address _reserveToken,uint256 _initialPoolBalance,uint256 _initialSupply, uint32 _reserveRatio, uint256 _gasPrice) public onlyOwner  {
        reserveToken = ERC1363(_reserveToken);
        reserveRatio = _reserveRatio;
        gasPrice = _gasPrice;
        _mint(msg.sender, _initialSupply);
        require(
            reserveToken.transferFrom(msg.sender, address(this), _initialPoolBalance),
            "ERC163BondingToken: Failed to transfer tokens for intial pool."
        );
    }
   

    function mint(uint256 amount) public {
        _curvedMintFor(msg.sender, amount);
        require(reserveToken.transferFrom(msg.sender, address(this), amount));
    }
    /**
     * @dev Burn tokens
     * @param amount Amount of tokens to withdraw
     */
    function burn(uint256 amount) public {
          uint256 reimbursement = _curvedBurnFor(msg.sender, amount);
          reserveToken.transfer(msg.sender, reimbursement);
    }


    function _curvedMintFor(address user, uint256 deposit)
        internal
        validGasPrice
        validMint(deposit)
        returns (uint256)
    {
        uint256 amount = calculateCurvedMintReturn(deposit);
        _mint(user, amount);
        emit CurvedMint(user, amount, deposit);
        return amount;
    }


    function _curvedBurnFor(address user, uint256 amount) internal validGasPrice validBurn(amount) returns (uint256) {
        uint256 reimbursement = calculateCurvedBurnReturn(amount);

        _burn(user, amount);
        emit CurvedBurn(user, amount, reimbursement);
        return reimbursement;
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
        return calculatePurchaseReturn(totalSupply(), poolBalance()-amount, reserveRatio, amount);
    }

    function calculateCurvedBurnReturn(uint256 amount) public view returns (uint256) {
        return calculateSaleReturn(totalSupply(), poolBalance(), reserveRatio, amount);
    }

    /**
     * @dev Allows the owner to update the gas price limit
     * @param _gasPrice The new gas price limit
     */
    function _setGasPrice(uint256 _gasPrice) internal {
        require(_gasPrice > 0);
        gasPrice = _gasPrice;
    }

    /**
     * @dev Abstract method that returns pool balance todo
     */
    function poolBalance() public view virtual  returns (uint256) {
        return reserveToken.balanceOf(address(this));
    }

    function onTransferReceived(address spender, address sender, uint256 amount, bytes calldata data)
        external
        returns (bytes4)
    {
        _curvedMintFor(sender, amount);
        // todo, if want to directly send token and trigger the swap funciton
        return IERC1363Receiver.onTransferReceived.selector;
    }
}
