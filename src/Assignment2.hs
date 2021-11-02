module Assignment2 where

------------------------------------------------
-- findFirst
------------------------------------------------
data Found = Match Int | NoMatch deriving Eq
instance Show Found where
  show (Match index) = "Found match at " ++ show index
  show NoMatch = "No match found!"
findFirst :: Eq a => (a -> Bool) -> [a] -> Found
findFirst _ _ = NoMatch

------------------------------------------------
-- runLengthEncode
------------------------------------------------
data RunLength = Span Integer Char deriving Eq
instance Show RunLength where
  show (Span length c) = "Length: " ++ show length ++ ": " ++ show c
runLengthEncode :: [Char] -> [RunLength]
runLengthEncode _ = [Span 3 'b']

------------------------------------------------
-- palindrome
-- x = head, xs = tail
-- If the first element (x) and last tail element 
-- (last xs) are the same and the middle is also
-- a palindrome (checked recursively), then return
-- True, else return False.
------------------------------------------------
palindrome :: [Char] -> Bool
palindrome [] = True
palindrome (x:xs) = (x == last xs) && palindrome (init xs)

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

