C lexical analyzer written in Haskell
=====================================

Example
-------
    $ ghci
    Prelude > :load lex.hs
    *Main> lexemes "int x = 3; char c = 'x';\n\t\tprintf(\"%d=%c\", x, c);"
    ["int","x","=","3",";","char","c","=","'x'",";","printf","(","\"%d=%c\"",",","x",",","c",")",";"]

Fiec - Espol
