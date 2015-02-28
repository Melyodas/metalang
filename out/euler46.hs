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
writeIOA :: IOArray Int a -> Int -> a -> IO ()
writeIOA = writeArray
readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray
array_init :: Int -> ( Int -> IO out ) -> IO (IOArray Int out)
array_init len f = newListArray (0, len - 1) =<< g 0
  where g i =
           if i == len
           then return []
           else fmap (:) (f i) <*> g (i + 1)

main :: IO ()
eratostene t max0 =
  do let n = 0
     let c = max0 - 1
     let a i y =
           if i <= c
           then ifM (((==) i) <$> (readIOA t i))
                    (do let z = y + 1
                        if (max0 `quot` i) > i
                        then do let j = i * i
                                let b ba =
                                      if ba < max0 && ba > 0
                                      then do writeIOA t ba 0
                                              let bb = ba + i
                                              b bb
                                      else a (i + 1) z in
                                      b j
                        else a (i + 1) z)
                    (a (i + 1) y)
           else return y in
           a 2 n

main =
  do let maximumprimes = 6000
     era <- array_init maximumprimes (\ j_ ->
                                       return j_)
     nprimes <- eratostene era maximumprimes
     primes <- array_init nprimes (\ o ->
                                    return 0)
     let l = 0
     let x = maximumprimes - 1
     let w k bc =
           if k <= x
           then ifM (((==) k) <$> (readIOA era k))
                    (do writeIOA primes bc k
                        let bd = bc + 1
                        w (k + 1) bd)
                    (w (k + 1) bc)
           else do printf "%d" (bc :: Int) :: IO ()
                   printf " == " :: IO ()
                   printf "%d" (nprimes :: Int) :: IO ()
                   printf "\n" :: IO ()
                   canbe <- array_init maximumprimes (\ i_ ->
                                                       return False)
                   let v = nprimes - 1
                   let r i =
                         if i <= v
                         then do let u = maximumprimes - 1
                                 let s j =
                                       if j <= u
                                       then do n <- (((+) (2 * j * j)) <$> (readIOA primes i))
                                               if n < maximumprimes
                                               then do writeIOA canbe n True
                                                       s (j + 1)
                                               else s (j + 1)
                                       else r (i + 1) in
                                       s 0
                         else let q m =
                                    if m <= maximumprimes
                                    then do let m2 = m * 2 + 1
                                            ifM ((return (m2 < maximumprimes)) <&&> (fmap not (readIOA canbe m2)))
                                                (do printf "%d" (m2 :: Int) :: IO ()
                                                    printf "\n" :: IO ()
                                                    q (m + 1))
                                                (q (m + 1))
                                    else return () in
                                    q 1 in
                         r 0 in
           w 2 l

