module Main where

import System.Exit (exitSuccess)
import System.IO (hPutStr, hFlush, hGetLine, stdin, stdout)
import Data.Text (pack, unpack, toLower, toUpper)

prompt :: String
prompt = "> ";

main :: IO ()
main = do
  hPutStr stdout prompt
  hFlush stdout
  cmd <- hGetLine stdin
  let statement = words cmd
  case (length statement) of 
    0 -> main
    _ -> exec statement >> main


exec :: [String] -> IO ()
exec (fn:args) = do
  case unpack (toLower $ pack fn) of
    "quit" -> exitSuccess
    "help" -> help
    _ -> if (length args) > 0 then
        putStrLn $ "Calling " ++ fn ++ " with arguments: " ++ (unwords args)
      else
        putStrLn $ "Calling " ++ fn

help :: IO ()
help = do
  mapM_ putStrLn
    [ "\n Available commands: "
    , "quit -- quit the REPL session"
    , "help - show this help message"
    , "\n"
    ]
