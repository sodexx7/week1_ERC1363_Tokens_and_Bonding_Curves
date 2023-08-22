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
         * referene: https://billyrennekamp.medium.com/converting-between-bancor-and-bonding-curve-price-formulas-9c11309062f5
         * 
         * CW = 1 / (n + 1) where n is the exponent
         * m = collateral / (CW * tokenSupply ^ (1 / CW))
         * 
         * CW = 1/2, n = 1 ----> f(x) = mx
         * The bondingCurve there use is f(x) = x.
         *  n=1, so CW=1/2
         *  make m=1, and because initialSupply = 10*10**18, by the m = collateral / (CW * tokenSupply ^ (1 / CW)), can get collateral, 
         *  which means initialPoolBalance, can get value: initialPoolBalance = 1/2* (10**3)^2 = 500*10**3
         *  
         * )
         */

        // Create ERC1363BondingCurveToken, the below init params decide when someone want to buy eRC1363BondingCurveToken, 
        // must at least 1000 ERC1363Token at increase by 1000. 

        uint256 initialPoolBalance = 500*10**3;
        uint256 initialSupply = 1*10**3;

        // uint256 initialPoolBalance = 4;
        // uint256 initialSupply = 2;
        // equal 50%   reference:https://www.learningaboutelectronics.com/Articles/PPM-to-percent-calculator.php#answer1
        uint32 reserveRatio =  500000; 
        // involved with the sandswitch
        uint256 gasPrice = 100;  

        eRC1363BondingCurveToken = new ERC1363BondingCurveToken();
        require(buyerToken.approve(address(eRC1363BondingCurveToken), initialPoolBalance));
        eRC1363BondingCurveToken.initialize(buyerToken,initialPoolBalance,initialSupply,reserveRatio,gasPrice);
       
        console.log("eRC1363BondingCurveToken current supply ",eRC1363BondingCurveToken.totalSupply());
        console.log("eRC1363BondingCurveToken current poolBalance ",eRC1363BondingCurveToken.poolBalance());
        
        
    }


    // check ERC1363BondingCurveToken totalSupply and buyerAddress's ERC1363BondingCurveToken
    function test_BuyERC1363BondingCurveToken() external {
        console.log("------------Buy eRC1363BondingCurveToken by ERC1363Token--- start -----------------------");
        uint256 BCTTokenOfBuyerBefore = eRC1363BondingCurveToken.balanceOf(buyerAddress);
        console.log("eRC1363BondingCurveToken banlance for buyerAddress ",BCTTokenOfBuyerBefore);
        console.log("ERC1363Token banlance for buyerAddress ",buyerToken.balanceOf(buyerAddress));
        uint256 totalSupplyBefore =  eRC1363BondingCurveToken.totalSupply();
        vm.startPrank(buyerAddress);
        uint256 amountSell = 11_000; 
        // query the price
        uint256 receiveAmountToken =  eRC1363BondingCurveToken.calculateCurvedMintReturn(amountSell);
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
        uint256 amountSell = 11_000; 
        // buyerAddress buy eRC1363BondingCurveToken by 50_0000 ERC1363Token
        // query the price
        uint256 receiveAmountToken =  eRC1363BondingCurveToken.calculateCurvedMintReturn(amountSell);
        console.log("------------Buying:convert",amountSell,"ERC1363Token to eRC1363BondingCurveToken",receiveAmountToken);
        uint256 totalSupplyBefore =  eRC1363BondingCurveToken.totalSupply();
        
        require(buyerToken.approve(address(eRC1363BondingCurveToken), amountSell));
        eRC1363BondingCurveToken.mint(amountSell);
        uint256 totalSupplyMiddle =  eRC1363BondingCurveToken.totalSupply();
        assertEq(totalSupplyBefore+receiveAmountToken, totalSupplyMiddle);
        console.log("------------Selling:convert",receiveAmountToken,"eRC1363BondingCurveToken to ERC1363Token",amountSell);
        eRC1363BondingCurveToken.burn(10);
        uint256 totalSupplyEnd =  eRC1363BondingCurveToken.totalSupply();
        assertEq(totalSupplyBefore, totalSupplyEnd);
        vm.stopPrank();

    }


    // function test_increaseCounts() external{
    //     uint256 amountSell = 1_000; 
    //     // buyerAddress buy eRC1363BondingCurveToken by 50_0000 ERC1363Token
    //     // query the price
    //     uint256 receiveAmountToken =  eRC1363BondingCurveToken.calculateCurvedMintReturn(amountSell);
    //     console.log("convert",amountSell,"ERC1363Token to eRC1363BondingCurveToken",receiveAmountToken);

    //     amountSell = 1_001;
    //     receiveAmountToken =  eRC1363BondingCurveToken.calculateCurvedMintReturn(amountSell);
    //     console.log("convert",amountSell,"ERC1363Token to eRC1363BondingCurveToken",receiveAmountToken);


    //     // amountSell = 1099; 
    //     // // buyerAddress buy eRC1363BondingCurveToken by 50_0000 ERC1363Token
    //     // // query the price
    //     // receiveAmountToken =  eRC1363BondingCurveToken.calculateCurvedMintReturn(amountSell);
    //     // while (amountSell >1){
    //     //     receiveAmountToken =  eRC1363BondingCurveToken.calculateCurvedMintReturn(amountSell);
    //     //     console.log("convert",amountSell,"ERC1363Token to eRC1363BondingCurveToken",receiveAmountToken);
    //     //     if(receiveAmountToken < 1){
    //     //         console.log("convert",amountSell,"ERC1363Token to eRC1363BondingCurveToken",receiveAmountToken);
    //     //         break;
    //     //     }
    //     //     amountSell = amountSell -1;
    //     // }    


        
    //     // amountSell = 20_000;
    //     // receiveAmountToken =  eRC1363BondingCurveToken.calculateCurvedMintReturn(amountSell);
    //     // console.log("convert",amountSell,"ERC1363Token to eRC1363BondingCurveToken",receiveAmountToken);

    //     // amountSell = 30_000;
    //     // receiveAmountToken =  eRC1363BondingCurveToken.calculateCurvedMintReturn(amountSell);
    //     // console.log("convert",amountSell,"ERC1363Token to eRC1363BondingCurveToken",receiveAmountToken);

    //     // amountSell = 40_000;
    //     // receiveAmountToken =  eRC1363BondingCurveToken.calculateCurvedMintReturn(amountSell);
    //     // console.log("convert",amountSell,"ERC1363Token to eRC1363BondingCurveToken",receiveAmountToken);

    //     // amountSell = 1100;
    //     // receiveAmountToken =  eRC1363BondingCurveToken.calculateCurvedMintReturn(amountSell);
    //     // console.log("convert",amountSell,"ERC1363Token to eRC1363BondingCurveToken",receiveAmountToken);

    //     //  amountSell = 2200;
    //     // receiveAmountToken =  eRC1363BondingCurveToken.calculateCurvedMintReturn(amountSell);
    //     // console.log("convert",amountSell,"ERC1363Token to eRC1363BondingCurveToken",receiveAmountToken);


    //     // amountSell = 8800;
    //     // receiveAmountToken =  eRC1363BondingCurveToken.calculateCurvedMintReturn(amountSell);
    //     // console.log("convert",amountSell,"ERC1363Token to eRC1363BondingCurveToken",receiveAmountToken);


    //     // amountSell = 1101;
    //     // receiveAmountToken =  eRC1363BondingCurveToken.calculateCurvedMintReturn(amountSell);
    //     // console.log("convert",amountSell,"ERC1363Token to eRC1363BondingCurveToken",receiveAmountToken);

    //     // amountSell = 2000;
    //     // receiveAmountToken =  eRC1363BondingCurveToken.calculateCurvedMintReturn(amountSell);
    //     // console.log("convert",amountSell,"ERC1363Token to eRC1363BondingCurveToken",receiveAmountToken);

    // }
}
