module Assignment2 where

------------------------------------------------
-- findFirst
-- findFirst calls another function called indexTracker
-- indexTracker is the same function, but also has an
-- argument for the current index. If the first element
-- of hastack satisfies needle, the Match current index 
-- is returned. If not, indexTracker is called again on the 
-- tail with the index incremented by one. If indexTracker 
-- is called on an empty list (which happens if the initial 
-- list is empty and if the end of the list is reached) then
-- NoMatch is returned. 
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
-- This function uses 2 additional functions.
-- runCount takes a string and returns the 
-- number of times the first element of that string
-- is repeated (consecutively).
-- nextLength takes a string and recursively removes
-- the first character until a new character is reached,
-- returning the new string without the first 'group'.
-- runLengthEncode returns the Span of the first element 
-- (as a list), and appends runLengthEncode of nextLength.
------------------------------------------------
data RunLength = Span Integer Char deriving Eq
instance Show RunLength where
  show (Span length c) = "Length: " ++ show length ++ ": " ++ show c
runCount :: [Char] -> Integer -> Integer
runCount [] _ = 0
runCount str count
    | null (tail str) = count + 1
    | head str == head (tail str) = runCount (tail str) (count + 1)
    | otherwise = count + 1

nextLength :: [Char] -> [Char]
nextLength str
    | null str || null (tail str) = []
    | head str == head (tail str) = nextLength (tail str)
    | otherwise = tail str

runLengthEncode :: [Char] -> [RunLength]
runLengthEncode to_encode
    | null to_encode = []
    | otherwise = [Span (runCount to_encode 0) (head to_encode)] ++ runLengthEncode (nextLength to_encode)

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
-- The function uses merge to combine the recursively
-- sortec first and second halves of the list.   
------------------------------------------------
merge :: (Ord a) => (a -> a -> Bool) -> [a] -> [a] -> [a]
merge _ [] y = y
merge _ x [] = x
merge compareFunc x y
    | null x = y
    | null y = x
    | compareFunc (head x) (head y) = (head x):merge compareFunc (tail x) y
    | otherwise = (head y):merge compareFunc x (tail y)

mergesort :: (Ord a) => (a -> a -> Bool) -> [a] -> [a]
mergesort compareFunc nums
    | null firstHalf || null lastHalf = firstHalf ++ lastHalf
    | otherwise = merge compareFunc (mergesort compareFunc firstHalf) (mergesort compareFunc lastHalf)
    where (firstHalf, lastHalf) = splitAt (div(length nums) 2) nums

