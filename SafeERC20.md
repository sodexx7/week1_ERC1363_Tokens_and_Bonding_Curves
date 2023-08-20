# SafeERC20

## Why does the SafeERC20 program exist and when should it be used?

1. Transfer() and TransferFrom() functions in ERC20 only return a boolean value, which can't deal with situations including revert a tx or to check the return value is correct.

2. double-spend an allowance. 
    If someone sets the allowance mistakenly and resets the allowance, the malicious guy can get all allowance while monitoring the mempool.
 

When used?
1. a tx using Transfer() or TransferFrom()  maybe fail or can't be sure the return value is the expected boolean value 
2. avoid double-spend an allowance


### Reference
1. [ERC20 security issues](https://medium.com/@deliriusz/ten-issues-with-erc20s-that-can-ruin-you-smart-contract-6c06c44948e0)
2. [SafeERC20 from openzeppelin code](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/utils/SafeERC20.sol)