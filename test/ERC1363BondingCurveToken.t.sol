// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;



import "forge-std/Test.sol";
import "forge-std/Vm.sol";
import "forge-std/console.sol";
import {ERC1363BondingCurveToken} from "src/ERC1363BondingCurveToken.sol";
import {ERC1363Token} from "src/ERC1363Token.sol";

/**
 * TODO
 * 1. Use foundry's fuzz test and invariant-testing
 */
contract ERC1363BondingCurveTokenTest is Test,ERC1363BondingCurveToken {
    ERC1363BondingCurveToken eRC1363BondingCurveToken;

    address private buyerAddress = address(123123123123123);

    ERC1363Token buyerToken;

    function setUp() external {
        // Create the ERC1363 token, which can buy eRC1363BondingCurveToken. The default supply is 10_000**18, 1000*10**9 was sent to test address buyerAddress
        buyerToken = new ERC1363Token();

        // send buyerAddress 1000*10**9 ERC1363 token
        buyerToken.transfer(buyerAddress, 1000*10**9);     

         /**
         * 
         * https://www.desmos.com/calculator/rvqihgsebu
         * The init params as this:https://www.desmos.com/calculator/3ww16tgsma
         * slope, also as r, equal 0.5 
         * The initSupply equal 1000 and the price at 1000 amount euqal 1000, so the initPoolBalace equal (1/2)*1000^2= 500*1000.
         * 
         * For the buyer Token, To make the question simple, as the above show. the init buyerTokenAmount*buyerTokenPrice should equal 500*1000.
         * which means the buyer Token's price at 500 amount also should euqal 1000.  
         * 
         * As all these done, The current bonding curve is f(x)=x, f(x) equal the current price. and the init value for x euqal 1000.
         * x means the ERC1363BondingCurveToken supply. 
         * f(x) means the corrrospending price, which can convert into the ERC1363Token amount:1/2(1000^2)/1000  
         * That can be show in the https://www.desmos.com/calculator/3ww16tgsma. 
         * 
         * 
         * The corrrospending token: 
         * ERC1363BondingCurveToken 1000
         * ERC1363Token             500
         * 
         * 
         * 
         * Another explaination can see below
         * referene: https://billyrennekamp.medium.com/converting-between-bancor-and-bonding-curve-price-formulas-9c11309062f5
         * 
         * CW = 1 / (n + 1) where n is the exponent
         * m = collateral / (CW * tokenSupply ^ (1 / CW))
         * 
         * CW = 1/2, n = 1 ----> f(x) = mx
         * The bondingCurve there use is f(x) = x.
         *  n=1, so CW=1/2
         * get collateral=	1/2*tokenSupply^2
         * 
         * when set initialSupply = 1000, the collateral value should equal 500*1000.  we set the initialPoolBalance equal 500.   
         * 
         * 
         * Beside initialSupply and initialPoolBalance, set reserveRatio value(500000). this make the bonding curve equal f(x)=x  
         * 
         */

        uint256 initialPoolBalance = 500;
        uint256 initialSupply = 1000;

        // equal 50%   reference:https://www.learningaboutelectronics.com/Articles/PPM-to-percent-calculator.php#answer1
        uint32 reserveRatio =  500000; 
        // involved with the sandswitch
        uint256 gasPrice = 100;  
        // create ERC1363BondingCurveToken and set the bodingCurve
        eRC1363BondingCurveToken = new ERC1363BondingCurveToken();
        require(buyerToken.approve(address(eRC1363BondingCurveToken), initialPoolBalance));
        eRC1363BondingCurveToken.initialize(buyerToken,initialPoolBalance,initialSupply,reserveRatio,gasPrice);
       
        console.log("eRC1363BondingCurveToken current supply ",eRC1363BondingCurveToken.totalSupply());
        console.log("eRC1363BondingCurveToken current poolBalance ",eRC1363BondingCurveToken.poolBalance());
        
    }

    /**
     * @dev test points. when calculate the remote mint token. should based on the current poolBalance+buyerToken
     * 
     */
    // check ERC1363BondingCurveToken totalSupply and buyerAddress's ERC1363BondingCurveToken
    function test_BuyERC1363BondingCurveToken() external {
        console.log("------------Buy eRC1363BondingCurveToken by ERC1363Token--- start -----------------------");
        uint256 BCTTokenOfBuyerBefore = eRC1363BondingCurveToken.balanceOf(buyerAddress);
        console.log("eRC1363BondingCurveToken banlance for buyerAddress ",BCTTokenOfBuyerBefore);
        console.log("ERC1363Token banlance for buyerAddress ",buyerToken.balanceOf(buyerAddress));
        uint256 totalSupplyBefore =  eRC1363BondingCurveToken.totalSupply();
        uint256 initPoolBalance =  eRC1363BondingCurveToken.poolBalance();
        vm.startPrank(buyerAddress);
        uint256 amountSell = 1000; 
        // query the price
        // uint256 receiveAmountToken =  eRC1363BondingCurveToken.calculateCurvedMintReturn(amountSell);
        uint256 receiveAmountToken =  calculatePurchaseReturn(totalSupplyBefore, initPoolBalance+amountSell, 500000,amountSell);
        console.log("------------Buying:convert",amountSell,"ERC1363Token to eRC1363BondingCurveToken",receiveAmountToken);

        require(buyerToken.approve(address(eRC1363BondingCurveToken), amountSell));
        eRC1363BondingCurveToken.mint(amountSell);

        uint256 totalSupplyAfter =  eRC1363BondingCurveToken.totalSupply();
        
        // totalSupply
        assertEq(totalSupplyBefore+receiveAmountToken, totalSupplyAfter);
        // buyerAddress 
        uint256 BCTTokenOfBuyerAfter = eRC1363BondingCurveToken.balanceOf(buyerAddress);
        assertEq(BCTTokenOfBuyerBefore+receiveAmountToken, BCTTokenOfBuyerAfter);

        console.log("eRC1363BondingCurveToken banlance for buyerAddress ",eRC1363BondingCurveToken.balanceOf(buyerAddress));
        console.log("ERC1363Token banlance for buyerAddress ",buyerToken.balanceOf(buyerAddress));
        console.log("eRC1363BondingCurveToken current supply ",eRC1363BondingCurveToken.totalSupply());

        // show eRC1363BondingCurveToken for buyer second
        console.log("buyerAddress balance of eRC1363BondingCurveToken",eRC1363BondingCurveToken.balanceOf(buyerAddress));

        // console.log(eRC1363BondingCurveToken.name(),eRC1363BondingCurveToken.symbol());
        // console.log(eRC1363BondingCurveToken.balanceOf(0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496));

        console.log("buyerAddress balanc of ERC1363Token ",buyerToken.balanceOf(buyerAddress));
        vm.stopPrank();
        console.log("------------Buy eRC1363BondingCurveToken by ERC1363Token--- end -----------------------");
        
    }

    function test_SellERC1363BondingCurveToken() external {

        vm.startPrank(buyerAddress);
        uint256 amountSell = 1000; 
        uint256 totalSupplyBefore =  eRC1363BondingCurveToken.totalSupply();
        uint256 initPoolBalance =  eRC1363BondingCurveToken.poolBalance();
        // uint256 receiveAmountToken =  eRC1363BondingCurveToken.calculateCurvedMintReturn(amountSell);
        uint256 receiveAmountToken =  calculatePurchaseReturn(totalSupplyBefore, initPoolBalance+amountSell, 500000,amountSell);
        
        console.log("------------Buying:convert",amountSell,"ERC1363Token to eRC1363BondingCurveToken",receiveAmountToken);
        
        require(buyerToken.approve(address(eRC1363BondingCurveToken), amountSell));
        eRC1363BondingCurveToken.mint(amountSell);
        uint256 totalSupplyMiddle =  eRC1363BondingCurveToken.totalSupply();
        assertEq(totalSupplyBefore+receiveAmountToken, totalSupplyMiddle);
        console.log("------------Selling:convert",receiveAmountToken,"eRC1363BondingCurveToken to ERC1363Token",amountSell);
        eRC1363BondingCurveToken.burn(receiveAmountToken);
        uint256 totalSupplyEnd =  eRC1363BondingCurveToken.totalSupply();
        assertEq(totalSupplyBefore, totalSupplyEnd);
        vm.stopPrank();
    }

    function test_BuyERC1363BondingCurveTokenIncrease() external {
        uint256 totalSupplyBefore =  eRC1363BondingCurveToken.totalSupply();
        vm.startPrank(buyerAddress);

        uint256 amountSell = 1000;
        require(buyerToken.approve(address(eRC1363BondingCurveToken), amountSell));
        eRC1363BondingCurveToken.mint(amountSell);

        uint256 totalSupplyFirst =  eRC1363BondingCurveToken.totalSupply();
        console.log("------------First Buy:convert",amountSell,"ERC1363Token to eRC1363BondingCurveToken",totalSupplyFirst-totalSupplyBefore);
        require(buyerToken.approve(address(eRC1363BondingCurveToken), amountSell));
        eRC1363BondingCurveToken.mint(amountSell);

        uint256 totalSupplySecond =  eRC1363BondingCurveToken.totalSupply();
        console.log("------------Second Buy:convert",amountSell,"ERC1363Token to eRC1363BondingCurveToken",totalSupplySecond-totalSupplyFirst);
        assertGt(totalSupplyFirst-totalSupplyBefore,totalSupplySecond-totalSupplyFirst);

        vm.stopPrank();
        
    }

     function test_SellERC1363BondingCurveTokenDecrease() external {
        eRC1363BondingCurveToken.transfer(buyerAddress,1000);
        uint256 eRC1363TokenBalanceBefore =  buyerToken.balanceOf(buyerAddress);
        vm.startPrank(buyerAddress);

        uint256 burnAmount = 100;
        
        eRC1363BondingCurveToken.burn(burnAmount);
        uint256 eRC1363TokenBalanceFirst=  buyerToken.balanceOf(buyerAddress);
        console.log("------------First Sell:convert",burnAmount,"eRC1363BondingCurveToken to ERC1363Token",eRC1363TokenBalanceFirst-eRC1363TokenBalanceBefore);

        eRC1363BondingCurveToken.burn(burnAmount);
        uint256 eRC1363TokenBalanceSecond=  buyerToken.balanceOf(buyerAddress);
        console.log("------------Second Sell:convert",burnAmount,"eRC1363BondingCurveToken to ERC1363Token",eRC1363TokenBalanceSecond-eRC1363TokenBalanceFirst);
        assertGt(eRC1363TokenBalanceSecond-eRC1363TokenBalanceBefore,eRC1363TokenBalanceSecond-eRC1363TokenBalanceFirst);

        vm.stopPrank();
        
    }

    function test_RevertWhenBeyondBCTTokenBalance() external {
        eRC1363BondingCurveToken.transfer(buyerAddress,100);
        uint256 burnAmount = 101;
        vm.prank(buyerAddress);
        vm.expectRevert(abi.encodeWithSignature("NoEnoughtBCTToken()"));
        eRC1363BondingCurveToken.burn(burnAmount);
    }


    // function test_increaseCounts() external{
    //     uint256 amountSell = 1000; 
    //     // buyerAddress buy eRC1363BondingCurveToken by 50_0000 ERC1363Token
    //     // query the price
    //     // uint256 receiveAmountToken =  eRC1363BondingCurveToken.calculateCurvedMintReturn(amountSell);
    //     // console.log("convert",amountSell,"ERC1363Token to eRC1363BondingCurveToken",receiveAmountToken);

    //     // amountSell = 2;
    //     // receiveAmountToken =  eRC1363BondingCurveToken.calculateCurvedMintReturn(amountSell);
    //     // console.log("convert",amountSell,"ERC1363Token to eRC1363BondingCurveToken",receiveAmountToken);

       
    //     // buyerAddress buy eRC1363BondingCurveToken by 50_0000 ERC1363Token
    //     // query the price
    //     uint256 receiveAmountToken =  eRC1363BondingCurveToken.calculateCurvedMintReturn(amountSell);
    //     while (amountSell <10_000){
    //         receiveAmountToken =  eRC1363BondingCurveToken.calculateCurvedMintReturn(amountSell);
    //         console.log("convert",amountSell,"ERC1363Token to eRC1363BondingCurveToken",receiveAmountToken);
    //         // if(receiveAmountToken < 100){
    //         //     console.log("convert",amountSell,"ERC1363Token to eRC1363BondingCurveToken",receiveAmountToken);
    //         //     break;
    //         // }
    //          amountSell = amountSell +100;
    //     }    


        
    //     // amountSell = 20_000;
    //     // receiveAmountToken =  eRC1363BondingCurveToken.calculateCurvedMintReturn(amountSell);
    //     // console.log("convert",amountSell,"ERC1363Token to eRC1363BondingCurveToken",receiveAmountToken);


    // }
}
