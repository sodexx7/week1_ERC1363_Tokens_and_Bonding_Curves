// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;


import "forge-std/Test.sol";
import "forge-std/Vm.sol";
import "forge-std/console.sol";
import {ERC1363BondingCurveToken} from "src/ERC1363BondingCurveToken.sol";
import {ERC1363Token} from "src/ERC1363Token.sol";

/**
 * @notice
 * 1. how to express fractions of  tokens?
 * Current implemention supports 18 decimals. Both ERC1363BondingCurveTokenTest and buyerToken(ERC1363Token) all set 18 decimals.
 * When user input One ERC1363Token or ERC1363BondingCurveTokenTest, which means 10**18.  Such as 1000.001 which means 1000.001*10**18.
 * 
 * 2.How to deal with 3/4 problem?
 * In solidity, this will result zero. but what we actually want is 0.75. The two precison was ignored. 
 * My understanding is 3/4 euqal ((3*10**2)/4)/10**2. 
 * 
 * If the contract decimal is 2. then 0.75 in our code is 0.75*100=75. And 300 as 3, 400 as 4 in code. Then can calculate result by  300/(4/10**2) * 10**2=75.
 * The front-end will transfer the 75 to 0.75.
 *  
 * Currently my implemention use BancorFormula,which calculation is more complex than above. but how to solve the 3/4 problem I think that is the same as my above thought in essence.
 * can reference the funciton power() and purchaseTargetAmount in  BancorFormula.sol 
 * 
 * 
 */
contract ERC1363BondingCurveTokenTest is Test,ERC1363BondingCurveToken {
    ERC1363BondingCurveToken eRC1363BondingCurveToken;

    address private buyerAddress = address(123123123123123);

    ERC1363Token buyerToken;

    function setUp() external {
        // Create the ERC1363 token, which can buy eRC1363BondingCurveToken. The default supply is 10_000
        buyerToken = new ERC1363Token();
        
        
        // transfer 5000(1000*10**18) ERC1363 token to the  buyerAddress for testing
        buyerToken.transfer(buyerAddress, 5000*10**buyerToken.decimals());     

         /**
         * Create ERC1363BondingCurveToken and init the necessary params.
         * 
         * The init params as this:https://www.desmos.com/calculator/3ww16tgsma
         * slope, also as r, equal 0.5 
         * The initSupply equal 1000 and the price at 1000 amount euqal 1000, so the initPoolBalace equal (1/2)*1000^2= 500*1000.
         * 
         * For the buyer Token, To make the question simple, as the above show. the init buyerTokenAmount*buyerTokenPrice should equal 500*1000.
         * which means the buyer Token's price multiply  amount should equal 500*1000. make the initial amount of  buyer Token equal 500.
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
         * For the Math formula
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
         * reserveRatio 500000(50%)    <500000/1000000>
         * ppm   reference:https://www.learningaboutelectronics.com/Articles/PPM-to-percent-calculator.php#answer1
         */


        uint32 reserveRatio =  500000; 
        // involved with the sandswitch
        uint256 gasPrice = 100;  
        // create ERC1363BondingCurveToken and set the bodingCurve's init params
        eRC1363BondingCurveToken = new ERC1363BondingCurveToken();
        uint256 initialPoolBalance = 500*10**buyerToken.decimals();
        uint256 initialSupply = 1000*10**eRC1363BondingCurveToken.decimals();


        require(buyerToken.approve(address(eRC1363BondingCurveToken), initialPoolBalance));
        eRC1363BondingCurveToken.initialize(buyerToken,initialPoolBalance,initialSupply,reserveRatio,gasPrice);
       
        console.log("eRC1363BondingCurveToken current supply ",eRC1363BondingCurveToken.totalSupply()/10**18);
        console.log("eRC1363BondingCurveToken current poolBalance ",eRC1363BondingCurveToken.poolBalance()/10**18);
        
    }

    /**
     * @dev test points. when calculate the remote mint token. should based on the current poolBalance+buyerToken
     * 
     */
    // check ERC1363BondingCurveToken totalSupply and buyerAddress's ERC1363BondingCurveToken
    function test_BuyERC1363BondingCurveToken() external {
        console.log("------------Buy eRC1363BondingCurveToken by ERC1363Token--- start -----------------------");
        uint256 BCTTokenOfBuyerBefore = eRC1363BondingCurveToken.balanceOf(buyerAddress);
        console.log("eRC1363BondingCurveToken banlance for buyerAddress ",BCTTokenOfBuyerBefore/10**18);
        console.log("ERC1363Token banlance for buyerAddress ",buyerToken.balanceOf(buyerAddress)/10**18);
        uint256 totalSupplyBefore =  eRC1363BondingCurveToken.totalSupply();
        uint256 initPoolBalance =  eRC1363BondingCurveToken.poolBalance();
        vm.startPrank(buyerAddress);
        uint256 amountSell = 1000*10**buyerToken.decimals(); 
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

        console.log("eRC1363BondingCurveToken banlance for buyerAddress ",eRC1363BondingCurveToken.balanceOf(buyerAddress)/10**18);
        console.log("ERC1363Token banlance for buyerAddress ",buyerToken.balanceOf(buyerAddress)/10**18);
        console.log("eRC1363BondingCurveToken current supply ",eRC1363BondingCurveToken.totalSupply()/10**18);

        // show eRC1363BondingCurveToken for buyer second
        console.log("buyerAddress balance of eRC1363BondingCurveToken",eRC1363BondingCurveToken.balanceOf(buyerAddress)/10**18);

        // console.log(eRC1363BondingCurveToken.name(),eRC1363BondingCurveToken.symbol());
        // console.log(eRC1363BondingCurveToken.balanceOf(0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496));

        console.log("buyerAddress balanc of ERC1363Token ",buyerToken.balanceOf(buyerAddress));
        vm.stopPrank();
        console.log("------------Buy eRC1363BondingCurveToken by ERC1363Token--- end -----------------------");
        
    }

    function test_SellERC1363BondingCurveToken() external {

        vm.startPrank(buyerAddress);
        uint256 amountSell = 1000*10**eRC1363BondingCurveToken.decimals(); 
        uint256 totalSupplyBefore =  eRC1363BondingCurveToken.totalSupply();
        uint256 initPoolBalance =  eRC1363BondingCurveToken.poolBalance();
        // uint256 receiveAmountToken =  eRC1363BondingCurveToken.calculateCurvedMintReturn(amountSell);
        uint256 receiveAmountToken =  calculatePurchaseReturn(totalSupplyBefore, initPoolBalance+amountSell, 500000,amountSell);
        
        console.log("------------Buying:convert",amountSell/10**18,"ERC1363Token to eRC1363BondingCurveToken",receiveAmountToken/10**18);
        
        require(buyerToken.approve(address(eRC1363BondingCurveToken), amountSell));
        eRC1363BondingCurveToken.mint(amountSell);
        uint256 totalSupplyMiddle =  eRC1363BondingCurveToken.totalSupply();
        assertEq(totalSupplyBefore+receiveAmountToken, totalSupplyMiddle);
        console.log("------------Selling:convert",receiveAmountToken,"eRC1363BondingCurveToken to ERC1363Token",amountSell/10**18);
        eRC1363BondingCurveToken.burn(receiveAmountToken);
        uint256 totalSupplyEnd =  eRC1363BondingCurveToken.totalSupply();
        assertEq(totalSupplyBefore, totalSupplyEnd);
        vm.stopPrank();
    }

    function test_BuyERC1363BondingCurveTokenIncrease() external {
        uint256 totalSupplyBefore =  eRC1363BondingCurveToken.totalSupply();
        vm.startPrank(buyerAddress);
        
        uint256 amountSell = (1000+100 / 10 ** 2)*10**buyerToken.decimals();
        require(buyerToken.approve(address(eRC1363BondingCurveToken), amountSell));
        eRC1363BondingCurveToken.mint(amountSell);

        uint256 totalSupplyFirst =  eRC1363BondingCurveToken.totalSupply();
        console.log("------------First Buy:convert 1000.01","ERC1363Token to eRC1363BondingCurveToken",(totalSupplyFirst-totalSupplyBefore)/10**18);
        require(buyerToken.approve(address(eRC1363BondingCurveToken), amountSell));
        eRC1363BondingCurveToken.mint(amountSell);

        uint256 totalSupplySecond =  eRC1363BondingCurveToken.totalSupply();
        console.log("------------Second Buy:convert 1000.01","ERC1363Token to eRC1363BondingCurveToken",(totalSupplySecond-totalSupplyFirst)/10**18);
        assertGt(totalSupplyFirst-totalSupplyBefore,totalSupplySecond-totalSupplyFirst);

        vm.stopPrank();
        
    }

     function test_SellERC1363BondingCurveTokenDecrease() external {
        
        uint256 testAmount = 300*10**eRC1363BondingCurveToken.decimals();
        eRC1363BondingCurveToken.transfer(buyerAddress,testAmount);

        uint256 eRC1363TokenBalanceBefore =  eRC1363BondingCurveToken.balanceOf(buyerAddress);
        vm.startPrank(buyerAddress);

        uint256 burnAmount = 100*10**eRC1363BondingCurveToken.decimals();
        
        eRC1363BondingCurveToken.burn(burnAmount);
        uint256 eRC1363TokenBalanceFirst=  buyerToken.balanceOf(buyerAddress);
        console.log("------------First Sell:convert",burnAmount/10**18,"eRC1363BondingCurveToken to ERC1363Token",(eRC1363TokenBalanceFirst-eRC1363TokenBalanceBefore)/10**18);

        eRC1363BondingCurveToken.burn(burnAmount);
        uint256 eRC1363TokenBalanceSecond=  buyerToken.balanceOf(buyerAddress);
        console.log("------------Second Sell:convert",burnAmount/10**18,"eRC1363BondingCurveToken to ERC1363Token",(eRC1363TokenBalanceSecond-eRC1363TokenBalanceFirst)/10**18);
        assertGt(eRC1363TokenBalanceSecond-eRC1363TokenBalanceBefore,eRC1363TokenBalanceSecond-eRC1363TokenBalanceFirst);

        vm.stopPrank();
        
    }

    function test_RevertWhenBeyondBCTTokenBalance() external {
        uint256 burnAmount = eRC1363BondingCurveToken.balanceOf(buyerAddress) +1;
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
