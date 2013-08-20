C lexical analyzer written in Haskell
=====================================

Example
-------
    $ ghci
    Prelude > :load lex.hs
    *Main> lexemes "int x = 3;\n\t\tprintf(xyz);"
    ["int","x","=","3",";","printf","(","xyz",")",";"]
