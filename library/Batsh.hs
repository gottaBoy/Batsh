module Batsh where

import qualified Batsh.Ast
import qualified Batsh.Generator
import qualified Batsh.Lexer
import qualified Batsh.Parser
import qualified Batsh.SymbolTable as SymbolTable
import qualified Batsh.Token as Token

lex :: String -> [Token.Lexeme]
lex code = Batsh.Lexer.scanLexemes code

parse :: String -> Batsh.Ast.Program
parse code = Batsh.Parser.parse code

parseFromFile :: FilePath -> IO Batsh.Ast.Program
parseFromFile path = do
  code <- readFile path
  return $ parse code

parseFromAstFile :: FilePath -> IO Batsh.Ast.Program
parseFromAstFile path = do
  code <- readFile path
  return (read code :: Batsh.Ast.Program)

generateCode :: Batsh.Ast.Program -> String
generateCode = Batsh.Generator.generateString

generateCodeToFile :: Batsh.Ast.Program -> FilePath -> IO ()
generateCodeToFile = Batsh.Generator.printToFile

createSymbolTable :: Batsh.Ast.Program -> SymbolTable.SymbolTable
createSymbolTable = SymbolTable.create
