import Data.Char
import Data.List


let tokens_list = ["auto","break","case","char","const","continue","default","do","double","else","enum",
		  "extern","float","for","goto","if","int","long","register","return","short","signed",
		  "sizeof","static","struct","switch","typedef","union","unsigned","void","volatile","while"]
      
    
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

-- Get the next symbol
lex_symbol :: [String] -> [String]
lex_symbol [] = [] 
lex_symbol ( symbol:code:[] ) = [symbol ++ [head code], tail code] 

-- Get the next string literal
lex_string :: [String] -> [String]
lex_string all@( string:[] ) = all
lex_string ( string:(c1:c2:xs):[] ) = if string == "" && c1 == '"'
                                      then lex_string [ [c1] , c2:xs ]
                                      else if c1 /= '\\' && c2 == '"'
                                      then [ string ++ [c1,c2], xs]
                                      else lex_string [ string ++ [c1], c2:xs ]

-- Get the next character literal
lex_char :: [String] -> [String]
lex_char ( "":('\'':c:'\'':xs):[] ) = [ '\'':c:'\'':[], xs ]
lex_char s = error "Wrong character literal format"
    
-- Get the next space chunck 	
lex_space :: [String] -> [String]
lex_space all@( space:[] ) = all
lex_space ( space:code:[] ) = if isSpace (head code)
                              then lex_space [ space ++ [head code], tail code ]
                              else space:code:[]

lexemes :: String -> [String]
lexemes "" = []
lexemes all@(c:xs)
    | c == '"'   = ( ( lex_string ("":all:[]) ) !! 0 ) : lexemes ( ( lex_string ("":all:[]) ) !! 1 )
    | c == '\''  = ( ( lex_char ("":all:[]) ) !! 0 ) : lexemes ( ( lex_char ("":all:[]) ) !! 1 )
    | isAlpha c  = ( ( lex_alpha ("":all:[]) ) !! 0 ) : lexemes ( ( lex_alpha ("":all:[]) ) !! 1 )
    | isNumber c = ( ( lex_integer ("":all:[]) ) !! 0 ) : lexemes ( ( lex_integer ("":all:[]) ) !! 1 )
    | isSpace c  = lexemes  ( lex_space("":all:[]) !! 1 )
    | otherwise  = ( ( lex_symbol ("":all:[]) ) !! 0 ) : lexemes ( ( lex_symbol ("":all:[]) ) !! 1 )
    
-- Is a keyword? yes, push at tokens_list / no, do nothing
tokens :: [String]->[(String,String)]
	  if any (==head lexemes) tokens_list
	  then let tokens_final_list = tokens_list_temp ++ (head,keyword)
	  else tokens  tail lexemes