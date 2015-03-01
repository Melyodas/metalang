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
  do let g = max0 - 1
     let e i w =
           if i <= g
           then ifM (((==) i) <$> (readIOA t i))
                    (do let x = w + 1
                        let j = i * i
                        let f y =
                              if y < max0 && y > 0
                              then do writeIOA t y 0
                                      let z = y + i
                                      f z
                              else e (i + 1) x in
                              f j)
                    (e (i + 1) w)
           else return w in
           e 2 0

isPrime n primes len =
  do let ba = if n < 0
              then let bb = - n
                            in bb
              else n
     let d bc =
           ifM (((>) ba) <$> ((*) <$> (readIOA primes bc) <*> (readIOA primes bc)))
               (ifM (((==) 0) <$> ((rem ba) <$> (readIOA primes bc)))
                    (return False)
                    (do let bd = bc + 1
                        d bd))
               (return True) in
           d 0

test a b primes len =
  let c n =
        if n <= 200
        then do let j = n * n + a * n + b
                ifM (fmap not (isPrime j primes len))
                    (return n)
                    (c (n + 1))
        else return 200 in
        c 0

main =
  do era <- array_init 1000 (\ j ->
                               return j)
     nprimes <- eratostene era 1000
     primes <- array_init nprimes (\ o ->
                                     return 0)
     let v = 1000 - 1
     let u k be =
           if k <= v
           then ifM (((==) k) <$> (readIOA era k))
                    (do writeIOA primes be k
                        let bf = be + 1
                        u (k + 1) bf)
                    (u (k + 1) be)
           else do printf "%d == %d\n" (be::Int) (nprimes::Int) :: IO()
                   let r b bg bh bi bj =
                         if b <= 999
                         then ifM (((==) b) <$> (readIOA era b))
                                  (let s a bk bl bm bn =
                                         if a <= 999
                                         then do n1 <- test a b primes nprimes
                                                 n2 <- test a (- b) primes nprimes
                                                 (\ (bo, bp, bq, br) ->
                                                   if n2 > bp
                                                   then do let bt = - a * b
                                                           let bv = - b
                                                           s (a + 1) a n2 bv bt
                                                   else s (a + 1) bo bp bq br) (if n1 > bl
                                                                                then let bx = a * b
                                                                                              in (a, n1, b, bx)
                                                                                else (bk, bl, bm, bn))
                                         else r (b + 1) bk bl bm bn in
                                         s (- 999) bg bh bi bj)
                                  (r (b + 1) bg bh bi bj)
                         else printf "%d %d\n%d\n%d\n" (bg::Int) (bi::Int) (bh::Int) (bj::Int) :: IO() in
                         r 3 0 0 0 0 in
           u 2 0


