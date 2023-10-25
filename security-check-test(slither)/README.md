# References:

1.  test commands
* slither src --solc-remaps "$(tr '\n' ' ' < remappings.txt | xargs)" --exclude-dependencies &>coreFunctionsExcludeDependencies.md
* slither src/ERC1363BondingCurveToken.sol --solc-remaps "$(tr '\n' ' ' < remappings.txt | xargs)"
* slither src/SanctionToken.sol --solc-remaps "$(tr '\n' ' ' < remappings.txt | xargs)"
* slither src --solc-remaps "$(tr '\n' ' ' < remappings.txt | xargs)" --print human-summary
* slither src --solc-remaps "$(tr '\n' ' ' < remappings.txt | xargs)" --print contract-summary
* slither src --solc-remaps "$(tr '\n' ' ' < remappings.txt | xargs)" --print call-graph
* slither src --solc-remaps "$(tr '\n' ' ' < remappings.txt | xargs)" --print cfg (each function)
* slither src --solc-remaps "$(tr '\n' ' ' < remappings.txt | xargs)" --print function-summary
* slither src --solc-remaps "$(tr '\n' ' ' < remappings.txt | xargs)" --print vars-and-auth
* slither-check-erc src/SanctionToken.sol SanctionToken --solc-remaps "$(tr '\n' ' ' < remappings.txt | xargs)"


2.  other related references
    1. https://github.com/crytic/slither/blob/master/trophies.md
    2. https://github.com/crytic/slither/wiki/Printer-documentation other-printer
    3. https://www.youtube.com/watch?v=Dxex3b-eMq0


