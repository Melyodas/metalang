import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef
ifM :: IO Bool -> IO a -> IO a -> IO a
ifM c i e =
  do b <- c
     if b then i else e

main :: IO ()
sumdiag n =
  do let nterms = n * 2 - 1
     let b = nterms - 2
     let a i c e =
           if i <= b
           then do let d = 2 * (1 + (i `quot` 4))
                   let f = e + d
                   {- print int d print "=>" print un print " " -}
                   do let g = c + f
                      a (i + 1) g f
           else return c in
           a 0 1 1

main =
  printf "%d" =<< (sumdiag 1001 :: IO Int)


