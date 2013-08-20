import Data.Char

-- Get the next alphanumeric chunk
lex_alpha :: [String] -> [String]
lex_alpha all@( alpha:[] )  = all
lex_alpha ( alpha:code:[] ) = if isAlphaNum (head code)
                              then lex_alpha [ alpha ++ [head code] , tail code ]
                              else alpha:code:[]
lex_alpha s = error "Wrong alphanum format"

-- Get the next integer chunk
lex_integer :: [String] -> [String]
lex_integer all@( integer:[] ) = all
lex_integer ( int:code:[] ) = if isNumber (head code)
                              then lex_integer [ int ++ [head code], tail code ]
                              else int:code:[]
lex_integer s = error "Wrong integer format"

-- Get the next string literal
lex_symbol :: [String] -> [String]
lex_symbol [] = [] 
lex_symbol ( symbol:code:[] ) = [symbol ++ [head code], tail code] 

-- Get the next space chunck
lex_space :: [String] -> [String]
lex_space all@( space:[] ) = all
lex_space ( space:code:[] ) = if isSpace (head code)
                              then lex_space [ space ++ [head code], tail code ]
                              else space:code:[]

lexemes :: String -> [String]
lexemes "" = []
lexemes all@(c:xs)
    | isAlpha c  = ( ( lex_alpha ("":all:[]) ) !! 0 ) : lexemes ( ( lex_alpha ("":all:[]) ) !! 1 )
    | isNumber c = ( ( lex_integer ("":all:[]) ) !! 0 ) : lexemes ( ( lex_integer ("":all:[]) ) !! 1 )
    | isSpace c  = lexemes  ( lex_space("":all:[]) !! 1 )
    | otherwise  = ( ( lex_symbol ("":all:[]) ) !! 0 ) : lexemes ( ( lex_symbol ("":all:[]) ) !! 1 )
