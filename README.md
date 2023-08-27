
## Week 1: ERC1363 Tokens and Bonding Curves


### Files Info
1. ERC777_ERC1363.md
2. SafeERC20.md
3. src/TonyToken.sol (Token with sanctions)     
4. src/TokenGodMod.sol (Token with god mode)
5. src/ERC1363BondingCurveToken.sol  (Token sale and buyback with bonding curve)   
6. src/UntrustedEscrow.sol  (Untrusted escrow)

```
src
├─ ERC1363BondingCurveToken.sol
├── └─BancorFormula.sol
├─ TokenGodMod.sol
├─ TonyToken.sol
├─ UntrustedEscrow.sol
test
├─ERC1363BondingCurveToken.sol
├─TokenGodMod.t.sol
├─TonyToken.t.sol
└─UntrustedEscrow.t.sol

md files
└─ERC777_ERC1363.md
└─SafeERC20.md
```


#### todo
1. vm.expectRevert  shows the specific reason
2. event test 
3. use more test features of foundry: Fuzz Testing, Invariant Testing
4. how to test some security issues
5. ERC1363BondingCurveToken | 27.795    | -3.219  beyond contract limit
