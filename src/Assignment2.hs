module Assignment2 where

------------------------------------------------
-- findFirst
------------------------------------------------
data Found = Match Int | NoMatch deriving Eq
instance Show Found where
  show (Match index) = "Found match at " ++ show index
  show NoMatch = "No match found!"
findFirst :: Eq a => (a -> Bool) -> [a] -> Found

------------------------------------------------
-- runLengthEncode
------------------------------------------------
data RunLength = Span Integer Char deriving Eq
instance Show RunLength where
  show (Span length c) = "Length: " ++ show length ++ ": " ++ show c
runLengthEncode :: [Char] -> [RunLength]

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
mergesort :: (Ord a) => (a -> a -> Bool) -> [a] -> [a]
