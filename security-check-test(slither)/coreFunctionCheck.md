'solc --version' running
'solc @openzeppelin/contracts/=lib/openzeppelin-contracts/contracts/ @bancorprotocol/converter=lib/contracts-solidity/solidity/contracts/converter @erc1363-payable-token/contracts=lib/erc1363-payable-token/contracts src/TokenGodMod.sol --combined-json abi,ast,bin,bin-runtime,srcmap,srcmap-runtime,userdoc,devdoc,hashes,compact-format --allow-paths .,/Volumes/data_1/rareskills/week1_ERC1363_Tokens_and_Bonding_Curves/src' running
'solc --version' running
'solc @openzeppelin/contracts/=lib/openzeppelin-contracts/contracts/ @bancorprotocol/converter=lib/contracts-solidity/solidity/contracts/converter @erc1363-payable-token/contracts=lib/erc1363-payable-token/contracts src/SanctionToken.sol --combined-json abi,ast,bin,bin-runtime,srcmap,srcmap-runtime,userdoc,devdoc,hashes,compact-format --allow-paths .,/Volumes/data_1/rareskills/week1_ERC1363_Tokens_and_Bonding_Curves/src' running
'solc --version' running
'solc @openzeppelin/contracts/=lib/openzeppelin-contracts/contracts/ @bancorprotocol/converter=lib/contracts-solidity/solidity/contracts/converter @erc1363-payable-token/contracts=lib/erc1363-payable-token/contracts src/UntrustedEscrow.sol --combined-json abi,ast,bin,bin-runtime,srcmap,srcmap-runtime,userdoc,devdoc,hashes,compact-format --allow-paths .,/Volumes/data_1/rareskills/week1_ERC1363_Tokens_and_Bonding_Curves/src' running
'solc --version' running
'solc @openzeppelin/contracts/=lib/openzeppelin-contracts/contracts/ @bancorprotocol/converter=lib/contracts-solidity/solidity/contracts/converter @erc1363-payable-token/contracts=lib/erc1363-payable-token/contracts src/ERC1363BondingCurveToken.sol --combined-json abi,ast,bin,bin-runtime,srcmap,srcmap-runtime,userdoc,devdoc,hashes,compact-format --allow-paths .,/Volumes/data_1/rareskills/week1_ERC1363_Tokens_and_Bonding_Curves/src' running
Compilation warnings/errors on src/ERC1363BondingCurveToken.sol:
Warning: Contract code size exceeds 24576 bytes (a limit introduced in Spurious Dragon). This contract may not be deployable on mainnet. Consider enabling the optimizer (with a low "runs" value!), turning off revert strings, or using libraries.
 --> src/bancorprotocol/BancorFormula.sol:6:1:
  |
6 | contract BancorFormula is IBancorFormula {
  | ^ (Relevant source part starts here and spans across multiple lines).

Warning: Contract code size exceeds 24576 bytes (a limit introduced in Spurious Dragon). This contract may not be deployable on mainnet. Consider enabling the optimizer (with a low "runs" value!), turning off revert strings, or using libraries.
  --> src/ERC1363BondingCurveToken.sol:35:1:
   |
35 | contract ERC1363BondingCurveToken is Initializable, Ownable, ERC1363, BancorFormula {
   | ^ (Relevant source part starts here and spans across multiple lines).


INFO:Detectors:
TokenGodMod.constructor(address,uint256).totalSupply (src/TokenGodMod.sol#20) shadows:
	- ERC20.totalSupply() (lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol#94-96) (function)
	- IERC20.totalSupply() (lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol#27) (function)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#local-variable-shadowing
INFO:Detectors:
TokenGodMod.constructor(address,uint256).specialAddress (src/TokenGodMod.sol#20) lacks a zero-check on :
		- _specialAddress = specialAddress (src/TokenGodMod.sol#21)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#missing-zero-address-validation
INFO:Detectors:
Different versions of Solidity are used:
	- Version used: ['0.8.9', '^0.8.0']
	- 0.8.9 (src/TokenGodMod.sol#2)
	- ^0.8.0 (lib/openzeppelin-contracts/contracts/access/Ownable.sol#4)
	- ^0.8.0 (lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol#4)
	- ^0.8.0 (lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol#4)
	- ^0.8.0 (lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol#4)
	- ^0.8.0 (lib/openzeppelin-contracts/contracts/utils/Context.sol#4)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#different-pragma-directives-are-used
INFO:Detectors:
Context._msgData() (lib/openzeppelin-contracts/contracts/utils/Context.sol#21-23) is never used and should be removed
ERC20._burn(address,uint256) (lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol#277-293) is never used and should be removed
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#dead-code
INFO:Detectors:
Pragma version^0.8.0 (lib/openzeppelin-contracts/contracts/access/Ownable.sol#4) allows old versions
Pragma version^0.8.0 (lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol#4) allows old versions
Pragma version^0.8.0 (lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol#4) allows old versions
Pragma version^0.8.0 (lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol#4) allows old versions
Pragma version^0.8.0 (lib/openzeppelin-contracts/contracts/utils/Context.sol#4) allows old versions
Pragma version0.8.9 (src/TokenGodMod.sol#2) allows old versions
solc-0.8.9 is not recommended for deployment
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#incorrect-versions-of-solidity
INFO:Detectors:
TokenGodMod._specialAddress (src/TokenGodMod.sol#18) should be immutable 
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#state-variables-that-could-be-declared-immutable
INFO:Detectors:
SanctionToken.constructor(uint256,string,string).name (src/SanctionToken.sol#22) shadows:
	- ERC20.name() (lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol#62-64) (function)
	- IERC20Metadata.name() (lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol#17) (function)
SanctionToken.constructor(uint256,string,string).symbol (src/SanctionToken.sol#22) shadows:
	- ERC20.symbol() (lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol#70-72) (function)
	- IERC20Metadata.symbol() (lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol#22) (function)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#local-variable-shadowing
INFO:Detectors:
Different versions of Solidity are used:
	- Version used: ['0.8.9', '^0.8.0']
	- 0.8.9 (src/SanctionToken.sol#2)
	- ^0.8.0 (lib/openzeppelin-contracts/contracts/access/Ownable.sol#4)
	- ^0.8.0 (lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol#4)
	- ^0.8.0 (lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol#4)
	- ^0.8.0 (lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol#4)
	- ^0.8.0 (lib/openzeppelin-contracts/contracts/utils/Context.sol#4)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#different-pragma-directives-are-used
INFO:Detectors:
Context._msgData() (lib/openzeppelin-contracts/contracts/utils/Context.sol#21-23) is never used and should be removed
ERC20._burn(address,uint256) (lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol#277-293) is never used and should be removed
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#dead-code
INFO:Detectors:
Pragma version^0.8.0 (lib/openzeppelin-contracts/contracts/access/Ownable.sol#4) allows old versions
Pragma version^0.8.0 (lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol#4) allows old versions
Pragma version^0.8.0 (lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol#4) allows old versions
Pragma version^0.8.0 (lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol#4) allows old versions
Pragma version^0.8.0 (lib/openzeppelin-contracts/contracts/utils/Context.sol#4) allows old versions
Pragma version0.8.9 (src/SanctionToken.sol#2) allows old versions
solc-0.8.9 is not recommended for deployment
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#incorrect-versions-of-solidity
INFO:Detectors:
Reentrancy in UntrustedEscrow.deposit(address,uint256,address) (src/UntrustedEscrow.sol#69-96):
	External calls:
	- ERC20(erc20Token).safeTransferFrom(msg.sender,address(this),amount) (src/UntrustedEscrow.sol#86)
	State variables written after the call(s):
	- _seller_buyer_coinInfo[sellerAddress][msg.sender].balance = transferValue (src/UntrustedEscrow.sol#92)
	UntrustedEscrow._seller_buyer_coinInfo (src/UntrustedEscrow.sol#48) can be used in cross function reentrancies:
	- UntrustedEscrow.deposit(address,uint256,address) (src/UntrustedEscrow.sol#69-96)
	- UntrustedEscrow.escrowCoinInfo(address,address) (src/UntrustedEscrow.sol#132-134)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#reentrancy-vulnerabilities-1
INFO:Detectors:
Reentrancy in UntrustedEscrow.deposit(address,uint256,address) (src/UntrustedEscrow.sol#69-96):
	External calls:
	- ERC20(erc20Token).safeTransferFrom(msg.sender,address(this),amount) (src/UntrustedEscrow.sol#86)
	Event emitted after the call(s):
	- Deposit(msg.sender,sellerAddress,erc20Token,transferValue) (src/UntrustedEscrow.sol#95)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#reentrancy-vulnerabilities-3
INFO:Detectors:
UntrustedEscrow.withdraw(address) (src/UntrustedEscrow.sol#101-122) uses timestamp for comparisons
	Dangerous comparisons:
	- require(bool,string)(block.timestamp - _seller_buyer_coinInfo[msg.sender][buyer].depositTimestamp > 259200,Should withdraw after 3 days) (src/UntrustedEscrow.sol#102-105)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#block-timestamp
INFO:Detectors:
Address._revert(bytes,string) (lib/openzeppelin-contracts/contracts/utils/Address.sol#231-243) uses assembly
	- INLINE ASM (lib/openzeppelin-contracts/contracts/utils/Address.sol#236-239)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#assembly-usage
INFO:Detectors:
Different versions of Solidity are used:
	- Version used: ['0.8.9', '^0.8.0', '^0.8.1']
	- 0.8.9 (src/UntrustedEscrow.sol#2)
	- ^0.8.0 (lib/openzeppelin-contracts/contracts/access/Ownable.sol#4)
	- ^0.8.0 (lib/openzeppelin-contracts/contracts/security/Pausable.sol#4)
	- ^0.8.0 (lib/openzeppelin-contracts/contracts/security/ReentrancyGuard.sol#4)
	- ^0.8.0 (lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol#4)
	- ^0.8.0 (lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol#4)
	- ^0.8.0 (lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol#4)
	- ^0.8.0 (lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Permit.sol#4)
	- ^0.8.0 (lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol#4)
	- ^0.8.0 (lib/openzeppelin-contracts/contracts/utils/Context.sol#4)
	- ^0.8.1 (lib/openzeppelin-contracts/contracts/utils/Address.sol#4)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#different-pragma-directives-are-used
INFO:Detectors:
Address.functionCall(address,bytes) (lib/openzeppelin-contracts/contracts/utils/Address.sol#89-91) is never used and should be removed
Address.functionCallWithValue(address,bytes,uint256) (lib/openzeppelin-contracts/contracts/utils/Address.sol#118-120) is never used and should be removed
Address.functionDelegateCall(address,bytes) (lib/openzeppelin-contracts/contracts/utils/Address.sol#170-172) is never used and should be removed
Address.functionDelegateCall(address,bytes,string) (lib/openzeppelin-contracts/contracts/utils/Address.sol#180-187) is never used and should be removed
Address.functionStaticCall(address,bytes) (lib/openzeppelin-contracts/contracts/utils/Address.sol#145-147) is never used and should be removed
Address.functionStaticCall(address,bytes,string) (lib/openzeppelin-contracts/contracts/utils/Address.sol#155-162) is never used and should be removed
Address.sendValue(address,uint256) (lib/openzeppelin-contracts/contracts/utils/Address.sol#64-69) is never used and should be removed
Address.verifyCallResult(bool,bytes,string) (lib/openzeppelin-contracts/contracts/utils/Address.sol#219-229) is never used and should be removed
Context._msgData() (lib/openzeppelin-contracts/contracts/utils/Context.sol#21-23) is never used and should be removed
ERC20._burn(address,uint256) (lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol#277-293) is never used and should be removed
ERC20._mint(address,uint256) (lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol#251-264) is never used and should be removed
ReentrancyGuard._reentrancyGuardEntered() (lib/openzeppelin-contracts/contracts/security/ReentrancyGuard.sol#74-76) is never used and should be removed
SafeERC20._callOptionalReturnBool(IERC20,bytes) (lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol#134-142) is never used and should be removed
SafeERC20.forceApprove(IERC20,address,uint256) (lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol#82-89) is never used and should be removed
SafeERC20.safeApprove(IERC20,address,uint256) (lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol#45-54) is never used and should be removed
SafeERC20.safeDecreaseAllowance(IERC20,address,uint256) (lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol#69-75) is never used and should be removed
SafeERC20.safeIncreaseAllowance(IERC20,address,uint256) (lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol#60-63) is never used and should be removed
SafeERC20.safePermit(IERC20Permit,address,address,uint256,uint256,uint8,bytes32,bytes32) (lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol#95-109) is never used and should be removed
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#dead-code
INFO:Detectors:
Pragma version^0.8.0 (lib/openzeppelin-contracts/contracts/access/Ownable.sol#4) allows old versions
Pragma version^0.8.0 (lib/openzeppelin-contracts/contracts/security/Pausable.sol#4) allows old versions
Pragma version^0.8.0 (lib/openzeppelin-contracts/contracts/security/ReentrancyGuard.sol#4) allows old versions
Pragma version^0.8.0 (lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol#4) allows old versions
Pragma version^0.8.0 (lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol#4) allows old versions
Pragma version^0.8.0 (lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol#4) allows old versions
Pragma version^0.8.0 (lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Permit.sol#4) allows old versions
Pragma version^0.8.0 (lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol#4) allows old versions
Pragma version^0.8.1 (lib/openzeppelin-contracts/contracts/utils/Address.sol#4) allows old versions
Pragma version^0.8.0 (lib/openzeppelin-contracts/contracts/utils/Context.sol#4) allows old versions
Pragma version0.8.9 (src/UntrustedEscrow.sol#2) allows old versions
solc-0.8.9 is not recommended for deployment
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#incorrect-versions-of-solidity
INFO:Detectors:
Low level call in SafeERC20._callOptionalReturnBool(IERC20,bytes) (lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol#134-142):
	- (success,returndata) = address(token).call(data) (lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol#139)
Low level call in Address.sendValue(address,uint256) (lib/openzeppelin-contracts/contracts/utils/Address.sol#64-69):
	- (success) = recipient.call{value: amount}() (lib/openzeppelin-contracts/contracts/utils/Address.sol#67)
Low level call in Address.functionCallWithValue(address,bytes,uint256,string) (lib/openzeppelin-contracts/contracts/utils/Address.sol#128-137):
	- (success,returndata) = target.call{value: value}(data) (lib/openzeppelin-contracts/contracts/utils/Address.sol#135)
Low level call in Address.functionStaticCall(address,bytes,string) (lib/openzeppelin-contracts/contracts/utils/Address.sol#155-162):
	- (success,returndata) = target.staticcall(data) (lib/openzeppelin-contracts/contracts/utils/Address.sol#160)
Low level call in Address.functionDelegateCall(address,bytes,string) (lib/openzeppelin-contracts/contracts/utils/Address.sol#180-187):
	- (success,returndata) = target.delegatecall(data) (lib/openzeppelin-contracts/contracts/utils/Address.sol#185)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#low-level-calls
INFO:Detectors:
Function IERC20Permit.DOMAIN_SEPARATOR() (lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Permit.sol#59) is not in mixedCase
Variable UntrustedEscrow._seller_buyer_coinInfo (src/UntrustedEscrow.sol#48) is not in mixedCase
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#conformance-to-solidity-naming-conventions
INFO:Detectors:
ERC1363BondingCurveToken.burn(uint256) (src/ERC1363BondingCurveToken.sol#154-157) ignores return value by _reserveToken.transfer(msg.sender,redeemAmount) (src/ERC1363BondingCurveToken.sol#156)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#unchecked-transfer
INFO:Detectors:
BancorFormula.optimalLog(uint256) (src/bancorprotocol/BancorFormula.sol#831-890) performs a multiplication on the result of a division:
	- x = (x * FIXED_1) / 0xd3094c70f034de4b96ff7d5b6f99fcd8 (src/bancorprotocol/BancorFormula.sol#840)
	- x = (x * FIXED_1) / 0xa45af1e1f40c333b3de1db4dd55f29a7 (src/bancorprotocol/BancorFormula.sol#844)
BancorFormula.optimalLog(uint256) (src/bancorprotocol/BancorFormula.sol#831-890) performs a multiplication on the result of a division:
	- x = (x * FIXED_1) / 0xa45af1e1f40c333b3de1db4dd55f29a7 (src/bancorprotocol/BancorFormula.sol#844)
	- x = (x * FIXED_1) / 0x910b022db7ae67ce76b441c27035c6a1 (src/bancorprotocol/BancorFormula.sol#848)
BancorFormula.optimalLog(uint256) (src/bancorprotocol/BancorFormula.sol#831-890) performs a multiplication on the result of a division:
	- x = (x * FIXED_1) / 0x910b022db7ae67ce76b441c27035c6a1 (src/bancorprotocol/BancorFormula.sol#848)
	- x = (x * FIXED_1) / 0x88415abbe9a76bead8d00cf112e4d4a8 (src/bancorprotocol/BancorFormula.sol#852)
BancorFormula.optimalLog(uint256) (src/bancorprotocol/BancorFormula.sol#831-890) performs a multiplication on the result of a division:
	- x = (x * FIXED_1) / 0x88415abbe9a76bead8d00cf112e4d4a8 (src/bancorprotocol/BancorFormula.sol#852)
	- x = (x * FIXED_1) / 0x84102b00893f64c705e841d5d4064bd3 (src/bancorprotocol/BancorFormula.sol#856)
BancorFormula.optimalLog(uint256) (src/bancorprotocol/BancorFormula.sol#831-890) performs a multiplication on the result of a division:
	- x = (x * FIXED_1) / 0x84102b00893f64c705e841d5d4064bd3 (src/bancorprotocol/BancorFormula.sol#856)
	- x = (x * FIXED_1) / 0x8204055aaef1c8bd5c3259f4822735a2 (src/bancorprotocol/BancorFormula.sol#860)
BancorFormula.optimalLog(uint256) (src/bancorprotocol/BancorFormula.sol#831-890) performs a multiplication on the result of a division:
	- x = (x * FIXED_1) / 0x8204055aaef1c8bd5c3259f4822735a2 (src/bancorprotocol/BancorFormula.sol#860)
	- x = (x * FIXED_1) / 0x810100ab00222d861931c15e39b44e99 (src/bancorprotocol/BancorFormula.sol#864)
BancorFormula.optimalLog(uint256) (src/bancorprotocol/BancorFormula.sol#831-890) performs a multiplication on the result of a division:
	- x = (x * FIXED_1) / 0x810100ab00222d861931c15e39b44e99 (src/bancorprotocol/BancorFormula.sol#864)
	- x = (x * FIXED_1) / 0x808040155aabbbe9451521693554f733 (src/bancorprotocol/BancorFormula.sol#868)
BancorFormula.optimalLog(uint256) (src/bancorprotocol/BancorFormula.sol#831-890) performs a multiplication on the result of a division:
	- w = (y * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#872)
	- z = (z * w) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#874)
BancorFormula.optimalLog(uint256) (src/bancorprotocol/BancorFormula.sol#831-890) performs a multiplication on the result of a division:
	- z = (z * w) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#874)
	- res += (z * (0x0aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa - y)) / 0x200000000000000000000000000000000 (src/bancorprotocol/BancorFormula.sol#875)
BancorFormula.optimalLog(uint256) (src/bancorprotocol/BancorFormula.sol#831-890) performs a multiplication on the result of a division:
	- w = (y * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#872)
	- z = (z * w) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#874)
	- z = (z * w) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#876)
BancorFormula.optimalLog(uint256) (src/bancorprotocol/BancorFormula.sol#831-890) performs a multiplication on the result of a division:
	- z = (z * w) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#876)
	- res += (z * (0x099999999999999999999999999999999 - y)) / 0x300000000000000000000000000000000 (src/bancorprotocol/BancorFormula.sol#877)
BancorFormula.optimalLog(uint256) (src/bancorprotocol/BancorFormula.sol#831-890) performs a multiplication on the result of a division:
	- w = (y * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#872)
	- z = (z * w) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#876)
	- z = (z * w) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#878)
BancorFormula.optimalLog(uint256) (src/bancorprotocol/BancorFormula.sol#831-890) performs a multiplication on the result of a division:
	- z = (z * w) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#878)
	- res += (z * (0x092492492492492492492492492492492 - y)) / 0x400000000000000000000000000000000 (src/bancorprotocol/BancorFormula.sol#879)
BancorFormula.optimalLog(uint256) (src/bancorprotocol/BancorFormula.sol#831-890) performs a multiplication on the result of a division:
	- w = (y * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#872)
	- z = (z * w) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#878)
	- z = (z * w) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#880)
BancorFormula.optimalLog(uint256) (src/bancorprotocol/BancorFormula.sol#831-890) performs a multiplication on the result of a division:
	- z = (z * w) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#880)
	- res += (z * (0x08e38e38e38e38e38e38e38e38e38e38e - y)) / 0x500000000000000000000000000000000 (src/bancorprotocol/BancorFormula.sol#881)
BancorFormula.optimalLog(uint256) (src/bancorprotocol/BancorFormula.sol#831-890) performs a multiplication on the result of a division:
	- w = (y * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#872)
	- z = (z * w) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#880)
	- z = (z * w) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#882)
BancorFormula.optimalLog(uint256) (src/bancorprotocol/BancorFormula.sol#831-890) performs a multiplication on the result of a division:
	- z = (z * w) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#882)
	- res += (z * (0x08ba2e8ba2e8ba2e8ba2e8ba2e8ba2e8b - y)) / 0x600000000000000000000000000000000 (src/bancorprotocol/BancorFormula.sol#883)
BancorFormula.optimalLog(uint256) (src/bancorprotocol/BancorFormula.sol#831-890) performs a multiplication on the result of a division:
	- w = (y * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#872)
	- z = (z * w) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#882)
	- z = (z * w) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#884)
BancorFormula.optimalLog(uint256) (src/bancorprotocol/BancorFormula.sol#831-890) performs a multiplication on the result of a division:
	- z = (z * w) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#884)
	- res += (z * (0x089d89d89d89d89d89d89d89d89d89d89 - y)) / 0x700000000000000000000000000000000 (src/bancorprotocol/BancorFormula.sol#885)
BancorFormula.optimalLog(uint256) (src/bancorprotocol/BancorFormula.sol#831-890) performs a multiplication on the result of a division:
	- w = (y * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#872)
	- z = (z * w) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#884)
	- z = (z * w) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#886)
BancorFormula.optimalLog(uint256) (src/bancorprotocol/BancorFormula.sol#831-890) performs a multiplication on the result of a division:
	- z = (z * w) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#886)
	- res += (z * (0x088888888888888888888888888888888 - y)) / 0x800000000000000000000000000000000 (src/bancorprotocol/BancorFormula.sol#887)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#910)
	- res += z * 0x10e1b3be415a0000 (src/bancorprotocol/BancorFormula.sol#911)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#910)
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#912)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#912)
	- res += z * 0x05a0913f6b1e0000 (src/bancorprotocol/BancorFormula.sol#913)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#912)
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#914)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#914)
	- res += z * 0x0168244fdac78000 (src/bancorprotocol/BancorFormula.sol#915)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#914)
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#916)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#916)
	- res += z * 0x004807432bc18000 (src/bancorprotocol/BancorFormula.sol#917)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#916)
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#918)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#918)
	- res += z * 0x000c0135dca04000 (src/bancorprotocol/BancorFormula.sol#919)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#918)
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#920)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#920)
	- res += z * 0x0001b707b1cdc000 (src/bancorprotocol/BancorFormula.sol#921)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#920)
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#922)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#922)
	- res += z * 0x000036e0f639b800 (src/bancorprotocol/BancorFormula.sol#923)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#922)
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#924)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#924)
	- res += z * 0x00000618fee9f800 (src/bancorprotocol/BancorFormula.sol#925)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#924)
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#926)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#926)
	- res += z * 0x0000009c197dcc00 (src/bancorprotocol/BancorFormula.sol#927)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#926)
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#928)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#928)
	- res += z * 0x0000000e30dce400 (src/bancorprotocol/BancorFormula.sol#929)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#928)
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#930)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#930)
	- res += z * 0x000000012ebd1300 (src/bancorprotocol/BancorFormula.sol#931)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#930)
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#932)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#932)
	- res += z * 0x0000000017499f00 (src/bancorprotocol/BancorFormula.sol#933)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#932)
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#934)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#934)
	- res += z * 0x0000000001a9d480 (src/bancorprotocol/BancorFormula.sol#935)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#934)
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#936)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#936)
	- res += z * 0x00000000001c6380 (src/bancorprotocol/BancorFormula.sol#937)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#936)
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#938)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#938)
	- res += z * 0x000000000001c638 (src/bancorprotocol/BancorFormula.sol#939)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#938)
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#940)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#940)
	- res += z * 0x0000000000001ab8 (src/bancorprotocol/BancorFormula.sol#941)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#940)
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#942)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#942)
	- res += z * 0x000000000000017c (src/bancorprotocol/BancorFormula.sol#943)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#942)
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#944)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#944)
	- res += z * 0x0000000000000014 (src/bancorprotocol/BancorFormula.sol#945)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#944)
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#946)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- z = (z * y) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#946)
	- res += z * 0x0000000000000001 (src/bancorprotocol/BancorFormula.sol#947)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- res = (res * 0x1c3d6a24ed82218787d624d3e5eba95f9) / 0x18ebef9eac820ae8682b9793ac6d1e776 (src/bancorprotocol/BancorFormula.sol#951)
	- res = (res * 0x18ebef9eac820ae8682b9793ac6d1e778) / 0x1368b2fc6f9609fe7aceb46aa619baed4 (src/bancorprotocol/BancorFormula.sol#954)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- res = (res * 0x18ebef9eac820ae8682b9793ac6d1e778) / 0x1368b2fc6f9609fe7aceb46aa619baed4 (src/bancorprotocol/BancorFormula.sol#954)
	- res = (res * 0x1368b2fc6f9609fe7aceb46aa619baed5) / 0x0bc5ab1b16779be3575bd8f0520a9f21f (src/bancorprotocol/BancorFormula.sol#957)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- res = (res * 0x1368b2fc6f9609fe7aceb46aa619baed5) / 0x0bc5ab1b16779be3575bd8f0520a9f21f (src/bancorprotocol/BancorFormula.sol#957)
	- res = (res * 0x0bc5ab1b16779be3575bd8f0520a9f21e) / 0x0454aaa8efe072e7f6ddbab84b40a55c9 (src/bancorprotocol/BancorFormula.sol#960)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- res = (res * 0x0bc5ab1b16779be3575bd8f0520a9f21e) / 0x0454aaa8efe072e7f6ddbab84b40a55c9 (src/bancorprotocol/BancorFormula.sol#960)
	- res = (res * 0x0454aaa8efe072e7f6ddbab84b40a55c5) / 0x00960aadc109e7a3bf4578099615711ea (src/bancorprotocol/BancorFormula.sol#963)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- res = (res * 0x0454aaa8efe072e7f6ddbab84b40a55c5) / 0x00960aadc109e7a3bf4578099615711ea (src/bancorprotocol/BancorFormula.sol#963)
	- res = (res * 0x00960aadc109e7a3bf4578099615711d7) / 0x0002bf84208204f5977f9a8cf01fdce3d (src/bancorprotocol/BancorFormula.sol#966)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) performs a multiplication on the result of a division:
	- res = (res * 0x00960aadc109e7a3bf4578099615711d7) / 0x0002bf84208204f5977f9a8cf01fdce3d (src/bancorprotocol/BancorFormula.sol#966)
	- res = (res * 0x0002bf84208204f5977f9a8cf01fdc307) / 0x0000003c6ab775dd0b95b4cbee7e65d11 (src/bancorprotocol/BancorFormula.sol#969)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1002)
	- res += xi * 0x00000000014d29a73a6e7b02c3668c7b0880000000 (src/bancorprotocol/BancorFormula.sol#1003)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1002)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1004)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1004)
	- res -= xi * 0x0000000002504a0cd9a7f7215b60f9be4800000000 (src/bancorprotocol/BancorFormula.sol#1005)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1004)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1006)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1006)
	- res += xi * 0x000000000484d0a1191c0ead267967c7a4a0000000 (src/bancorprotocol/BancorFormula.sol#1007)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1006)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1008)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1008)
	- res -= xi * 0x00000000095ec580d7e8427a4baf26a90a00000000 (src/bancorprotocol/BancorFormula.sol#1009)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1008)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1010)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1010)
	- res += xi * 0x000000001440b0be1615a47dba6e5b3b1f10000000 (src/bancorprotocol/BancorFormula.sol#1011)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1010)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1012)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1012)
	- res -= xi * 0x000000002d207601f46a99b4112418400000000000 (src/bancorprotocol/BancorFormula.sol#1013)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1012)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1014)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1014)
	- res += xi * 0x0000000066ebaac4c37c622dd8288a7eb1b2000000 (src/bancorprotocol/BancorFormula.sol#1015)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1014)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1016)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1016)
	- res -= xi * 0x00000000ef17240135f7dbd43a1ba10cf200000000 (src/bancorprotocol/BancorFormula.sol#1017)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1016)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1018)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1018)
	- res += xi * 0x0000000233c33c676a5eb2416094a87b3657000000 (src/bancorprotocol/BancorFormula.sol#1019)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1018)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1020)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1020)
	- res -= xi * 0x0000000541cde48bc0254bed49a9f8700000000000 (src/bancorprotocol/BancorFormula.sol#1021)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1020)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1022)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1022)
	- res += xi * 0x0000000cae1fad2cdd4d4cb8d73abca0d19a400000 (src/bancorprotocol/BancorFormula.sol#1023)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1022)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1024)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1024)
	- res -= xi * 0x0000001edb2aa2f760d15c41ceedba956400000000 (src/bancorprotocol/BancorFormula.sol#1025)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1024)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1026)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1026)
	- res += xi * 0x0000004ba8d20d2dabd386c9529659841a2e200000 (src/bancorprotocol/BancorFormula.sol#1027)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1026)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1028)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1028)
	- res -= xi * 0x000000bac08546b867cdaa20000000000000000000 (src/bancorprotocol/BancorFormula.sol#1029)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1028)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1030)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1030)
	- res += xi * 0x000001cfa8e70c03625b9db76c8ebf5bbf24820000 (src/bancorprotocol/BancorFormula.sol#1031)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1030)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1032)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1032)
	- res -= xi * 0x000004851d99f82060df265f3309b26f8200000000 (src/bancorprotocol/BancorFormula.sol#1033)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1032)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1034)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1034)
	- res += xi * 0x00000b550d19b129d270c44f6f55f027723cbb0000 (src/bancorprotocol/BancorFormula.sol#1035)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1034)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1036)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1036)
	- res -= xi * 0x00001c877dadc761dc272deb65d4b0000000000000 (src/bancorprotocol/BancorFormula.sol#1037)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1036)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1038)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1038)
	- res += xi * 0x000048178ece97479f33a77f2ad22a81b64406c000 (src/bancorprotocol/BancorFormula.sol#1039)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1038)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1040)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1040)
	- res -= xi * 0x0000b6ca8268b9d810fedf6695ef2f8a6c00000000 (src/bancorprotocol/BancorFormula.sol#1041)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1040)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1042)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1042)
	- res += xi * 0x0001d0e76631a5b05d007b8cb72a7c7f11ec36e000 (src/bancorprotocol/BancorFormula.sol#1043)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1042)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1044)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1044)
	- res -= xi * 0x0004a1c37bd9f85fd9c6c780000000000000000000 (src/bancorprotocol/BancorFormula.sol#1045)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1044)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1046)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1046)
	- res += xi * 0x000bd8369f1b702bf491e2ebfcee08250313b65400 (src/bancorprotocol/BancorFormula.sol#1047)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1046)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1048)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1048)
	- res -= xi * 0x001e5c7c32a9f6c70ab2cb59d9225764d400000000 (src/bancorprotocol/BancorFormula.sol#1049)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1048)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1050)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1050)
	- res += xi * 0x004dff5820e165e910f95120a708e742496221e600 (src/bancorprotocol/BancorFormula.sol#1051)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1050)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1052)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1052)
	- res -= xi * 0x00c8c8f66db1fced378ee50e536000000000000000 (src/bancorprotocol/BancorFormula.sol#1053)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1052)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1054)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1054)
	- res += xi * 0x0205db8dffff45bfa2938f128f599dbf16eb11d880 (src/bancorprotocol/BancorFormula.sol#1055)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1054)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1056)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1056)
	- res -= xi * 0x053a044ebd984351493e1786af38d39a0800000000 (src/bancorprotocol/BancorFormula.sol#1057)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1056)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1058)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1058)
	- res += xi * 0x0d86dae2a4cc0f47633a544479735869b487b59c40 (src/bancorprotocol/BancorFormula.sol#1059)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1058)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1060)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1060)
	- res -= xi * 0x231000000000000000000000000000000000000000 (src/bancorprotocol/BancorFormula.sol#1061)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1060)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1062)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1062)
	- res += xi * 0x5b0485a76f6646c2039db1507cdd51b08649680822 (src/bancorprotocol/BancorFormula.sol#1063)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1062)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1064)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1064)
	- res -= xi * 0xec983c46c49545bc17efa6b5b0055e242200000000 (src/bancorprotocol/BancorFormula.sol#1065)
BancorFormula.lambertPos2(uint256) (src/bancorprotocol/BancorFormula.sol#1074-1082) performs a multiplication on the result of a division:
	- i = x / LAMBERT_POS2_SAMPLE (src/bancorprotocol/BancorFormula.sol#1076)
	- a = LAMBERT_POS2_SAMPLE * i (src/bancorprotocol/BancorFormula.sol#1077)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1103)
	- res += xi * 0x00000000014d29a73a6e7b02c3668c7b0880000000 (src/bancorprotocol/BancorFormula.sol#1104)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1103)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1105)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1105)
	- res += xi * 0x0000000002504a0cd9a7f7215b60f9be4800000000 (src/bancorprotocol/BancorFormula.sol#1106)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1105)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1107)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1107)
	- res += xi * 0x000000000484d0a1191c0ead267967c7a4a0000000 (src/bancorprotocol/BancorFormula.sol#1108)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1107)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1109)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1109)
	- res += xi * 0x00000000095ec580d7e8427a4baf26a90a00000000 (src/bancorprotocol/BancorFormula.sol#1110)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1109)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1111)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1111)
	- res += xi * 0x000000001440b0be1615a47dba6e5b3b1f10000000 (src/bancorprotocol/BancorFormula.sol#1112)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1111)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1113)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1113)
	- res += xi * 0x000000002d207601f46a99b4112418400000000000 (src/bancorprotocol/BancorFormula.sol#1114)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1113)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1115)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1115)
	- res += xi * 0x0000000066ebaac4c37c622dd8288a7eb1b2000000 (src/bancorprotocol/BancorFormula.sol#1116)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1115)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1117)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1117)
	- res += xi * 0x00000000ef17240135f7dbd43a1ba10cf200000000 (src/bancorprotocol/BancorFormula.sol#1118)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1117)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1119)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1119)
	- res += xi * 0x0000000233c33c676a5eb2416094a87b3657000000 (src/bancorprotocol/BancorFormula.sol#1120)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1119)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1121)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1121)
	- res += xi * 0x0000000541cde48bc0254bed49a9f8700000000000 (src/bancorprotocol/BancorFormula.sol#1122)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1121)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1123)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1123)
	- res += xi * 0x0000000cae1fad2cdd4d4cb8d73abca0d19a400000 (src/bancorprotocol/BancorFormula.sol#1124)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1123)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1125)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1125)
	- res += xi * 0x0000001edb2aa2f760d15c41ceedba956400000000 (src/bancorprotocol/BancorFormula.sol#1126)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1125)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1127)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1127)
	- res += xi * 0x0000004ba8d20d2dabd386c9529659841a2e200000 (src/bancorprotocol/BancorFormula.sol#1128)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1127)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1129)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1129)
	- res += xi * 0x000000bac08546b867cdaa20000000000000000000 (src/bancorprotocol/BancorFormula.sol#1130)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1129)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1131)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1131)
	- res += xi * 0x000001cfa8e70c03625b9db76c8ebf5bbf24820000 (src/bancorprotocol/BancorFormula.sol#1132)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1131)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1133)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1133)
	- res += xi * 0x000004851d99f82060df265f3309b26f8200000000 (src/bancorprotocol/BancorFormula.sol#1134)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1133)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1135)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1135)
	- res += xi * 0x00000b550d19b129d270c44f6f55f027723cbb0000 (src/bancorprotocol/BancorFormula.sol#1136)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1135)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1137)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1137)
	- res += xi * 0x00001c877dadc761dc272deb65d4b0000000000000 (src/bancorprotocol/BancorFormula.sol#1138)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1137)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1139)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1139)
	- res += xi * 0x000048178ece97479f33a77f2ad22a81b64406c000 (src/bancorprotocol/BancorFormula.sol#1140)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1139)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1141)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1141)
	- res += xi * 0x0000b6ca8268b9d810fedf6695ef2f8a6c00000000 (src/bancorprotocol/BancorFormula.sol#1142)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1141)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1143)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1143)
	- res += xi * 0x0001d0e76631a5b05d007b8cb72a7c7f11ec36e000 (src/bancorprotocol/BancorFormula.sol#1144)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1143)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1145)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1145)
	- res += xi * 0x0004a1c37bd9f85fd9c6c780000000000000000000 (src/bancorprotocol/BancorFormula.sol#1146)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1145)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1147)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1147)
	- res += xi * 0x000bd8369f1b702bf491e2ebfcee08250313b65400 (src/bancorprotocol/BancorFormula.sol#1148)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1147)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1149)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1149)
	- res += xi * 0x001e5c7c32a9f6c70ab2cb59d9225764d400000000 (src/bancorprotocol/BancorFormula.sol#1150)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1149)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1151)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1151)
	- res += xi * 0x004dff5820e165e910f95120a708e742496221e600 (src/bancorprotocol/BancorFormula.sol#1152)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1151)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1153)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1153)
	- res += xi * 0x00c8c8f66db1fced378ee50e536000000000000000 (src/bancorprotocol/BancorFormula.sol#1154)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1153)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1155)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1155)
	- res += xi * 0x0205db8dffff45bfa2938f128f599dbf16eb11d880 (src/bancorprotocol/BancorFormula.sol#1156)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1155)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1157)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1157)
	- res += xi * 0x053a044ebd984351493e1786af38d39a0800000000 (src/bancorprotocol/BancorFormula.sol#1158)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1157)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1159)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1159)
	- res += xi * 0x0d86dae2a4cc0f47633a544479735869b487b59c40 (src/bancorprotocol/BancorFormula.sol#1160)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1159)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1161)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1161)
	- res += xi * 0x231000000000000000000000000000000000000000 (src/bancorprotocol/BancorFormula.sol#1162)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1161)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1163)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1163)
	- res += xi * 0x5b0485a76f6646c2039db1507cdd51b08649680822 (src/bancorprotocol/BancorFormula.sol#1164)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1163)
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1165)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) performs a multiplication on the result of a division:
	- xi = (xi * _x) / FIXED_1 (src/bancorprotocol/BancorFormula.sol#1165)
	- res += xi * 0xec983c46c49545bc17efa6b5b0055e242200000000 (src/bancorprotocol/BancorFormula.sol#1166)
BancorFormula.accurateWeights(uint256,uint256) (src/bancorprotocol/BancorFormula.sol#1211-1220) performs a multiplication on the result of a division:
	- _a /= c (src/bancorprotocol/BancorFormula.sol#1214)
	- x = roundDiv(_a * MAX_WEIGHT,_a + _b) (src/bancorprotocol/BancorFormula.sol#1217)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#divide-before-multiply
INFO:Detectors:
BancorFormula.saleTargetAmount(uint256,uint256,uint32,uint256) (src/bancorprotocol/BancorFormula.sol#363-391) uses a dangerous strict equality:
	- _amount == _supply (src/bancorprotocol/BancorFormula.sol#379)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#dangerous-strict-equalities
INFO:Detectors:
BancorFormula.optimalExp(uint256).y (src/bancorprotocol/BancorFormula.sol#906) is a local variable never initialized
BancorFormula.optimalLog(uint256).y (src/bancorprotocol/BancorFormula.sol#834) is a local variable never initialized
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#uninitialized-local-variables
INFO:Detectors:
Address._revert(bytes,string) (lib/openzeppelin-contracts/contracts/utils/Address.sol#231-243) uses assembly
	- INLINE ASM (lib/openzeppelin-contracts/contracts/utils/Address.sol#236-239)
ERC1363._checkOnTransferReceived(address,address,uint256,bytes) (src/erc1363-payable-token/ERC1363.sol#119-140) uses assembly
	- INLINE ASM (src/erc1363-payable-token/ERC1363.sol#135-137)
ERC1363._checkOnApprovalReceived(address,uint256,bytes) (src/erc1363-payable-token/ERC1363.sol#150-171) uses assembly
	- INLINE ASM (src/erc1363-payable-token/ERC1363.sol#166-168)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#assembly-usage
INFO:Detectors:
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
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#different-pragma-directives-are-used
INFO:Detectors:
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
INFO:Detectors:
Pragma version^0.8.0 (lib/openzeppelin-contracts/contracts/access/Ownable.sol#4) allows old versions
Pragma version^0.8.2 (lib/openzeppelin-contracts/contracts/proxy/utils/Initializable.sol#4) allows old versions
Pragma version^0.8.0 (lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol#4) allows old versions
Pragma version^0.8.0 (lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol#4) allows old versions
Pragma version^0.8.0 (lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol#4) allows old versions
Pragma version^0.8.1 (lib/openzeppelin-contracts/contracts/utils/Address.sol#4) allows old versions
Pragma version^0.8.0 (lib/openzeppelin-contracts/contracts/utils/Context.sol#4) allows old versions
Pragma version^0.8.0 (lib/openzeppelin-contracts/contracts/utils/introspection/ERC165.sol#4) allows old versions
Pragma version^0.8.0 (lib/openzeppelin-contracts/contracts/utils/introspection/IERC165.sol#4) allows old versions
Pragma version0.8.9 (src/ERC1363BondingCurveToken.sol#2) allows old versions
Pragma version0.8.9 (src/bancorprotocol/BancorFormula.sol#2) allows old versions
Pragma version0.8.9 (src/bancorprotocol/interfaces/IBancorFormula.sol#2) allows old versions
Pragma version^0.8.0 (src/erc1363-payable-token/ERC1363.sol#3) allows old versions
Pragma version^0.8.0 (src/erc1363-payable-token/IERC1363.sol#3) allows old versions
Pragma version^0.8.0 (src/erc1363-payable-token/IERC1363Receiver.sol#3) allows old versions
Pragma version^0.8.0 (src/erc1363-payable-token/IERC1363Spender.sol#3) allows old versions
solc-0.8.9 is not recommended for deployment
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#incorrect-versions-of-solidity
INFO:Detectors:
Low level call in Address.sendValue(address,uint256) (lib/openzeppelin-contracts/contracts/utils/Address.sol#64-69):
	- (success) = recipient.call{value: amount}() (lib/openzeppelin-contracts/contracts/utils/Address.sol#67)
Low level call in Address.functionCallWithValue(address,bytes,uint256,string) (lib/openzeppelin-contracts/contracts/utils/Address.sol#128-137):
	- (success,returndata) = target.call{value: value}(data) (lib/openzeppelin-contracts/contracts/utils/Address.sol#135)
Low level call in Address.functionStaticCall(address,bytes,string) (lib/openzeppelin-contracts/contracts/utils/Address.sol#155-162):
	- (success,returndata) = target.staticcall(data) (lib/openzeppelin-contracts/contracts/utils/Address.sol#160)
Low level call in Address.functionDelegateCall(address,bytes,string) (lib/openzeppelin-contracts/contracts/utils/Address.sol#180-187):
	- (success,returndata) = target.delegatecall(data) (lib/openzeppelin-contracts/contracts/utils/Address.sol#185)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#low-level-calls
INFO:Detectors:
ERC1363BondingCurveToken (src/ERC1363BondingCurveToken.sol#35-199) should inherit from IERC1363Receiver (src/erc1363-payable-token/IERC1363Receiver.sol#10-32)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#missing-inheritance
INFO:Detectors:
Function ERC1363BondingCurveToken._setGasPrice(uint256) (src/ERC1363BondingCurveToken.sol#143-146) is not in mixedCase
Parameter ERC1363BondingCurveToken._setGasPrice(uint256)._gasPrice (src/ERC1363BondingCurveToken.sol#143) is not in mixedCase
Variable ERC1363BondingCurveToken.RESERVE_RATION (src/ERC1363BondingCurveToken.sol#46) is not in mixedCase
Parameter BancorFormula.purchaseTargetAmount(uint256,uint256,uint32,uint256)._supply (src/bancorprotocol/BancorFormula.sol#324) is not in mixedCase
Parameter BancorFormula.purchaseTargetAmount(uint256,uint256,uint32,uint256)._reserveBalance (src/bancorprotocol/BancorFormula.sol#324) is not in mixedCase
Parameter BancorFormula.purchaseTargetAmount(uint256,uint256,uint32,uint256)._reserveWeight (src/bancorprotocol/BancorFormula.sol#324) is not in mixedCase
Parameter BancorFormula.purchaseTargetAmount(uint256,uint256,uint32,uint256)._amount (src/bancorprotocol/BancorFormula.sol#324) is not in mixedCase
Parameter BancorFormula.saleTargetAmount(uint256,uint256,uint32,uint256)._supply (src/bancorprotocol/BancorFormula.sol#363) is not in mixedCase
Parameter BancorFormula.saleTargetAmount(uint256,uint256,uint32,uint256)._reserveBalance (src/bancorprotocol/BancorFormula.sol#363) is not in mixedCase
Parameter BancorFormula.saleTargetAmount(uint256,uint256,uint32,uint256)._reserveWeight (src/bancorprotocol/BancorFormula.sol#363) is not in mixedCase
Parameter BancorFormula.saleTargetAmount(uint256,uint256,uint32,uint256)._amount (src/bancorprotocol/BancorFormula.sol#363) is not in mixedCase
Parameter BancorFormula.crossReserveTargetAmount(uint256,uint32,uint256,uint32,uint256)._sourceReserveBalance (src/bancorprotocol/BancorFormula.sol#409) is not in mixedCase
Parameter BancorFormula.crossReserveTargetAmount(uint256,uint32,uint256,uint32,uint256)._sourceReserveWeight (src/bancorprotocol/BancorFormula.sol#410) is not in mixedCase
Parameter BancorFormula.crossReserveTargetAmount(uint256,uint32,uint256,uint32,uint256)._targetReserveBalance (src/bancorprotocol/BancorFormula.sol#411) is not in mixedCase
Parameter BancorFormula.crossReserveTargetAmount(uint256,uint32,uint256,uint32,uint256)._targetReserveWeight (src/bancorprotocol/BancorFormula.sol#412) is not in mixedCase
Parameter BancorFormula.crossReserveTargetAmount(uint256,uint32,uint256,uint32,uint256)._amount (src/bancorprotocol/BancorFormula.sol#413) is not in mixedCase
Parameter BancorFormula.fundCost(uint256,uint256,uint32,uint256)._supply (src/bancorprotocol/BancorFormula.sol#451) is not in mixedCase
Parameter BancorFormula.fundCost(uint256,uint256,uint32,uint256)._reserveBalance (src/bancorprotocol/BancorFormula.sol#451) is not in mixedCase
Parameter BancorFormula.fundCost(uint256,uint256,uint32,uint256)._reserveRatio (src/bancorprotocol/BancorFormula.sol#451) is not in mixedCase
Parameter BancorFormula.fundCost(uint256,uint256,uint32,uint256)._amount (src/bancorprotocol/BancorFormula.sol#451) is not in mixedCase
Parameter BancorFormula.fundSupplyAmount(uint256,uint256,uint32,uint256)._supply (src/bancorprotocol/BancorFormula.sol#490) is not in mixedCase
Parameter BancorFormula.fundSupplyAmount(uint256,uint256,uint32,uint256)._reserveBalance (src/bancorprotocol/BancorFormula.sol#490) is not in mixedCase
Parameter BancorFormula.fundSupplyAmount(uint256,uint256,uint32,uint256)._reserveRatio (src/bancorprotocol/BancorFormula.sol#490) is not in mixedCase
Parameter BancorFormula.fundSupplyAmount(uint256,uint256,uint32,uint256)._amount (src/bancorprotocol/BancorFormula.sol#490) is not in mixedCase
Parameter BancorFormula.liquidateReserveAmount(uint256,uint256,uint32,uint256)._supply (src/bancorprotocol/BancorFormula.sol#529) is not in mixedCase
Parameter BancorFormula.liquidateReserveAmount(uint256,uint256,uint32,uint256)._reserveBalance (src/bancorprotocol/BancorFormula.sol#529) is not in mixedCase
Parameter BancorFormula.liquidateReserveAmount(uint256,uint256,uint32,uint256)._reserveRatio (src/bancorprotocol/BancorFormula.sol#529) is not in mixedCase
Parameter BancorFormula.liquidateReserveAmount(uint256,uint256,uint32,uint256)._amount (src/bancorprotocol/BancorFormula.sol#529) is not in mixedCase
Parameter BancorFormula.balancedWeights(uint256,uint256,uint256,uint256,uint256)._primaryReserveStakedBalance (src/bancorprotocol/BancorFormula.sol#599) is not in mixedCase
Parameter BancorFormula.balancedWeights(uint256,uint256,uint256,uint256,uint256)._primaryReserveBalance (src/bancorprotocol/BancorFormula.sol#600) is not in mixedCase
Parameter BancorFormula.balancedWeights(uint256,uint256,uint256,uint256,uint256)._secondaryReserveBalance (src/bancorprotocol/BancorFormula.sol#601) is not in mixedCase
Parameter BancorFormula.balancedWeights(uint256,uint256,uint256,uint256,uint256)._reserveRateNumerator (src/bancorprotocol/BancorFormula.sol#602) is not in mixedCase
Parameter BancorFormula.balancedWeights(uint256,uint256,uint256,uint256,uint256)._reserveRateDenominator (src/bancorprotocol/BancorFormula.sol#603) is not in mixedCase
Parameter BancorFormula.power(uint256,uint256,uint32,uint32)._baseN (src/bancorprotocol/BancorFormula.sol#647) is not in mixedCase
Parameter BancorFormula.power(uint256,uint256,uint32,uint32)._baseD (src/bancorprotocol/BancorFormula.sol#647) is not in mixedCase
Parameter BancorFormula.power(uint256,uint256,uint32,uint32)._expN (src/bancorprotocol/BancorFormula.sol#647) is not in mixedCase
Parameter BancorFormula.power(uint256,uint256,uint32,uint32)._expD (src/bancorprotocol/BancorFormula.sol#647) is not in mixedCase
Parameter BancorFormula.floorLog2(uint256)._n (src/bancorprotocol/BancorFormula.sol#698) is not in mixedCase
Parameter BancorFormula.findPositionInMaxExpArray(uint256)._x (src/bancorprotocol/BancorFormula.sol#725) is not in mixedCase
Parameter BancorFormula.generalExp(uint256,uint8)._x (src/bancorprotocol/BancorFormula.sol#748) is not in mixedCase
Parameter BancorFormula.generalExp(uint256,uint8)._precision (src/bancorprotocol/BancorFormula.sol#748) is not in mixedCase
Parameter BancorFormula.lowerStake(uint256)._x (src/bancorprotocol/BancorFormula.sol#978) is not in mixedCase
Parameter BancorFormula.higherStake(uint256)._x (src/bancorprotocol/BancorFormula.sol#988) is not in mixedCase
Parameter BancorFormula.lambertPos1(uint256)._x (src/bancorprotocol/BancorFormula.sol#998) is not in mixedCase
Parameter BancorFormula.lambertPos2(uint256)._x (src/bancorprotocol/BancorFormula.sol#1074) is not in mixedCase
Parameter BancorFormula.lambertPos3(uint256)._x (src/bancorprotocol/BancorFormula.sol#1088) is not in mixedCase
Parameter BancorFormula.lambertNeg1(uint256)._x (src/bancorprotocol/BancorFormula.sol#1099) is not in mixedCase
Parameter BancorFormula.balancedWeightsByStake(uint256,uint256,uint256,uint256,bool)._hi (src/bancorprotocol/BancorFormula.sol#1174) is not in mixedCase
Parameter BancorFormula.balancedWeightsByStake(uint256,uint256,uint256,uint256,bool)._lo (src/bancorprotocol/BancorFormula.sol#1174) is not in mixedCase
Parameter BancorFormula.balancedWeightsByStake(uint256,uint256,uint256,uint256,bool)._tq (src/bancorprotocol/BancorFormula.sol#1174) is not in mixedCase
Parameter BancorFormula.balancedWeightsByStake(uint256,uint256,uint256,uint256,bool)._rp (src/bancorprotocol/BancorFormula.sol#1174) is not in mixedCase
Parameter BancorFormula.balancedWeightsByStake(uint256,uint256,uint256,uint256,bool)._lowerStake (src/bancorprotocol/BancorFormula.sol#1174) is not in mixedCase
Parameter BancorFormula.safeFactors(uint256,uint256)._a (src/bancorprotocol/BancorFormula.sol#1190) is not in mixedCase
Parameter BancorFormula.safeFactors(uint256,uint256)._b (src/bancorprotocol/BancorFormula.sol#1190) is not in mixedCase
Parameter BancorFormula.normalizedWeights(uint256,uint256)._a (src/bancorprotocol/BancorFormula.sol#1202) is not in mixedCase
Parameter BancorFormula.normalizedWeights(uint256,uint256)._b (src/bancorprotocol/BancorFormula.sol#1202) is not in mixedCase
Parameter BancorFormula.accurateWeights(uint256,uint256)._a (src/bancorprotocol/BancorFormula.sol#1211) is not in mixedCase
Parameter BancorFormula.accurateWeights(uint256,uint256)._b (src/bancorprotocol/BancorFormula.sol#1211) is not in mixedCase
Parameter BancorFormula.roundDiv(uint256,uint256)._n (src/bancorprotocol/BancorFormula.sol#1225) is not in mixedCase
Parameter BancorFormula.roundDiv(uint256,uint256)._d (src/bancorprotocol/BancorFormula.sol#1225) is not in mixedCase
Parameter BancorFormula.calculatePurchaseReturn(uint256,uint256,uint32,uint256)._supply (src/bancorprotocol/BancorFormula.sol#1232) is not in mixedCase
Parameter BancorFormula.calculatePurchaseReturn(uint256,uint256,uint32,uint256)._reserveBalance (src/bancorprotocol/BancorFormula.sol#1232) is not in mixedCase
Parameter BancorFormula.calculatePurchaseReturn(uint256,uint256,uint32,uint256)._reserveWeight (src/bancorprotocol/BancorFormula.sol#1232) is not in mixedCase
Parameter BancorFormula.calculatePurchaseReturn(uint256,uint256,uint32,uint256)._amount (src/bancorprotocol/BancorFormula.sol#1232) is not in mixedCase
Parameter BancorFormula.calculateSaleReturn(uint256,uint256,uint32,uint256)._supply (src/bancorprotocol/BancorFormula.sol#1243) is not in mixedCase
Parameter BancorFormula.calculateSaleReturn(uint256,uint256,uint32,uint256)._reserveBalance (src/bancorprotocol/BancorFormula.sol#1243) is not in mixedCase
Parameter BancorFormula.calculateSaleReturn(uint256,uint256,uint32,uint256)._reserveWeight (src/bancorprotocol/BancorFormula.sol#1243) is not in mixedCase
Parameter BancorFormula.calculateSaleReturn(uint256,uint256,uint32,uint256)._amount (src/bancorprotocol/BancorFormula.sol#1243) is not in mixedCase
Parameter BancorFormula.calculateCrossReserveReturn(uint256,uint32,uint256,uint32,uint256)._sourceReserveBalance (src/bancorprotocol/BancorFormula.sol#1255) is not in mixedCase
Parameter BancorFormula.calculateCrossReserveReturn(uint256,uint32,uint256,uint32,uint256)._sourceReserveWeight (src/bancorprotocol/BancorFormula.sol#1256) is not in mixedCase
Parameter BancorFormula.calculateCrossReserveReturn(uint256,uint32,uint256,uint32,uint256)._targetReserveBalance (src/bancorprotocol/BancorFormula.sol#1257) is not in mixedCase
Parameter BancorFormula.calculateCrossReserveReturn(uint256,uint32,uint256,uint32,uint256)._targetReserveWeight (src/bancorprotocol/BancorFormula.sol#1258) is not in mixedCase
Parameter BancorFormula.calculateCrossReserveReturn(uint256,uint32,uint256,uint32,uint256)._amount (src/bancorprotocol/BancorFormula.sol#1259) is not in mixedCase
Parameter BancorFormula.calculateCrossConnectorReturn(uint256,uint32,uint256,uint32,uint256)._sourceReserveBalance (src/bancorprotocol/BancorFormula.sol#1270) is not in mixedCase
Parameter BancorFormula.calculateCrossConnectorReturn(uint256,uint32,uint256,uint32,uint256)._sourceReserveWeight (src/bancorprotocol/BancorFormula.sol#1271) is not in mixedCase
Parameter BancorFormula.calculateCrossConnectorReturn(uint256,uint32,uint256,uint32,uint256)._targetReserveBalance (src/bancorprotocol/BancorFormula.sol#1272) is not in mixedCase
Parameter BancorFormula.calculateCrossConnectorReturn(uint256,uint32,uint256,uint32,uint256)._targetReserveWeight (src/bancorprotocol/BancorFormula.sol#1273) is not in mixedCase
Parameter BancorFormula.calculateCrossConnectorReturn(uint256,uint32,uint256,uint32,uint256)._amount (src/bancorprotocol/BancorFormula.sol#1274) is not in mixedCase
Parameter BancorFormula.calculateFundCost(uint256,uint256,uint32,uint256)._supply (src/bancorprotocol/BancorFormula.sol#1284) is not in mixedCase
Parameter BancorFormula.calculateFundCost(uint256,uint256,uint32,uint256)._reserveBalance (src/bancorprotocol/BancorFormula.sol#1284) is not in mixedCase
Parameter BancorFormula.calculateFundCost(uint256,uint256,uint32,uint256)._reserveRatio (src/bancorprotocol/BancorFormula.sol#1284) is not in mixedCase
Parameter BancorFormula.calculateFundCost(uint256,uint256,uint32,uint256)._amount (src/bancorprotocol/BancorFormula.sol#1284) is not in mixedCase
Parameter BancorFormula.calculateLiquidateReturn(uint256,uint256,uint32,uint256)._supply (src/bancorprotocol/BancorFormula.sol#1295) is not in mixedCase
Parameter BancorFormula.calculateLiquidateReturn(uint256,uint256,uint32,uint256)._reserveBalance (src/bancorprotocol/BancorFormula.sol#1295) is not in mixedCase
Parameter BancorFormula.calculateLiquidateReturn(uint256,uint256,uint32,uint256)._reserveRatio (src/bancorprotocol/BancorFormula.sol#1295) is not in mixedCase
Parameter BancorFormula.calculateLiquidateReturn(uint256,uint256,uint32,uint256)._amount (src/bancorprotocol/BancorFormula.sol#1295) is not in mixedCase
Parameter BancorFormula.purchaseRate(uint256,uint256,uint32,uint256)._supply (src/bancorprotocol/BancorFormula.sol#1306) is not in mixedCase
Parameter BancorFormula.purchaseRate(uint256,uint256,uint32,uint256)._reserveBalance (src/bancorprotocol/BancorFormula.sol#1306) is not in mixedCase
Parameter BancorFormula.purchaseRate(uint256,uint256,uint32,uint256)._reserveWeight (src/bancorprotocol/BancorFormula.sol#1306) is not in mixedCase
Parameter BancorFormula.purchaseRate(uint256,uint256,uint32,uint256)._amount (src/bancorprotocol/BancorFormula.sol#1306) is not in mixedCase
Parameter BancorFormula.saleRate(uint256,uint256,uint32,uint256)._supply (src/bancorprotocol/BancorFormula.sol#1317) is not in mixedCase
Parameter BancorFormula.saleRate(uint256,uint256,uint32,uint256)._reserveBalance (src/bancorprotocol/BancorFormula.sol#1317) is not in mixedCase
Parameter BancorFormula.saleRate(uint256,uint256,uint32,uint256)._reserveWeight (src/bancorprotocol/BancorFormula.sol#1317) is not in mixedCase
Parameter BancorFormula.saleRate(uint256,uint256,uint32,uint256)._amount (src/bancorprotocol/BancorFormula.sol#1317) is not in mixedCase
Parameter BancorFormula.crossReserveRate(uint256,uint32,uint256,uint32,uint256)._sourceReserveBalance (src/bancorprotocol/BancorFormula.sol#1329) is not in mixedCase
Parameter BancorFormula.crossReserveRate(uint256,uint32,uint256,uint32,uint256)._sourceReserveWeight (src/bancorprotocol/BancorFormula.sol#1330) is not in mixedCase
Parameter BancorFormula.crossReserveRate(uint256,uint32,uint256,uint32,uint256)._targetReserveBalance (src/bancorprotocol/BancorFormula.sol#1331) is not in mixedCase
Parameter BancorFormula.crossReserveRate(uint256,uint32,uint256,uint32,uint256)._targetReserveWeight (src/bancorprotocol/BancorFormula.sol#1332) is not in mixedCase
Parameter BancorFormula.crossReserveRate(uint256,uint32,uint256,uint32,uint256)._amount (src/bancorprotocol/BancorFormula.sol#1333) is not in mixedCase
Parameter BancorFormula.liquidateRate(uint256,uint256,uint32,uint256)._supply (src/bancorprotocol/BancorFormula.sol#1343) is not in mixedCase
Parameter BancorFormula.liquidateRate(uint256,uint256,uint32,uint256)._reserveBalance (src/bancorprotocol/BancorFormula.sol#1343) is not in mixedCase
Parameter BancorFormula.liquidateRate(uint256,uint256,uint32,uint256)._reserveRatio (src/bancorprotocol/BancorFormula.sol#1343) is not in mixedCase
Parameter BancorFormula.liquidateRate(uint256,uint256,uint32,uint256)._amount (src/bancorprotocol/BancorFormula.sol#1343) is not in mixedCase
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#conformance-to-solidity-naming-conventions
INFO:Detectors:
Variable BancorFormula.LAMBERT_POS2_MAXVAL (src/bancorprotocol/BancorFormula.sol#28) is too similar to BancorFormula.LAMBERT_POS3_MAXVAL (src/bancorprotocol/BancorFormula.sol#29)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#variable-names-too-similar
INFO:Detectors:
BancorFormula.generalExp(uint256,uint8) (src/bancorprotocol/BancorFormula.sol#748-818) uses literals with too many digits:
	- res += xi * 0x3442c4e6074a82f1797f72ac0000000 (src/bancorprotocol/BancorFormula.sol#753)
BancorFormula.generalExp(uint256,uint8) (src/bancorprotocol/BancorFormula.sol#748-818) uses literals with too many digits:
	- res += xi * 0x116b96f757c380fb287fd0e40000000 (src/bancorprotocol/BancorFormula.sol#755)
BancorFormula.generalExp(uint256,uint8) (src/bancorprotocol/BancorFormula.sol#748-818) uses literals with too many digits:
	- res += xi * 0x045ae5bdd5f0e03eca1ff4390000000 (src/bancorprotocol/BancorFormula.sol#757)
BancorFormula.generalExp(uint256,uint8) (src/bancorprotocol/BancorFormula.sol#748-818) uses literals with too many digits:
	- res += xi * 0x00defabf91302cd95b9ffda50000000 (src/bancorprotocol/BancorFormula.sol#759)
BancorFormula.generalExp(uint256,uint8) (src/bancorprotocol/BancorFormula.sol#748-818) uses literals with too many digits:
	- res += xi * 0x002529ca9832b22439efff9b8000000 (src/bancorprotocol/BancorFormula.sol#761)
BancorFormula.generalExp(uint256,uint8) (src/bancorprotocol/BancorFormula.sol#748-818) uses literals with too many digits:
	- res += xi * 0x00054f1cf12bd04e516b6da88000000 (src/bancorprotocol/BancorFormula.sol#763)
BancorFormula.generalExp(uint256,uint8) (src/bancorprotocol/BancorFormula.sol#748-818) uses literals with too many digits:
	- res += xi * 0x0000a9e39e257a09ca2d6db51000000 (src/bancorprotocol/BancorFormula.sol#765)
BancorFormula.generalExp(uint256,uint8) (src/bancorprotocol/BancorFormula.sol#748-818) uses literals with too many digits:
	- res += xi * 0x000012e066e7b839fa050c309000000 (src/bancorprotocol/BancorFormula.sol#767)
BancorFormula.generalExp(uint256,uint8) (src/bancorprotocol/BancorFormula.sol#748-818) uses literals with too many digits:
	- res += xi * 0x000001e33d7d926c329a1ad1a800000 (src/bancorprotocol/BancorFormula.sol#769)
BancorFormula.generalExp(uint256,uint8) (src/bancorprotocol/BancorFormula.sol#748-818) uses literals with too many digits:
	- res += xi * 0x0000002bee513bdb4a6b19b5f800000 (src/bancorprotocol/BancorFormula.sol#771)
BancorFormula.generalExp(uint256,uint8) (src/bancorprotocol/BancorFormula.sol#748-818) uses literals with too many digits:
	- res += xi * 0x00000003a9316fa79b88eccf2a00000 (src/bancorprotocol/BancorFormula.sol#773)
BancorFormula.generalExp(uint256,uint8) (src/bancorprotocol/BancorFormula.sol#748-818) uses literals with too many digits:
	- res += xi * 0x0000000048177ebe1fa812375200000 (src/bancorprotocol/BancorFormula.sol#775)
BancorFormula.generalExp(uint256,uint8) (src/bancorprotocol/BancorFormula.sol#748-818) uses literals with too many digits:
	- res += xi * 0x0000000005263fe90242dcbacf00000 (src/bancorprotocol/BancorFormula.sol#777)
BancorFormula.generalExp(uint256,uint8) (src/bancorprotocol/BancorFormula.sol#748-818) uses literals with too many digits:
	- res += xi * 0x000000000057e22099c030d94100000 (src/bancorprotocol/BancorFormula.sol#779)
BancorFormula.generalExp(uint256,uint8) (src/bancorprotocol/BancorFormula.sol#748-818) uses literals with too many digits:
	- res += xi * 0x0000000000057e22099c030d9410000 (src/bancorprotocol/BancorFormula.sol#781)
BancorFormula.generalExp(uint256,uint8) (src/bancorprotocol/BancorFormula.sol#748-818) uses literals with too many digits:
	- res += xi * 0x00000000000052b6b54569976310000 (src/bancorprotocol/BancorFormula.sol#783)
BancorFormula.generalExp(uint256,uint8) (src/bancorprotocol/BancorFormula.sol#748-818) uses literals with too many digits:
	- res += xi * 0x00000000000004985f67696bf748000 (src/bancorprotocol/BancorFormula.sol#785)
BancorFormula.generalExp(uint256,uint8) (src/bancorprotocol/BancorFormula.sol#748-818) uses literals with too many digits:
	- res += xi * 0x000000000000003dea12ea99e498000 (src/bancorprotocol/BancorFormula.sol#787)
BancorFormula.generalExp(uint256,uint8) (src/bancorprotocol/BancorFormula.sol#748-818) uses literals with too many digits:
	- res += xi * 0x00000000000000031880f2214b6e000 (src/bancorprotocol/BancorFormula.sol#789)
BancorFormula.generalExp(uint256,uint8) (src/bancorprotocol/BancorFormula.sol#748-818) uses literals with too many digits:
	- res += xi * 0x000000000000000025bcff56eb36000 (src/bancorprotocol/BancorFormula.sol#791)
BancorFormula.generalExp(uint256,uint8) (src/bancorprotocol/BancorFormula.sol#748-818) uses literals with too many digits:
	- res += xi * 0x000000000000000001b722e10ab1000 (src/bancorprotocol/BancorFormula.sol#793)
BancorFormula.generalExp(uint256,uint8) (src/bancorprotocol/BancorFormula.sol#748-818) uses literals with too many digits:
	- res += xi * 0x0000000000000000001317c70077000 (src/bancorprotocol/BancorFormula.sol#795)
BancorFormula.generalExp(uint256,uint8) (src/bancorprotocol/BancorFormula.sol#748-818) uses literals with too many digits:
	- res += xi * 0x00000000000000000000cba84aafa00 (src/bancorprotocol/BancorFormula.sol#797)
BancorFormula.generalExp(uint256,uint8) (src/bancorprotocol/BancorFormula.sol#748-818) uses literals with too many digits:
	- res += xi * 0x00000000000000000000082573a0a00 (src/bancorprotocol/BancorFormula.sol#799)
BancorFormula.generalExp(uint256,uint8) (src/bancorprotocol/BancorFormula.sol#748-818) uses literals with too many digits:
	- res += xi * 0x00000000000000000000005035ad900 (src/bancorprotocol/BancorFormula.sol#801)
BancorFormula.generalExp(uint256,uint8) (src/bancorprotocol/BancorFormula.sol#748-818) uses literals with too many digits:
	- res += xi * 0x000000000000000000000002f881b00 (src/bancorprotocol/BancorFormula.sol#803)
BancorFormula.generalExp(uint256,uint8) (src/bancorprotocol/BancorFormula.sol#748-818) uses literals with too many digits:
	- res += xi * 0x0000000000000000000000001b29340 (src/bancorprotocol/BancorFormula.sol#805)
BancorFormula.generalExp(uint256,uint8) (src/bancorprotocol/BancorFormula.sol#748-818) uses literals with too many digits:
	- res += xi * 0x00000000000000000000000000efc40 (src/bancorprotocol/BancorFormula.sol#807)
BancorFormula.generalExp(uint256,uint8) (src/bancorprotocol/BancorFormula.sol#748-818) uses literals with too many digits:
	- res += xi * 0x0000000000000000000000000007fe0 (src/bancorprotocol/BancorFormula.sol#809)
BancorFormula.generalExp(uint256,uint8) (src/bancorprotocol/BancorFormula.sol#748-818) uses literals with too many digits:
	- res += xi * 0x0000000000000000000000000000420 (src/bancorprotocol/BancorFormula.sol#811)
BancorFormula.generalExp(uint256,uint8) (src/bancorprotocol/BancorFormula.sol#748-818) uses literals with too many digits:
	- res += xi * 0x0000000000000000000000000000021 (src/bancorprotocol/BancorFormula.sol#813)
BancorFormula.generalExp(uint256,uint8) (src/bancorprotocol/BancorFormula.sol#748-818) uses literals with too many digits:
	- res += xi * 0x0000000000000000000000000000001 (src/bancorprotocol/BancorFormula.sol#815)
BancorFormula.generalExp(uint256,uint8) (src/bancorprotocol/BancorFormula.sol#748-818) uses literals with too many digits:
	- res / 0x688589cc0e9505e2f2fee5580000000 + _x + (ONE << _precision) (src/bancorprotocol/BancorFormula.sol#817)
BancorFormula.optimalLog(uint256) (src/bancorprotocol/BancorFormula.sol#831-890) uses literals with too many digits:
	- res += 0x40000000000000000000000000000000 (src/bancorprotocol/BancorFormula.sol#839)
BancorFormula.optimalLog(uint256) (src/bancorprotocol/BancorFormula.sol#831-890) uses literals with too many digits:
	- res += 0x20000000000000000000000000000000 (src/bancorprotocol/BancorFormula.sol#843)
BancorFormula.optimalLog(uint256) (src/bancorprotocol/BancorFormula.sol#831-890) uses literals with too many digits:
	- res += 0x10000000000000000000000000000000 (src/bancorprotocol/BancorFormula.sol#847)
BancorFormula.optimalLog(uint256) (src/bancorprotocol/BancorFormula.sol#831-890) uses literals with too many digits:
	- res += 0x08000000000000000000000000000000 (src/bancorprotocol/BancorFormula.sol#851)
BancorFormula.optimalLog(uint256) (src/bancorprotocol/BancorFormula.sol#831-890) uses literals with too many digits:
	- res += 0x04000000000000000000000000000000 (src/bancorprotocol/BancorFormula.sol#855)
BancorFormula.optimalLog(uint256) (src/bancorprotocol/BancorFormula.sol#831-890) uses literals with too many digits:
	- res += 0x02000000000000000000000000000000 (src/bancorprotocol/BancorFormula.sol#859)
BancorFormula.optimalLog(uint256) (src/bancorprotocol/BancorFormula.sol#831-890) uses literals with too many digits:
	- res += 0x01000000000000000000000000000000 (src/bancorprotocol/BancorFormula.sol#863)
BancorFormula.optimalLog(uint256) (src/bancorprotocol/BancorFormula.sol#831-890) uses literals with too many digits:
	- res += 0x00800000000000000000000000000000 (src/bancorprotocol/BancorFormula.sol#867)
BancorFormula.optimalLog(uint256) (src/bancorprotocol/BancorFormula.sol#831-890) uses literals with too many digits:
	- res += (z * (0x100000000000000000000000000000000 - y)) / 0x100000000000000000000000000000000 (src/bancorprotocol/BancorFormula.sol#873)
BancorFormula.optimalLog(uint256) (src/bancorprotocol/BancorFormula.sol#831-890) uses literals with too many digits:
	- res += (z * (0x0aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa - y)) / 0x200000000000000000000000000000000 (src/bancorprotocol/BancorFormula.sol#875)
BancorFormula.optimalLog(uint256) (src/bancorprotocol/BancorFormula.sol#831-890) uses literals with too many digits:
	- res += (z * (0x099999999999999999999999999999999 - y)) / 0x300000000000000000000000000000000 (src/bancorprotocol/BancorFormula.sol#877)
BancorFormula.optimalLog(uint256) (src/bancorprotocol/BancorFormula.sol#831-890) uses literals with too many digits:
	- res += (z * (0x092492492492492492492492492492492 - y)) / 0x400000000000000000000000000000000 (src/bancorprotocol/BancorFormula.sol#879)
BancorFormula.optimalLog(uint256) (src/bancorprotocol/BancorFormula.sol#831-890) uses literals with too many digits:
	- res += (z * (0x08e38e38e38e38e38e38e38e38e38e38e - y)) / 0x500000000000000000000000000000000 (src/bancorprotocol/BancorFormula.sol#881)
BancorFormula.optimalLog(uint256) (src/bancorprotocol/BancorFormula.sol#831-890) uses literals with too many digits:
	- res += (z * (0x08ba2e8ba2e8ba2e8ba2e8ba2e8ba2e8b - y)) / 0x600000000000000000000000000000000 (src/bancorprotocol/BancorFormula.sol#883)
BancorFormula.optimalLog(uint256) (src/bancorprotocol/BancorFormula.sol#831-890) uses literals with too many digits:
	- res += (z * (0x089d89d89d89d89d89d89d89d89d89d89 - y)) / 0x700000000000000000000000000000000 (src/bancorprotocol/BancorFormula.sol#885)
BancorFormula.optimalLog(uint256) (src/bancorprotocol/BancorFormula.sol#831-890) uses literals with too many digits:
	- res += (z * (0x088888888888888888888888888888888 - y)) / 0x800000000000000000000000000000000 (src/bancorprotocol/BancorFormula.sol#887)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) uses literals with too many digits:
	- z = y = x % 0x10000000000000000000000000000000 (src/bancorprotocol/BancorFormula.sol#909)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) uses literals with too many digits:
	- res += z * 0x00000618fee9f800 (src/bancorprotocol/BancorFormula.sol#925)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) uses literals with too many digits:
	- res += z * 0x0000009c197dcc00 (src/bancorprotocol/BancorFormula.sol#927)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) uses literals with too many digits:
	- res += z * 0x0000000e30dce400 (src/bancorprotocol/BancorFormula.sol#929)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) uses literals with too many digits:
	- res += z * 0x000000012ebd1300 (src/bancorprotocol/BancorFormula.sol#931)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) uses literals with too many digits:
	- res += z * 0x0000000017499f00 (src/bancorprotocol/BancorFormula.sol#933)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) uses literals with too many digits:
	- res += z * 0x0000000001a9d480 (src/bancorprotocol/BancorFormula.sol#935)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) uses literals with too many digits:
	- res += z * 0x00000000001c6380 (src/bancorprotocol/BancorFormula.sol#937)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) uses literals with too many digits:
	- res += z * 0x000000000001c638 (src/bancorprotocol/BancorFormula.sol#939)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) uses literals with too many digits:
	- res += z * 0x0000000000001ab8 (src/bancorprotocol/BancorFormula.sol#941)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) uses literals with too many digits:
	- res += z * 0x000000000000017c (src/bancorprotocol/BancorFormula.sol#943)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) uses literals with too many digits:
	- res += z * 0x0000000000000014 (src/bancorprotocol/BancorFormula.sol#945)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) uses literals with too many digits:
	- res += z * 0x0000000000000001 (src/bancorprotocol/BancorFormula.sol#947)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) uses literals with too many digits:
	- (x & 0x010000000000000000000000000000000) != 0 (src/bancorprotocol/BancorFormula.sol#950)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) uses literals with too many digits:
	- (x & 0x020000000000000000000000000000000) != 0 (src/bancorprotocol/BancorFormula.sol#953)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) uses literals with too many digits:
	- (x & 0x040000000000000000000000000000000) != 0 (src/bancorprotocol/BancorFormula.sol#956)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) uses literals with too many digits:
	- (x & 0x080000000000000000000000000000000) != 0 (src/bancorprotocol/BancorFormula.sol#959)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) uses literals with too many digits:
	- (x & 0x100000000000000000000000000000000) != 0 (src/bancorprotocol/BancorFormula.sol#962)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) uses literals with too many digits:
	- (x & 0x200000000000000000000000000000000) != 0 (src/bancorprotocol/BancorFormula.sol#965)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) uses literals with too many digits:
	- (x & 0x400000000000000000000000000000000) != 0 (src/bancorprotocol/BancorFormula.sol#968)
BancorFormula.optimalExp(uint256) (src/bancorprotocol/BancorFormula.sol#903-973) uses literals with too many digits:
	- res = (res * 0x0002bf84208204f5977f9a8cf01fdc307) / 0x0000003c6ab775dd0b95b4cbee7e65d11 (src/bancorprotocol/BancorFormula.sol#969)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) uses literals with too many digits:
	- res = (FIXED_1 - _x) * 0xde1bc4d19efcac82445da75b00000000 (src/bancorprotocol/BancorFormula.sol#1000)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) uses literals with too many digits:
	- res += xi * 0x00000000014d29a73a6e7b02c3668c7b0880000000 (src/bancorprotocol/BancorFormula.sol#1003)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) uses literals with too many digits:
	- res -= xi * 0x0000000002504a0cd9a7f7215b60f9be4800000000 (src/bancorprotocol/BancorFormula.sol#1005)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) uses literals with too many digits:
	- res += xi * 0x000000000484d0a1191c0ead267967c7a4a0000000 (src/bancorprotocol/BancorFormula.sol#1007)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) uses literals with too many digits:
	- res -= xi * 0x00000000095ec580d7e8427a4baf26a90a00000000 (src/bancorprotocol/BancorFormula.sol#1009)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) uses literals with too many digits:
	- res += xi * 0x000000001440b0be1615a47dba6e5b3b1f10000000 (src/bancorprotocol/BancorFormula.sol#1011)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) uses literals with too many digits:
	- res -= xi * 0x000000002d207601f46a99b4112418400000000000 (src/bancorprotocol/BancorFormula.sol#1013)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) uses literals with too many digits:
	- res += xi * 0x0000000066ebaac4c37c622dd8288a7eb1b2000000 (src/bancorprotocol/BancorFormula.sol#1015)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) uses literals with too many digits:
	- res -= xi * 0x00000000ef17240135f7dbd43a1ba10cf200000000 (src/bancorprotocol/BancorFormula.sol#1017)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) uses literals with too many digits:
	- res += xi * 0x0000000233c33c676a5eb2416094a87b3657000000 (src/bancorprotocol/BancorFormula.sol#1019)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) uses literals with too many digits:
	- res -= xi * 0x0000000541cde48bc0254bed49a9f8700000000000 (src/bancorprotocol/BancorFormula.sol#1021)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) uses literals with too many digits:
	- res += xi * 0x0000000cae1fad2cdd4d4cb8d73abca0d19a400000 (src/bancorprotocol/BancorFormula.sol#1023)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) uses literals with too many digits:
	- res -= xi * 0x0000001edb2aa2f760d15c41ceedba956400000000 (src/bancorprotocol/BancorFormula.sol#1025)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) uses literals with too many digits:
	- res += xi * 0x0000004ba8d20d2dabd386c9529659841a2e200000 (src/bancorprotocol/BancorFormula.sol#1027)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) uses literals with too many digits:
	- res -= xi * 0x000000bac08546b867cdaa20000000000000000000 (src/bancorprotocol/BancorFormula.sol#1029)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) uses literals with too many digits:
	- res += xi * 0x000001cfa8e70c03625b9db76c8ebf5bbf24820000 (src/bancorprotocol/BancorFormula.sol#1031)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) uses literals with too many digits:
	- res -= xi * 0x000004851d99f82060df265f3309b26f8200000000 (src/bancorprotocol/BancorFormula.sol#1033)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) uses literals with too many digits:
	- res += xi * 0x00000b550d19b129d270c44f6f55f027723cbb0000 (src/bancorprotocol/BancorFormula.sol#1035)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) uses literals with too many digits:
	- res -= xi * 0x00001c877dadc761dc272deb65d4b0000000000000 (src/bancorprotocol/BancorFormula.sol#1037)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) uses literals with too many digits:
	- res -= xi * 0x0000b6ca8268b9d810fedf6695ef2f8a6c00000000 (src/bancorprotocol/BancorFormula.sol#1041)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) uses literals with too many digits:
	- res -= xi * 0x0004a1c37bd9f85fd9c6c780000000000000000000 (src/bancorprotocol/BancorFormula.sol#1045)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) uses literals with too many digits:
	- res -= xi * 0x001e5c7c32a9f6c70ab2cb59d9225764d400000000 (src/bancorprotocol/BancorFormula.sol#1049)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) uses literals with too many digits:
	- res -= xi * 0x00c8c8f66db1fced378ee50e536000000000000000 (src/bancorprotocol/BancorFormula.sol#1053)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) uses literals with too many digits:
	- res -= xi * 0x053a044ebd984351493e1786af38d39a0800000000 (src/bancorprotocol/BancorFormula.sol#1057)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) uses literals with too many digits:
	- res -= xi * 0x231000000000000000000000000000000000000000 (src/bancorprotocol/BancorFormula.sol#1061)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) uses literals with too many digits:
	- res -= xi * 0xec983c46c49545bc17efa6b5b0055e242200000000 (src/bancorprotocol/BancorFormula.sol#1065)
BancorFormula.lambertPos1(uint256) (src/bancorprotocol/BancorFormula.sol#998-1068) uses literals with too many digits:
	- res / 0xde1bc4d19efcac82445da75b00000000 (src/bancorprotocol/BancorFormula.sol#1067)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) uses literals with too many digits:
	- res += xi * 0x00000000014d29a73a6e7b02c3668c7b0880000000 (src/bancorprotocol/BancorFormula.sol#1104)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) uses literals with too many digits:
	- res += xi * 0x0000000002504a0cd9a7f7215b60f9be4800000000 (src/bancorprotocol/BancorFormula.sol#1106)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) uses literals with too many digits:
	- res += xi * 0x000000000484d0a1191c0ead267967c7a4a0000000 (src/bancorprotocol/BancorFormula.sol#1108)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) uses literals with too many digits:
	- res += xi * 0x00000000095ec580d7e8427a4baf26a90a00000000 (src/bancorprotocol/BancorFormula.sol#1110)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) uses literals with too many digits:
	- res += xi * 0x000000001440b0be1615a47dba6e5b3b1f10000000 (src/bancorprotocol/BancorFormula.sol#1112)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) uses literals with too many digits:
	- res += xi * 0x000000002d207601f46a99b4112418400000000000 (src/bancorprotocol/BancorFormula.sol#1114)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) uses literals with too many digits:
	- res += xi * 0x0000000066ebaac4c37c622dd8288a7eb1b2000000 (src/bancorprotocol/BancorFormula.sol#1116)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) uses literals with too many digits:
	- res += xi * 0x00000000ef17240135f7dbd43a1ba10cf200000000 (src/bancorprotocol/BancorFormula.sol#1118)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) uses literals with too many digits:
	- res += xi * 0x0000000233c33c676a5eb2416094a87b3657000000 (src/bancorprotocol/BancorFormula.sol#1120)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) uses literals with too many digits:
	- res += xi * 0x0000000541cde48bc0254bed49a9f8700000000000 (src/bancorprotocol/BancorFormula.sol#1122)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) uses literals with too many digits:
	- res += xi * 0x0000000cae1fad2cdd4d4cb8d73abca0d19a400000 (src/bancorprotocol/BancorFormula.sol#1124)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) uses literals with too many digits:
	- res += xi * 0x0000001edb2aa2f760d15c41ceedba956400000000 (src/bancorprotocol/BancorFormula.sol#1126)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) uses literals with too many digits:
	- res += xi * 0x0000004ba8d20d2dabd386c9529659841a2e200000 (src/bancorprotocol/BancorFormula.sol#1128)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) uses literals with too many digits:
	- res += xi * 0x000000bac08546b867cdaa20000000000000000000 (src/bancorprotocol/BancorFormula.sol#1130)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) uses literals with too many digits:
	- res += xi * 0x000001cfa8e70c03625b9db76c8ebf5bbf24820000 (src/bancorprotocol/BancorFormula.sol#1132)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) uses literals with too many digits:
	- res += xi * 0x000004851d99f82060df265f3309b26f8200000000 (src/bancorprotocol/BancorFormula.sol#1134)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) uses literals with too many digits:
	- res += xi * 0x00000b550d19b129d270c44f6f55f027723cbb0000 (src/bancorprotocol/BancorFormula.sol#1136)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) uses literals with too many digits:
	- res += xi * 0x00001c877dadc761dc272deb65d4b0000000000000 (src/bancorprotocol/BancorFormula.sol#1138)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) uses literals with too many digits:
	- res += xi * 0x0000b6ca8268b9d810fedf6695ef2f8a6c00000000 (src/bancorprotocol/BancorFormula.sol#1142)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) uses literals with too many digits:
	- res += xi * 0x0004a1c37bd9f85fd9c6c780000000000000000000 (src/bancorprotocol/BancorFormula.sol#1146)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) uses literals with too many digits:
	- res += xi * 0x001e5c7c32a9f6c70ab2cb59d9225764d400000000 (src/bancorprotocol/BancorFormula.sol#1150)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) uses literals with too many digits:
	- res += xi * 0x00c8c8f66db1fced378ee50e536000000000000000 (src/bancorprotocol/BancorFormula.sol#1154)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) uses literals with too many digits:
	- res += xi * 0x053a044ebd984351493e1786af38d39a0800000000 (src/bancorprotocol/BancorFormula.sol#1158)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) uses literals with too many digits:
	- res += xi * 0x231000000000000000000000000000000000000000 (src/bancorprotocol/BancorFormula.sol#1162)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) uses literals with too many digits:
	- res += xi * 0xec983c46c49545bc17efa6b5b0055e242200000000 (src/bancorprotocol/BancorFormula.sol#1166)
BancorFormula.lambertNeg1(uint256) (src/bancorprotocol/BancorFormula.sol#1099-1169) uses literals with too many digits:
	- res / 0xde1bc4d19efcac82445da75b00000000 + _x + FIXED_1 (src/bancorprotocol/BancorFormula.sol#1168)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#too-many-digits
INFO:Slither:src analyzed (39 contracts with 88 detectors), 532 result(s) found
