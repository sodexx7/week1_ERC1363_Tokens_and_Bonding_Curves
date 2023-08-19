# SafeERC20

## Why does the SafeERC20 program exist and when should it be used?

1. Transfer() and TransferFrom() functions in ERC20 only return boolean value, which can't deal with the situation including revert a tx or to check the return value is correct.

2. double-spend an allowance ??? todo clarify

When used?
1. a tx using Transfer() or TransferFrom()  maybe fail or can't sure the return value is the expected boolean value 
2. avoid double-spend an allowance