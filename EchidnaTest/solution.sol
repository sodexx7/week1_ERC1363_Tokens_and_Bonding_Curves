// SPDX-License-Identifier: AGPL-3.0
pragma solidity 0.8.20;

import "../src/ERC1363BondingCurveToken.sol";
import {ERC1363BondingCurveToken} from "src/ERC1363BondingCurveToken.sol";
import {ERC1363TokenForEchidna} from "./ERC1363TokenForEchidna.sol";

import {IERC1363Receiver} from "../src/erc1363-payable-token/IERC1363Receiver.sol";


/**
    echidna EchidnaTest/solution.sol --contract TestERC1363BondingCurveToken  --config echidna.yaml

    1. This contract itself is the buyer address, also as the owner of the bctSwapToken. That means can mint any bctSwapToken to test.

    2. the invariants. 
    1) the amount of mint token should euqal afterbctTokenBalnce - beforebctTokenBalnce  while minting
    2) the amount of burn token shuuld euqal the corresponding minted token
 */
contract TestERC1363BondingCurveToken is IERC1363Receiver  {

    // for receive bctToken
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
        
        return IERC1363Receiver.onTransferReceived.selector;
    }


    ERC1363BondingCurveToken bctToken;
    ERC1363TokenForEchidna bctSwapToken; // owner is the echidna_player has 10_000* 10 **18 token

    constructor() {

        bctToken = new ERC1363BondingCurveToken();  // bct token
        bctSwapToken = new ERC1363TokenForEchidna(); // buyer tokens
        
        uint256 initialReserve = 500 * 10 ** bctSwapToken.decimals();
        uint256 initialSupply = 1000 * 10 ** bctToken.decimals();

        // the default owner of  bctSwapToken is address(this),  owner 
        bctSwapToken.mint(address(this),initialReserve);


        // involved with the sandswitch
        uint256 gasPrice = 100;
        require(bctSwapToken.approve(address(bctToken), initialReserve));
        bctToken.initialize(address(bctSwapToken), initialReserve, initialSupply, gasPrice);
        bctToken.transferOwnership(address(0x40000));


    }

    event CheckBeforebctTokenBalnce(uint);
    event CheckbAfterbctTokenBalnce(uint);
    event CheckExpectedReceivedBCTToken(uint);
    function test_mint(uint amountOfbctSwapToken) public {
        require(amountOfbctSwapToken > 10**18); // for precision problem , should have the least amount todo? the the least amount

        uint beforebctTokenBalnce = bctToken.balanceOf(address(this));
        
        uint256 expectedReceivedBCTToken =  bctToken.calculateCurvedMintReturn(amountOfbctSwapToken);

        bctSwapToken.mint(address(this),amountOfbctSwapToken);
        bctSwapToken.transferAndCall(address(bctToken), amountOfbctSwapToken);
        

        uint afterbctTokenBalnce = bctToken.balanceOf(address(this));

        if(afterbctTokenBalnce - beforebctTokenBalnce != expectedReceivedBCTToken){
            emit CheckBeforebctTokenBalnce(beforebctTokenBalnce);
            emit CheckbAfterbctTokenBalnce(afterbctTokenBalnce);
            emit CheckExpectedReceivedBCTToken(expectedReceivedBCTToken);
        }
        assert(afterbctTokenBalnce - beforebctTokenBalnce == expectedReceivedBCTToken);
    }


    function test_burn(uint amountOfbctSwapToken) public {

        require(amountOfbctSwapToken > 10**18); // for precision problem , should have the least amount todo? the the least amount

        uint256 expectedReceivedBCTToken =  bctToken.calculateCurvedMintReturn(amountOfbctSwapToken);

        uint beforebctTokenBalnce = bctToken.balanceOf(address(this));

        // mint
        bctSwapToken.mint(address(this),amountOfbctSwapToken);
        bctSwapToken.transferAndCall(address(bctToken), amountOfbctSwapToken);


        // burn
        bctToken.burn(expectedReceivedBCTToken);

        uint afterbctTokenBalnce = bctToken.balanceOf(address(this));


        if(beforebctTokenBalnce != afterbctTokenBalnce){
            emit CheckBeforebctTokenBalnce(beforebctTokenBalnce);
            emit CheckbAfterbctTokenBalnce(afterbctTokenBalnce);
            
        }
        assert(beforebctTokenBalnce == afterbctTokenBalnce);

    }

// event CheckBalance(uint);
//     function test_balance() public {

//     emit CheckBalance(bctToken.balanceOf(address(this)));
//     emit CheckBalance(bctToken.reserveBalance()); // bctSwapToken
//     assert(false);
// }



}