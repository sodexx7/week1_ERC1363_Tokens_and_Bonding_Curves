// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./bancorprotocol/BancorFormula.sol";
import "./erc1363-payable-token/ERC1363.sol";

import "@openzeppelin/contracts/proxy/utils/Initializable.sol";

/**
 * @title Bonding Curve
 * @dev Bonding curve contract based on Bacor formula
 * inspired by bancor protocol and simondlr
 * https://github.com/bancorprotocol/contracts
 * https://github.com/ConsenSys/curationmarkets/blob/master/CurationMarkets.sol
 */
abstract contract BondingCurveToken is Initializable, ERC1363, BancorFormula {
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

    function initialize(uint256 _initialSupply, uint32 _reserveRatio, uint256 _gasPrice) public payable initializer {
        reserveRatio = _reserveRatio;
        gasPrice = _gasPrice;
        _mint(msg.sender, _initialSupply);
    }

    function calculateCurvedMintReturn(uint256 amount) public view returns (uint256) {
        return calculatePurchaseReturn(totalSupply(), poolBalance(), reserveRatio, amount);
    }

    function calculateCurvedBurnReturn(uint256 amount) public view returns (uint256) {
        return calculateSaleReturn(totalSupply(), poolBalance(), reserveRatio, amount);
    }

    /**
     * @dev Mint tokens
     */
    function _curvedMint(uint256 deposit) internal virtual returns (uint256) {
        return _curvedMintFor(msg.sender, deposit);
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

    /**
     * @dev Burn tokens
     * @param amount Amount of tokens to withdraw
     */
    function _curvedBurn(uint256 amount) internal virtual returns (uint256) {
        return _curvedBurnFor(msg.sender, amount);
    }

    function _curvedBurnFor(address user, uint256 amount) internal validGasPrice validBurn(amount) returns (uint256) {
        uint256 reimbursement = calculateCurvedBurnReturn(amount);

        _burn(user, amount);
        emit CurvedBurn(user, amount, reimbursement);
        return reimbursement;
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
    function poolBalance() public view virtual returns (uint256);

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
}
