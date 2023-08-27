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
 *      2. add  Pausable,Ownable. which the owner can pause all the funcitons preventing the unexpected behaviour. 
 *      3: The specifical ERC20 supply mechniasm. the supply is changing according to some conditions. which will leads to the conflict between the UntrustedEscrow's
 *   balance and the corrospending erc20's balance. For now. no better sultion. just ignore. TODO
 *              // specifical ERC20 implementation
 *               // 1:Fee-on-transfer tokens , this mechniasm leads to the actual received amount less than the input amount?
 *               //  shoud consider, It seems make the contract more complex.
 *               // 2: Rebasing tokens
 *               //  automatically decrease or increase based on their mechanism, which leads to eller_buyer_coin[sellerAddress][msg.sender] balance not 
 *               // ERC20(erc20Token).balanceOf(address(this)) can track the balance, but if more buyers send same erc20 tokens???
 *      
 * 
 *
 */
contract UntrustedEscrow is ReentrancyGuard,Pausable,Ownable  {
    using SafeERC20 for ERC20;
    struct CoinInfo {
        address erc20;
        uint256 balance;
        uint256 depositTimestamp;
    }

    uint256 private depositTimestamp;

    // seller=>buyer=>ConInfo 
    mapping(address => mapping(address => CoinInfo)) seller_buyer_coinInfo;

    // check selllist is exsit
    mapping(address => bool) selllist;


    event Deposit(address indexed buyer, address indexed seller, address indexed erc20Token, uint256 amount);
    event Withdraw(address indexed seller, address indexed buyer, address indexed erc20Token, uint256 amount);


    error NoValiableBalance();
    error BeyondTime();
   

     modifier validSeller(address seller) {
        require(selllist[seller],"invalid seller address");
        _;
    }

    /**
     * deposit arbitrary ERC20 to this address
     * @param erc20Token which token to deposit
     * @param amount how much
     * @param sellerAddress the related seller
     */
    function deposit(address erc20Token, uint256 amount, address sellerAddress) external {
        require(sellerAddress != address(0), "sellerAddress is the zero address");
        require(amount > 0, "deposit value should great than 0");
        
        CoinInfo memory coinInfo;
        if(selllist[sellerAddress]){

            coinInfo = seller_buyer_coinInfo[sellerAddress][msg.sender]; 
            coinInfo.depositTimestamp = block.timestamp;
            coinInfo.balance = coinInfo.balance + amount;

        } else{
            
            coinInfo =  CoinInfo(erc20Token,amount,block.timestamp);
            selllist[sellerAddress] = true;
        }
        seller_buyer_coinInfo[sellerAddress][msg.sender] = coinInfo;
        
        ERC20(erc20Token).safeTransferFrom(msg.sender,address(this), amount);

        
        emit Deposit(msg.sender, sellerAddress, erc20Token, amount);
    }

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

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function escrowCoinInfo(address seller, address buyer) public view returns (CoinInfo memory) {
        return seller_buyer_coinInfo[seller][buyer];
    }
}

/**
 * Create a contract where a buyer can put an arbitrary ERC20 token into a contract and a seller can withdraw it 3 days later.
 *  Based on your readings above, what issues do you need to defend against? Create the safest version of this that you can while guarding against issues that you cannot control.
 */

/**
 * tood
 * 1.code adjust
 * 2. coinfo data structure adjust
 * 3. how to test these security issues
 *
 * 
 * doing
 * 
 * security issues
 * 1. arbitrary ERC20
 * 
 * 
 * 1.basic features
 *  basic logic
 * 2.security issues
 *  1)  ERC20 security issues
 *      1: instead of approve(), use safeIncreaseAllowance to avoid the  double-spend an allowance problem
 *      2: safeTransferFrom or safeTransferFrom, which add more check that not return bool.
 *      3. For Reentrant problem, use  RnonReentrant(ReentrancyGuard), and  do the checks_effects_interactions no matter in the deposit or withdraw funciton
 * 
 *  2) Other security issues
 *      1:buy can put an arbitrary ERC20 token, current solidity version > 0.8.0. There are no overflow or underflow.
 *      2. add  Pausable,Ownable. which the owner can pause all the funcitons preventing the unexpected behaviour. 
 *      3: The specifical ERC20 supply mechniasm. the supply is changing according to some conditions. which will leads to the conflict between the UntrustedEscrow's
 *   balance and the corrospending erc20's balance. For now. no better sultion. just ignore. TODO
 *              // specifical ERC20 implementation
 *               // 1:Fee-on-transfer tokens , this mechniasm leads to the actual received amount less than the input amount?
 *               //  shoud consider, It seems make the contract more complex.
 *               // 2: Rebasing tokens
 *               //  automatically decrease or increase based on their mechanism, which leads to eller_buyer_coin[sellerAddress][msg.sender] balance not 
 *               // ERC20(erc20Token).balanceOf(address(this)) can track the balance, but if more buyers send same erc20 tokens???
 *      
 * 
 * 
 * 
 * * possible security issues:
 * 1)business loigc
 * 
 * 
 * 
 * 
 * 
 * now doing:
 * 1)basic feature done
 * 1. buy and transfer done
 * 2. seller withdraw only after 3 days. done
 * 3. add modify buyer and sellers  doing
 * 
 *      
 * 4. name beauty
 * 
 *
 * todo
 * 1.test case add test balanceOf funcitons
 * 2. which quesitons should summary?
 * 
 *
 */