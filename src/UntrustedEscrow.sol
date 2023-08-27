// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/security/ReentrancyGuard.sol";

import {Pausable} from "@openzeppelin/contracts/security/Pausable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";


/**
 *
 * @dev
 * one buyer can put an arbitrary ERC20 token along with the seller address who can withdraw all the deposit after 3 days. 
 * 
 * security issues
 *  1)  ERC20 security issues
 *      1: instead of approve(), use safeIncreaseAllowance to avoid the  double-spend an allowance problem
 *      2: safeTransferFrom or safeTransferFrom, which add more check that not return bool.
 *      3. For Reentrant problem, use  RnonReentrant(ReentrancyGuard), and  do the checks_effects_interactions no matter in the deposit or withdraw funciton
 * 
 *  2) Other security issues
 *      1:buy can put an arbitrary ERC20 token, current solidity version > 0.8.0. There are no overflow or underflow.
 *      2. add  Pausable,Ownable, which the owner can pause all the funcitons preventing the unexpected behaviour. 
 *      3: The specifical ERC20 supply mechniasm. the supply is changing according to some conditions. which will leads to the conflict between the UntrustedEscrow's
 *   balance and the corrospending erc20's balance. For now. no better sultion. just ignore. TODO
 *               1:Fee-on-transfer tokens , this mechniasm leads to the actual received amount less than the input amount?
 *                   shoud consider, It seems make the contract more complex.
 *               2: Rebasing tokens
 *              automatically decrease or increase based on their mechanism, which leads to eller_buyer_coin[sellerAddress][msg.sender] balance not 
 * 
 *  
 */
contract UntrustedEscrow is ReentrancyGuard,Pausable,Ownable {

    using SafeERC20 for ERC20;
    
    /**
     * @dev when an buyer deposit arbitrary ERC20 token, shoud store the ERC20 token address, and the corrospending amount, and the depositTimestamp.
     */
    struct CoinInfo {
        address erc20;
        uint256 balance;
        uint256 depositTimestamp;
    }


    // seller=>buyer=>ConInfo 
    mapping(address => mapping(address => CoinInfo)) private seller_buyer_coinInfo;

    // check seller is exsit
    mapping(address => bool) private sellList;


    event Deposit(address indexed buyer, address indexed seller, address indexed erc20Token, uint256 amount);
    event Withdraw(address indexed seller, address indexed buyer, address indexed erc20Token, uint256 amount);


    error NoValiableBalance();
    error BeyondTime();
   

    modifier validSeller(address seller) {
        require(sellList[seller],"invalid seller address");
        _;
    }


    /**
     * @param erc20Token which token to deposit
     * @param amount how much erc20Token to deposit
     * @param sellerAddress who can withdraw the deposit
     */
    function deposit(address erc20Token, uint256 amount, address sellerAddress) external {
        require(sellerAddress != address(0), "sellerAddress is the zero address");
        require(amount > 0, "deposit value should great than 0");
        
        CoinInfo memory coinInfo;
        if(sellList[sellerAddress]){

            coinInfo = seller_buyer_coinInfo[sellerAddress][msg.sender]; 
            coinInfo.depositTimestamp = block.timestamp;
            coinInfo.balance = coinInfo.balance + amount;

        } else{
            
            coinInfo =  CoinInfo(erc20Token,amount,block.timestamp);
            sellList[sellerAddress] = true;
        }
        seller_buyer_coinInfo[sellerAddress][msg.sender] = coinInfo;
        
        ERC20(erc20Token).safeTransferFrom(msg.sender,address(this), amount);

        
        emit Deposit(msg.sender, sellerAddress, erc20Token, amount);
    }

    /**
     * @param buyer the caller can withdraw whose deposit
     */
    function withdraw(address buyer) external validSeller(msg.sender) nonReentrant() {

        require(
            block.timestamp - seller_buyer_coinInfo[msg.sender][buyer].depositTimestamp > 3 days,
            "Should withdraw after 3 days"
        );

        CoinInfo memory coinInfo = seller_buyer_coinInfo[msg.sender][buyer];

        require(coinInfo.balance >0,"No Enough Balance");

        delete seller_buyer_coinInfo[msg.sender][buyer];

        // seller can withdraw which buyer's which erc20 balance
        ERC20(coinInfo.erc20).safeTransfer(msg.sender, coinInfo.balance);

        emit Withdraw(
            msg.sender,
            buyer,
            seller_buyer_coinInfo[msg.sender][buyer].erc20,
            seller_buyer_coinInfo[msg.sender][buyer].balance
        );
    }

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }

    function escrowCoinInfo(address seller, address buyer) external view returns (CoinInfo memory) {
        return seller_buyer_coinInfo[seller][buyer];
    }
}
