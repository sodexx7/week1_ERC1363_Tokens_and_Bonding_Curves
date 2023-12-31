// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "forge-std/Test.sol";
import "forge-std/Vm.sol";
import "forge-std/console.sol";
import {ERC1363BondingCurveToken} from "src/ERC1363BondingCurveToken.sol";
import {ERC1363Token} from "./TestERC1363Token.sol";

/**
 * @notice
 * 1. how to express fractions of  tokens?
 * Current implemention supports 18 decimals. Both BCTTokenTest and BCTSwapToken(ERC1363Token) all set 18 decimals.
 * When user input One ERC1363Token or BCTTokenTest, which means 10**18.  Such as 1000.001 which means 1000.001*10**18.
 *
 * 2.How to deal with 3/4 problem?
 * In solidity, this will result zero. but what we actually want is 0.75. The two precison was ignored.
 * My understanding is 3/4 euqal ((3*10**2)/4)/10**2.
 *
 * If the contract decimal is 2. then 0.75 in our code is 0.75*100=75. And 300 as 3, 400 as 4 in code. Then can calculate result by  300/(4/10**2) * 10**2=75.
 * The front-end will transfer the 75 to 0.75.
 *
 * Currently my implemention use BancorFormula,whose calculation is more complex than above. but how to solve the 3/4 problem I think that is the same as my above thought in essence.
 * can reference the funciton power() and purchaseTargetAmount in  BancorFormula.sol
 *
 * 3.The missing between buy and sell by the same amount.
 *  500 ERC1363Token => 414 BCTToken  buy BCTToken by ERC1363Token
 *  414 BCTToken => 499 ERC1363Token  get ERC1363Token by  selling BCTToken
 *
 *
 *  I guess the reason of the missing is the BancorFormula, It's unavoidable that there are some missing.
 *  such as the actual buy pair:500000000000000000000 ERC1363Token =>  1414213562373095048801 BCTToken
 *  1414213562373095048801 BCTToken => 499999999999999999999 ERC1363Token. The missing: 1/10**18.
 *
 */

contract BCTTokenTest is Test, ERC1363BondingCurveToken {
    ERC1363BondingCurveToken BCTToken;

    address private buyerAddress = address(1);

    address private sandswitchAttacker = address(2);

    ERC1363Token private BCTSwapToken;

    function setUp() external {
        // Create the ERC1363 token, which can buy BCTToken. The default supply is 10_000
        BCTSwapToken = new ERC1363Token();

        // transfer 5000(1000*10**18) ERC1363 token to the  buyerAddress for testing
        BCTSwapToken.transfer(buyerAddress, 5000 * 10 ** BCTSwapToken.decimals());

        /**
         * Create BCTToken and init the necessary params.
         *
         * The init params as this:https://www.desmos.com/calculator/3ww16tgsma
         * slope, also as r, equal 0.5
         * The initSupply equal 1000 and the price at 1000 amount euqal 1000, so the init equal (1/2)*1000^2= 500*1000.
         *
         * For the buyer Token, To make the question simple, as the above show. the initBCTSwapTokenAmount*BCTSwapTokenPrice should equal 500*1000.
         * which means the buyer Token's price multiply  amount should equal 500*1000. make the initial amount of  buyer Token equal 500.
         *
         * As all these done, The current bonding curve is f(x)=x, f(x) equal the current price. and the initial value for x euqal 1000.
         * x means the BCTToken supply.
         * f(x) means the corrrospending price, which can convert into the ERC1363Token amount:1/2(1000^2)/1000
         * That can be show in the https://www.desmos.com/calculator/3ww16tgsma.
         *
         *
         * The corrrospending token:
         * BCTToken                 1000
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
         * when set initialSupply = 1000, the collateral value should equal 500*1000.  we set the initial reserveBalance equal 500.
         *
         *
         * Beside initialSupply and initialReserve, set reserveRatio value(500000). this make the bonding curve equal f(x)=x
         *
         * reserveRatio 500000(50%)    <500000/1000000>
         * ppm   reference:https://www.learningaboutelectronics.com/Articles/PPM-to-percent-calculator.php#answer1
         */

        // involved with the sandswitch
        uint256 gasPrice = 100;
        // create BCTToken and set the bodingCurve's init params
        BCTToken = new ERC1363BondingCurveToken();
        uint256 initialReserve = 500 * 10 ** BCTSwapToken.decimals();
        uint256 initialSupply = 1000 * 10 ** BCTToken.decimals();

        require(BCTSwapToken.approve(address(BCTToken), initialReserve));
        BCTToken.initialize(address(BCTSwapToken), initialReserve, initialSupply, gasPrice);
        console.log("BCTToken current supply ", BCTToken.totalSupply() / 10 ** 18);
        console.log("BCTToken current reserveBalance ", BCTToken.reserveBalance() / 10 ** 18);
    }

    // test buy and sell
    function test_BuyAndSellBCTTokenAmount() external {
        // ---------------------------buy--------------------------------------
        BCTSwapToken.transfer(buyerAddress, 3000 * 10 ** BCTSwapToken.decimals());
        uint256 amountSell = 500 * 10 ** BCTSwapToken.decimals();

        uint256 BCTTokenSupplyBefore = BCTToken.totalSupply();
        uint256 BCTTokenReserveBalanceBefore = BCTToken.reserveBalance();
        uint256 BCTTokenBuyerBalanceBefore = BCTToken.balanceOf(buyerAddress);
        uint256 BCTSwapTokenbBuyerAmountBefore = BCTSwapToken.balanceOf(buyerAddress);

        uint256 receiveBCTAmount = test_BuyOneTimebyERC1363(buyerAddress, amountSell);

        uint256 BCTTokenSupplyAfter = BCTToken.totalSupply();
        uint256 BCTTokenReserveBalanceAfter = BCTToken.reserveBalance();
        uint256 BCTTokenBuyerBalanceAfter = BCTToken.balanceOf(buyerAddress);
        uint256 BCTSwapTokenbBuyerAmountAfter = BCTSwapToken.balanceOf(buyerAddress);

        // BCTToken address  should increase amounts of  BCTSwapTokens while buyerAddress decrease the same amount
        assertEq(
            BCTTokenReserveBalanceAfter - BCTTokenReserveBalanceBefore,
            BCTSwapTokenbBuyerAmountBefore - BCTSwapTokenbBuyerAmountAfter
        );

        // buyerAddress should increase some amounts of BCTTokens while BCTToken address should minted the same amount
        assertEq(BCTTokenSupplyAfter - BCTTokenSupplyBefore, BCTTokenBuyerBalanceAfter - BCTTokenBuyerBalanceBefore);

        // ---------------------------sell--------------------------------------
        // cross the cooldown time
        vm.warp(block.timestamp + 1 seconds + 1 days);
        test_SellOneTime(buyerAddress, receiveBCTAmount);

        uint256 BCTTokenSupplyAfter2 = BCTToken.totalSupply();
        uint256 BCTTokenReserveBalanceAfter2 = BCTToken.reserveBalance();
        uint256 BCTTokenBuyerBalanceAfter2 = BCTToken.balanceOf(buyerAddress);
        uint256 BCTSwapTokenbBuyerAmountAfter2 = BCTSwapToken.balanceOf(buyerAddress);

        // BCTToken address  should decrease amounts of  BCTSwapTokens while buyerAddress increase the same amount
        assertEq(
            BCTTokenReserveBalanceAfter - BCTTokenReserveBalanceAfter2,
            BCTSwapTokenbBuyerAmountAfter2 - BCTSwapTokenbBuyerAmountAfter
        );

        // buyerAddress should decrease some amounts of BCTTokens while BCTToken address should burned the same amount
        assertEq(BCTTokenBuyerBalanceAfter - BCTTokenBuyerBalanceAfter2, BCTTokenSupplyAfter - BCTTokenSupplyAfter2);
    }

    // more buy, the price more higher
    function test_BuyBCTTokenIncreaseLess() external {
        BCTSwapToken.transfer(buyerAddress, 3000 * 10 ** BCTSwapToken.decimals());
        uint256 amountSell = 500 * 10 ** BCTSwapToken.decimals();

        uint256 receiveBCTAmount = test_BuyOneTimebyERC1363(buyerAddress, amountSell);
        uint256 receiveBCTAmount2 = test_BuyOneTimebyERC1363(buyerAddress, amountSell);
        assertGt(receiveBCTAmount, receiveBCTAmount2);
    }

    // more seller, the price more cheaper
    function test_SellBCTTokenIncreaseMore() external {
        BCTToken.transfer(buyerAddress, 300 * 10 ** BCTToken.decimals());
        uint256 amountSell = 100 * 10 ** BCTToken.decimals();

        uint256 receiveBCTSwapToken = test_SellOneTime(buyerAddress, amountSell);
        uint256 receiveBCTSwapToken1 = test_SellOneTime(buyerAddress, amountSell);
        assertGt(receiveBCTSwapToken, receiveBCTSwapToken1);
    }

    // mock the sandswitch,when no set the cooldown
    function test_SandSwitchByBuyBCT() internal {
        BCTSwapToken.transfer(buyerAddress, 1000 * 10 ** BCTSwapToken.decimals());
        BCTSwapToken.transfer(sandswitchAttacker, 1000 * 10 ** BCTSwapToken.decimals());

        // Normally based on the current price: The buyerAddress should get 95(95445115010332226913) BCTToken by selling 100 BCTSwapToken
        uint256 amountSell = 100 * 10 ** BCTSwapToken.decimals();
        // uint256 receiveBCTAmount =  test_BuyOneTime(buyerAddress,amountSell);
        // console.log("Expected receiveBCTAmount",receiveBCTAmount);
        uint256 expectedBCTTokens = 95445115010332226913;

        // ----------------------------SandSwitch Attack start-------------------------------------
        //front-running
        BCTSwapToken.transfer(sandswitchAttacker, 1000 * 10 ** BCTSwapToken.decimals());
        uint256 attackReceiveBCT = test_BuyOneTimebyERC1363(sandswitchAttacker, amountSell);

        // buyerAddress sell 100 BCTSwapToken
        uint256 actualBCTTokens = test_BuyOneTimebyERC1363(buyerAddress, amountSell);

        // back-running
        uint256 receiveBCTSwapToken = test_SellOneTime(sandswitchAttacker, attackReceiveBCT);
        // -----------------------------SandSwitch Attack---end-------------------------------------

        console.log("buyerAddress lost:", (expectedBCTTokens - actualBCTTokens) / 10 ** 18);
        console.log("sandswitchAttacker profit:", (receiveBCTSwapToken - amountSell) / 10 ** 18);

        /**
         * Because the missing while calculating.
         * such as  sell ERC1363Token 500000000000000000000     get 414213562373095048801 BCTToken
         *          burn BCTToken     414213562373095048801     get 499999999999999999999 ERC1363Token
         * whose(ERC1363Token) actual value lost 1/10*18. The ultimate result substract 1.
         *
         *
         */

        assertEq((expectedBCTTokens - actualBCTTokens) / 10 ** 18, ((receiveBCTSwapToken - amountSell) / 10 ** 18) - 1);
    }

    /**
     * When an attacker want do sandswith to the buyeraddress while finding  a buyer's tx is pending. The attacker's tx must be included the block by the miner before the buyer's tx.
     * Firstly, the attacker can set a higher gas to make its tx be executed before the buyer's tx.
     * So one solution is the bondingCurve can set the max gas price to prevent the attacker's tx execute before the buyer's tx. But this solution rely on the gas price, which is fluctuating。
     * Can't sure that will lead some other problems?
     *
     * Alternative soluiton is set the price slippage. The same as uniswap. calculating the expected receivedAmount, based on the slippage,make sure get the least receivedAmount.
     * But when the buyer calculate the expected return Amount. it's just basd on the current point in the boding curve, which means if the font run executes, the current price have changed.
     * So can't avoid the sandswitch. Just decrease the profit of the attacker's tx
     *
     * It seems no ways to mock the pending tx?
     *
     * directly send the tx to one miner by some service.(flashfloat server??)
     *
     *
     * One useful solution to prevent the sandswitch is using the cooldown(my current solution) or
     * before a user can profit by selling the product token, a number high enough of buy orders are needed.
     * https://solodit.xyz/issues/producttokenhighbase-contract-is-vulnerable-to-sandwich-attacks-halborn-highstreetmarket-producttoken-pdf
     *
     * This test works only used when apply timecool down, the details can see the tag:v1.1.0
     */

    //
    function test_RevertWhenSandSwitchByBuyBCT() internal {
        BCTSwapToken.transfer(buyerAddress, 1000 * 10 ** BCTSwapToken.decimals());
        BCTSwapToken.transfer(sandswitchAttacker, 1000 * 10 ** BCTSwapToken.decimals());

        // Normally based on the current price: The buyerAddress should get 95(95445115010332226913) BCTToken by selling 100 BCTSwapToken
        uint256 amountSell = 100 * 10 ** BCTSwapToken.decimals();

        // ----------------------------SandSwitch Attack start-------------------------------------
        //front-running
        BCTSwapToken.transfer(sandswitchAttacker, 1000 * 10 ** BCTSwapToken.decimals());
        uint256 attackReceiveBCT = test_BuyOneTimebyERC1363(sandswitchAttacker, amountSell);

        // buyerAddress sell 100 BCTSwapToken
        test_BuyOneTimebyERC1363(buyerAddress, amountSell);

        // back-running
        vm.prank(sandswitchAttacker);
        vm.expectRevert();
        BCTToken.burn(attackReceiveBCT);
    }

    // buy BCTToken by ERC1363Token, which will trigger the receive funciton in the ERC1363BondingCurveToken.sol
    function test_BuyOneTimebyERC1363(address buyer, uint256 amountSell) internal returns (uint256 receiveAmount) {
        vm.startPrank(buyer);
        uint256 totalSupplyBefore = BCTToken.totalSupply();

        console.log("balance-start", BCTSwapToken.balanceOf(address(BCTToken)));
        BCTSwapToken.transferAndCall(address(BCTToken), amountSell);

        console.log("buyer ", buyer);
        console.log(
            "receive ", (BCTToken.totalSupply() - totalSupplyBefore), "BCTToken and sell ERC1363Token", amountSell
        );
        // console.log(
        //     "receive ",
        //     (BCTToken.totalSupply() - totalSupplyBefore) / 10 ** 18,
        //     "BCTToken and sell ERC1363Token",
        //     amountSell / 10 ** 18
        // );
        vm.stopPrank();
        return BCTToken.totalSupply() - totalSupplyBefore;
    }

    // Sell BCTToken by burning BCTToken
    function test_SellOneTime(address seller, uint256 burnAmount) internal returns (uint256 receiveAmount) {
        vm.startPrank(seller);
        uint256 BCTTokennBefore = BCTToken.reserveBalance();
        BCTToken.burn(burnAmount);
        console.log("seller ", seller);
        uint256 receiveBCTSwapToken = BCTTokennBefore - BCTToken.reserveBalance();
        console.log(
            "test_SellOneTime BCTTokennBefore - BCTToken.reserveBalance()", BCTTokennBefore, BCTToken.reserveBalance()
        );
        console.log("receive ", receiveBCTSwapToken, " ERC1363Token and burn BCTToken", burnAmount);
        // console.log("receive ",receiveBCTSwapToken/10**18," ERC1363Token and burn BCTToken", burnAmount/10**18) ;
        vm.stopPrank();
        return receiveBCTSwapToken;
    }

    // check the seller whether or not have enough BCTToken
    function test_RevertWhenBeyondBCTTokenBalance() external {
        uint256 burnAmount = BCTToken.balanceOf(buyerAddress) + 1;
        vm.prank(buyerAddress);
        vm.expectRevert();
        BCTToken.burn(burnAmount);
    }

    // only the s_reserveToken address can call the receive funciton
    function test_RevertWhenIllegalAccess() external {
        // vm.expectRevert(abi.encodeWithSignature("illeage call"));
        vm.expectRevert();
        BCTToken.onTransferReceived(buyerAddress, buyerAddress, 100, "0x");
    }

    // only the s_reserveToken address can call the receive funciton
    function test_RevertWhenlegalAccess() external {
        vm.prank(address(BCTSwapToken));
        BCTToken.onTransferReceived(address(BCTSwapToken), address(BCTSwapToken), 100, "0x");
    }
}
