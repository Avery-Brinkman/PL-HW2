module Assignment2 where

------------------------------------------------
-- findFirst
------------------------------------------------
data Found = Match Int | NoMatch deriving Eq
instance Show Found where
  show (Match index) = "Found match at " ++ show index
  show NoMatch = "No match found!"
indexTracker :: Eq a => (a -> Bool) -> [a] -> Int -> Found
indexTracker needle haystack ind
    | null haystack = NoMatch
    | needle (head haystack) = Match ind
    | otherwise = indexTracker needle (tail haystack) (ind + 1)

findFirst :: Eq a => (a -> Bool) -> [a] -> Found
findFirst needle haystack = indexTracker needle haystack 0

------------------------------------------------
-- runLengthEncode
------------------------------------------------
data RunLength = Span Integer Char deriving Eq
instance Show RunLength where
  show (Span length c) = "Length: " ++ show length ++ ": " ++ show c
runCount :: [Char] -> Integer -> Integer
runCount [] cnt = cnt
runCount (x:xs) cnt
    | null xs = cnt
    | x == head xs = runCount xs (cnt + 1)
    | otherwise = cnt
runLengthEncode :: [Char] -> [RunLength]
runLengthEncode to_encode
    | null to_encode = []
    | otherwise = [Span runLength (head to_encode)]
    where runLength = runCount to_encode 1

------------------------------------------------
-- palindrome
-- If string of one or less, returns true.
-- OR
-- If the first element (head candidate) and last tail element 
-- (last tail candidate) are the same, AND the middle is also
-- a palindrome (checked recursively), then return
-- True, else return False.
------------------------------------------------
palindrome :: [Char] -> Bool
palindrome candidate = (length candidate <= 1) || ((head candidate == last (tail candidate)) && palindrome (init (tail candidate)))

------------------------------------------------
-- mergesort
------------------------------------------------
merge :: (Ord a) => (a -> a -> Bool) -> [a] -> [a] -> [a]
merge _ [] y = y
merge _ x [] = x
merge f x y
    | null x = y
    | null y = x
    | f (head x) (head y) = (head x):merge f (tail x) y
    | otherwise = (head y):merge f x (tail y)

mergesort :: (Ord a) => (a -> a -> Bool) -> [a] -> [a]
mergesort compareFunc nums
    | null firstHalf || null lastHalf = firstHalf ++ lastHalf
    | otherwise = merge compareFunc (mergesort compareFunc firstHalf) (mergesort compareFunc lastHalf)
    where (firstHalf, lastHalf) = splitAt (div(length nums) 2) nums

