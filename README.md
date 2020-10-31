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

  
