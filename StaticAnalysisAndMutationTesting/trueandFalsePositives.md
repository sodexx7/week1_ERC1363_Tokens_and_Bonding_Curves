
# Check range, tool:slither
    /src/ERC1363BondingCurveToken.sol 
    /src/SanctionToken.sol 
    /src/TokenGodMod.sol 
    /src/UntrustedEscrow.sol

# Check results summary
* The analyzed file includes two types, one is the import lib, such as ERC1363BondingCurveToken apply BancorFormula, another is the contract itself.

* The below common detectors, which I think is false positive. Some can't be avoided such as using the different versions, the others should be carefull while using, such as low-level-calls,assembly-usage.

* true positives, which I think should correct them according to the suggestions.

* other detectors, which I think should depond on the situations.



## 1. common detectors

    1. Different versions of Solidity are used:
    ```
    Different versions of Solidity are used:
	- Version used: ['0.8.9', '^0.8.0', '^0.8.1', '^0.8.2']
	- 0.8.9 (src/ERC1363BondingCurveToken.sol#2)
	- 0.8.9 (src/bancorprotocol/BancorFormula.sol#2)
	- 0.8.9 (src/bancorprotocol/interfaces/IBancorFormula.sol#2)
	- ^0.8.0 (lib/openzeppelin-contracts/contracts/access/Ownable.sol#4)
	- ^0.8.0 (lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol#4)
	- ^0.8.0 (lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol#4)
	- ^0.8.0 (lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol#4)
	- ^0.8.0 (lib/openzeppelin-contracts/contracts/utils/Context.sol#4)
	- ^0.8.0 (lib/openzeppelin-contracts/contracts/utils/introspection/ERC165.sol#4)
	- ^0.8.0 (lib/openzeppelin-contracts/contracts/utils/introspection/IERC165.sol#4)
	- ^0.8.0 (src/erc1363-payable-token/ERC1363.sol#3)
	- ^0.8.0 (src/erc1363-payable-token/IERC1363.sol#3)
	- ^0.8.0 (src/erc1363-payable-token/IERC1363Receiver.sol#3)
	- ^0.8.0 (src/erc1363-payable-token/IERC1363Spender.sol#3)
	- ^0.8.1 (lib/openzeppelin-contracts/contracts/utils/Address.sol#4)
	- ^0.8.2 (lib/openzeppelin-contracts/contracts/proxy/utils/Initializable.sol#4)
    ```
    Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#different-pragma-directives-are-used


    2.dead-code
    ```
    Address._revert(bytes,string) (lib/openzeppelin-contracts/contracts/utils/Address.sol#231-243) is never used and should be removed
    Address.functionCall(address,bytes) (lib/openzeppelin-contracts/contracts/utils/Address.sol#89-91) is never used and should be removed
    Address.functionCall(address,bytes,string) (lib/openzeppelin-contracts/contracts/utils/Address.sol#99-105) is never used and should be removed
    Address.functionCallWithValue(address,bytes,uint256) (lib/openzeppelin-contracts/contracts/utils/Address.sol#118-120) is never used and should be removed
    Address.functionCallWithValue(address,bytes,uint256,string) (lib/openzeppelin-contracts/contracts/utils/Address.sol#128-137) is never used and should be removed
    Address.functionDelegateCall(address,bytes) (lib/openzeppelin-contracts/contracts/utils/Address.sol#170-172) is never used and should be removed
    Address.functionDelegateCall(address,bytes,string) (lib/openzeppelin-contracts/contracts/utils/Address.sol#180-187) is never used and should be removed
    Address.functionStaticCall(address,bytes) (lib/openzeppelin-contracts/contracts/utils/Address.sol#145-147) is never used and should be removed
    Address.functionStaticCall(address,bytes,string) (lib/openzeppelin-contracts/contracts/utils/Address.sol#155-162) is never used and should be removed
    Address.sendValue(address,uint256) (lib/openzeppelin-contracts/contracts/utils/Address.sol#64-69) is never used and should be removed
    Address.verifyCallResult(bool,bytes,string) (lib/openzeppelin-contracts/contracts/utils/Address.sol#219-229) is never used and should be removed
    Address.verifyCallResultFromTarget(address,bool,bytes,string) (lib/openzeppelin-contracts/contracts/utils/Address.sol#195-211) is never used and should be removed
    Context._msgData() (lib/openzeppelin-contracts/contracts/utils/Context.sol#21-23) is never used and should be removed
    Initializable._disableInitializers() (lib/openzeppelin-contracts/contracts/proxy/utils/Initializable.sol#145-151) is never used and should be removed
    Initializable._getInitializedVersion() (lib/openzeppelin-contracts/contracts/proxy/utils/Initializable.sol#156-158) is never used and should be removed
    Initializable._isInitializing() (lib/openzeppelin-contracts/contracts/proxy/utils/Initializable.sol#163-165) is never used and should be removed
    Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#dead-code
    ```

    3. assembly-usage
    ```
    Address._revert(bytes,string) (lib/openzeppelin-contracts/contracts/utils/Address.sol#231-243) uses assembly
        - INLINE ASM (lib/openzeppelin-contracts/contracts/utils/Address.sol#236-239)
    ERC1363._checkOnTransferReceived(address,address,uint256,bytes) (src/erc1363-payable-token/ERC1363.sol#119-140) uses assembly
        - INLINE ASM (src/erc1363-payable-token/ERC1363.sol#135-137)
    ERC1363._checkOnApprovalReceived(address,uint256,bytes) (src/erc1363-payable-token/ERC1363.sol#150-171) uses assembly
        - INLINE ASM (src/erc1363-payable-token/ERC1363.sol#166-168)
    Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#assembly-usage
    ```

    4.low-level-calls
    ```
    Low level call in Address.sendValue(address,uint256) (lib/openzeppelin-contracts/contracts/utils/Address.sol#64-69):
	- (success) = recipient.call{value: amount}() (lib/openzeppelin-contracts/contracts/utils/Address.sol#67)
    Low level call in Address.functionCallWithValue(address,bytes,uint256,string) (lib/openzeppelin-contracts/contracts/utils/Address.sol#128-137):
        - (success,returndata) = target.call{value: value}(data) (lib/openzeppelin-contracts/contracts/utils/Address.sol#135)
    Low level call in Address.functionStaticCall(address,bytes,string) (lib/openzeppelin-contracts/contracts/utils/Address.sol#155-162):
        - (success,returndata) = target.staticcall(data) (lib/openzeppelin-contracts/contracts/utils/Address.sol#160)
    Low level call in Address.functionDelegateCall(address,bytes,string) (lib/openzeppelin-contracts/contracts/utils/Address.sol#180-187):
        - (success,returndata) = target.delegatecall(data) (lib/openzeppelin-contracts/contracts/utils/Address.sol#185)
    Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#low-level-calls
    ```

    5. too many digits
    ```
    BancorFormula.generalExp(uint256,uint8) (src/bancorprotocol/BancorFormula.sol#748-818) uses literals with too many digits:
    ```
    
    6.reentrancy-vulnerabilities-3, I have use the check-effects-interactions pattern. but the slither can't check it.
    ```
    Reentrancy in UntrustedEscrow.deposit(address,uint256,address) (src/UntrustedEscrow.sol#69-96):
	External calls:
	- ERC20(erc20Token).safeTransferFrom(msg.sender,address(this),amount) (src/UntrustedEscrow.sol#86)
	State variables written after the call(s):
	- _seller_buyer_coinInfo[sellerAddress][msg.sender].balance = transferValue (src/UntrustedEscrow.sol#92)
	UntrustedEscrow._seller_buyer_coinInfo (src/UntrustedEscrow.sol#48) can be used in cross function reentrancies:
	- UntrustedEscrow.deposit(address,uint256,address) (src/UntrustedEscrow.sol#69-96)
	- UntrustedEscrow.escrowCoinInfo(address,address) (src/UntrustedEscrow.sol#132-134)
    Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#reentrancy-vulnerabilities-1


    Reentrancy in UntrustedEscrow.deposit(address,uint256,address) (src/UntrustedEscrow.sol#69-96):
        External calls:
        - ERC20(erc20Token).safeTransferFrom(msg.sender,address(this),amount) (src/UntrustedEscrow.sol#86)
        Event emitted after the call(s):
        - Deposit(msg.sender,sellerAddress,erc20Token,transferValue) (src/UntrustedEscrow.sol#95)
    Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#reentrancy-vulnerabilities-3
    
    ```


    7.block-timestamp, It doesn't mattar for this implementant
    ```
    UntrustedEscrow.withdraw(address) (src/UntrustedEscrow.sol#101-122) uses timestamp for comparisons
	Dangerous comparisons:
	- require(bool,string)(block.timestamp - _seller_buyer_coinInfo[msg.sender][buyer].depositTimestamp > 259200,Should withdraw after 3 days) (src/UntrustedEscrow.sol#102-105)
    Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#block-timestamp


    8.local-variable-shadowing, In my opinion, It's no problem.
    ```
    SanctionToken.constructor(uint256,string,string).name (src/SanctionToken.sol#22) shadows:
	- ERC20.name() (lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol#62-64) (function)
	- IERC20Metadata.name() (lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol#17) (function)
    SanctionToken.constructor(uint256,string,string).symbol (src/SanctionToken.sol#22) shadows:
	- ERC20.symbol() (lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol#70-72) (function)
	- IERC20Metadata.symbol() (lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol#22) (function)
    Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#local-variable-shadowing
    ```    

    ```
    TokenGodMod.constructor(address,uint256).totalSupply (src/TokenGodMod.sol#20) shadows:
	- ERC20.totalSupply() (lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol#94-96) (function)
	- IERC20.totalSupply() (lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol#27) (function)
    Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#local-variable-shadowing
    ```


## 2. true positives
    
    1. Warning: Contract code size exceeds 24576 bytes
        src/bancorprotocol/BancorFormula.sol
    
    2.unchecked-transfer

    ```
    ERC1363BondingCurveToken.burn(uint256) (src/ERC1363BondingCurveToken.sol#154-157) ignores return value by _reserveToken.transfer(msg.sender,redeemAmount) (src/ERC1363BondingCurveToken.sol#156)
    Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#unchecked-transfer
    ``` 

    3.missing-inheritance
    ```
    ERC1363BondingCurveToken (src/ERC1363BondingCurveToken.sol#35-199) should inherit from IERC1363Receiver (src/erc1363-payable-token/IERC1363Receiver.sol#10-32)
    ERC1363BondingCurveToken (src/ERC1363BondingCurveToken.sol#35-199) should inherit from IERC1363Receiver (src/erc1363-payable-token/IERC1363Receiver.sol#10-32)
    Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#missing-inheritance
    ```

    4.state-variables-that-could-be-declared-immutable
    ```
    TokenGodMod._specialAddress (src/TokenGodMod.sol#18) should be immutable
    Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#state-variables-that-could-be-declared-immutable
    ```

    5.conformance-to-solidity-naming-conventions
    ```
    Variable UntrustedEscrow._seller_buyer_coinInfo (src/UntrustedEscrow.sol#48) is not in mixedCase
    Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#conformance-to-solidity-naming-conventions
    ```

## 3. other detectors 

    1.divide-before-multiply, the lib should have considered the precision.
    ```
    BancorFormula.accurateWeights(uint256,uint256) (src/bancorprotocol/BancorFormula.sol#1211-1220) performs a multiplication on the result of a division:
	- _a /= c (src/bancorprotocol/BancorFormula.sol#1214)
	- x = roundDiv(_a * MAX_WEIGHT,_a + _b) (src/bancorprotocol/BancorFormula.sol#1217)
    Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#divide-before-multiply

    2. dangerous-strict-equalities
    ```
    BancorFormula.saleTargetAmount(uint256,uint256,uint32,uint256) (src/bancorprotocol/BancorFormula.sol#363-391) uses a dangerous strict equality:
	- _amount == _supply (src/bancorprotocol/BancorFormula.sol#379)
    Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#dangerous-strict-equalities
    ```

    3.missing-zero-address-validation, my desgin doesn't need to consider the zero address
    ```
    TokenGodMod.constructor(address,uint256).specialAddress (src/TokenGodMod.sol#20) lacks a zero-check on :
		- _specialAddress = specialAddress (src/TokenGodMod.sol#21)
    Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#missing-zero-address-validation
    ```

    4.incorrect-versions-of-solidity, In my opinion, It seems doesn't matter, just not use the more order versions. like 0.4.
    ```
    Pragma version0.8.9 (src/UntrustedEscrow.sol#2) allows old versions
    solc-0.8.9 is not recommended for deployment
    Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#incorrect-versions-of-solidity
    ```

## dig more?

    1. dangerous-strict-equalities, use can  affect the reserve while to this calculaiton, but for this, It seems doesn't matter. just as uniswap v2 store the last update reserve?
    ```
    BancorFormula.saleTargetAmount(uint256,uint256,uint32,uint256) (src/bancorprotocol/BancorFormula.sol#363-391) uses a dangerous strict equality:
	- _amount == _supply (src/bancorprotocol/BancorFormula.sol#379)
    Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#dangerous-strict-equalities
    ```

## Todo
1. BancorFormula contract size seems two big, should decrease.








