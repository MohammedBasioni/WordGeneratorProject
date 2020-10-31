# Word Generator System

## Project describtion
This project is an implementation of a simple algorithmic automatic text generator. It should be able to learn some statistics from a number of given documents **(from DataFile.hs)** and then use these statistics to generate text.
### Example given a list of documents
```
> generateText "the man" 3
"the man saw the saw"
```
The file `DataFile.hs` will contain these documents. The code uses the list `docs` from that file in
order to learn.

## The functions implemented
### wordToken
Splits the text so that each word/punctuation is a separate item in the list. The list of
punctuations is in the `DataFile.hs`.
- Example:
```
  > wordToken "the sun is shining. the wind is blowing"
["the","sun","is","shining",".","the","wind","is","blowing"]
```
### wordTokenList
Given a list of texts, it generates all tokens (separated words/punctuation).
- Example:
```
  > wordTokenList ["the man is the man. he is great","the man saw the saw"]
["the","man","is","the","man",".","he","is","great","the","man","saw","the","saw"]
```
### uniqueBigrams
The input to this function is a list of items and the output is a list of unique **pairs** of each two
consecutive items in the input list.
- Example:
```
  > uniqueBigrams ["the","man","is","the","man","."]
[("man","is"),("is","the"),("the","man"),("man",".")]
```
### uniqueTrigrams
Similar to the previous one, the input to this function is a list of items and the output is a list of unique **triples** of each three
consecutive items in the input list.
- Example:
```
  > uniqueTrigrams ["the","man","is","the","man","."]
[("the","man","is"),("man","is","the"),("is","the","man"),("the","man",".")]
```
### bigramsFreq
The input to this function is a list of words and the output is a list of **Bigram** frequencies which is
a list of each two consecutive words (as a pair) and their count as a pair.
- Example:
```
  > bigramsFreq ["the","man","is","the","man","."]
[(("man","is"),1),(("is","the"),1),(("the","man"),2),(("man","."),1)]
```
### trigramsFreq
Similar to the previous one, the input to this function is a list of words and the output is a list of **Trigram** frequencies which is
a list of each three consecutive words (as a pair) and their frequency/count as a pair.
- Example:
```
  > trigramsFreq ["the","man","is","the","man","."]
[(("the","man","is"),1),(("man","is","the"),1),(("is","the","man"),1),(("the","man
","."),1)]
```
### getFreq
Extracts the frequency given an item and a list of (item,frequency) pairs.
- Example:
```
  > getFreq ’a’ [(’f’,1),(’a’,2),(’b’,1)]
2
```
### generateOneProb
Extracts the frequency given an item and a list of (item,frequency) pairs.
- Example:
```
  > getFreq ’a’ [(’f’,1),(’a’,2),(’b’,1)]
2
```
  
P rob(w3jw1; w2) = count(w1; w2; w3)
count(w1; w2)
