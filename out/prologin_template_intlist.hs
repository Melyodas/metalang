import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef

(<&&>) a b =
	do c <- a
	   if c then b
		 else return False
(<||>) a b =
	do c <- a
	   if c then return True
		 else b
ifM :: IO Bool -> IO a -> IO a -> IO a
ifM c i e =
  do b <- c
     if b then i else e
readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray

main :: IO ()


programme_candidat tableau taille =
  do let out0 = 0
     let b = taille - 1
     let a i c =
           if i <= b
           then do d <- (((+) c) <$> (readIOA tableau i))
                   a (i + 1) d
           else return c in
           a 0 out0

main =
  do taille <- (fmap read getLine)
     tableau <- (join (newListArray . (,) 0 . subtract 1 <$> return taille <*> fmap (map read . words) getLine))
     printf "%d" =<< (programme_candidat tableau taille :: IO Int)
     printf "\n" :: IO ()

