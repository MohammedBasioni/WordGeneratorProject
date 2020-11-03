import DataFile

wordToken :: String -> [String]
wordToken "" = []
wordToken string = helper string ""
                    where helper "" ""      = []
                          helper "" current = [current]
                          helper (x:xs) current
                                | elem x punct = current : [x] : helper xs ""
                                | x == ' ' && current == "" = helper xs ""
                                | x == ' '           = current : helper xs ""
                                | otherwise            = helper xs (current ++ [x])



wordTokenList :: [String] -> [String]
wordTokenList [] = []
wordTokenList (x:xs) = wordToken x ++ wordTokenList xs

uniqueBigrams :: [String] -> [(String,String)]
uniqueBigrams [] = []
uniqueBigrams (x:y:xs) = helper (x:y:xs) []
                      where helper [] re = re
                            helper (x:y:[]) re
                                | elem (x,y) re = helper [] re
                                | otherwise = helper [] (re ++ [(x,y)])
                            helper (x:y:xs) re
                                | elem (x,y) re = helper (y:xs) re
                                | otherwise = helper (y:xs) (re ++ [(x,y)])


uniqueTrigrams :: [String] -> [(String,String,String)]
uniqueTrigrams [] = []
uniqueTrigrams (x:y:z:xs) = helper (x:y:z:xs) []
                      where helper [] re = re
                            helper (x:y:z:[]) re
                                | elem (x,y,z) re = helper [] re
                                | otherwise = helper [] (re ++ [(x,y,z)])
                            helper (x:y:z:xs) re
                                | elem (x,y,z) re = helper (y:z:xs) re
                                | otherwise = helper (y:z:xs) (re ++ [(x,y,z)])


bigramsFreq :: Num a => [String] -> [((String,String),a)]
bigramsFreq s = helper (uniqueBigrams s) s
            where helper [] l = []
                  helper ((x,y):z) l = [((x,y),cnt (x,y) l)] ++ helper z l
                  cnt (x,y) ([]) = 0
                  cnt (x,y) (z:[]) = 0
                  cnt (x,y) (a:b:z)
                    | ((x==a) && (y == b)) = 1 + cnt (x,y) (b:z)
                    |otherwise = cnt (x,y) (b:z)

trigramsFreq:: Num a => [String] -> [((String,String,String),a)]
trigramsFreq s = helper (uniqueTrigrams s) s
            where helper [] l = []
                  helper ((x,y,w):z) l = [((x,y,w),cnt (x,y,w) l)] ++ helper z l
                  cnt (x,y,w) ([]) = 0
                  cnt (x,y,w) (z:[]) = 0
                  cnt (x,y,w) (m:n:[]) = 0
                  cnt (x,y,w) (a:b:c:z)
                    | ((x==a) && (y == b) && (w==c)) = 1 + cnt (x,y,w) (b:c:z)
                    |otherwise = cnt (x,y,w) (b:c:z)


getFreq :: (Eq a, Num b) => a -> [(a,b)] -> b
getFreq a [] = 0
getFreq a ((x,y):z)
  | (a == x) = y
  | otherwise = getFreq a z

generateOneProb :: Fractional a => ((String,String,String),a) -> [((String,String),a)] -> a


generateOneProb _ [] = 0
generateOneProb ((x,y,z),a) (((s,m),b):xs)
                                    | x == s && y == m = a/b
                                    | otherwise = generateOneProb ((x,y,z),a) xs


genProbPairs :: Fractional a => [((String,String,String),a)] -> [((String,String),a)] -> [((String,String,String),a)]
genProbPairs [] _ = []
genProbPairs ((x,y):xs) listOfPairs = [(x,generateOneProb (x,y) listOfPairs)] ++ genProbPairs xs listOfPairs


pick xs = helper (randomZeroToX (length xs)-1) xs
        where helper n (x:xs)
                            | n>0 = helper (n-1) xs
                            | otherwise = x


valid _ [] = []
valid [x,y] (((a,b,c),n):xs)
                            | x==a && y==b && n > 0.03 = ([c] ++ valid [x,y] xs)
                            | otherwise = valid [x,y] xs


generateNextWord :: (Ord a, Fractional a) => [String] -> [((String,String,String),a)] -> String


generateNextWord words list
                      |(length (valid words list)) == 0 = error "Sorry, it is not possible to infer from current database"
                      |otherwise = pick (valid words list)

generateNewDoc = genProbPairs (trigramsFreq (wordTokenList docs)) (bigramsFreq(wordTokenList docs))

generateText :: String -> Int -> String
generateText string n = helper (wordToken string) generateNewDoc n
                     where
                            helper (x:y) list n
                                          | n > 0 = x ++ " " ++ helper (y ++ [(generateNextWord (x:y) (list))]) (list) (n-1)
                                          | otherwise = x ++ concat (" ":y)
