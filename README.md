# Automatic Text Generation System

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
Generates the probability of a word following two other words given a trigram frequency pair and
a list of Bigram frequencies.
- Example:
```
  > generateOneProb (("the","man","is"),1)
[(("he","is"),1),(("is","great"),1),(("great","the"),1),(("the","man"),3)]
0.333333333333333
```

### genProbPairs
Generates a list of probabilities for each and every trigram given a list of Trigram frequencies and
another list of Bigram frequencies.
- Example:
```
  > genProbPairs [(("the","man","is"),1),(("man","is","the"),1),(("is","the","man"),1
),(("the","man","."),1),(("man",".","the"),1),((".","the","man"),1),(("the","man","
saw"),1)] [(("man","is"),1),(("is","the"),1),(("man","."),1),((".","the"),1),(("the
","man"),3),(("man","saw"),1)]
[(("the","man","is"),0.333333333333333),(("man","is","the"),1.0),(("is","the","man"
),1.0),(("the","man","."),0.333333333333333),(("man",".","the"),1.0),((".","the","
man"),1.0),(("the","man","saw"),0.333333333333333)]
```

### generateNextWord
Given a list of two words and a probability pairs list, it randomly chooses the next word taking into
consideration that the probability of this word following those two words is greater than 0.03.
- Example: A possible output to the following
```
> generateNextWord ["the","man"][(("the","man","is"),0.333333333333333),(("man","is
","the"),1.0),(("is","the","man"),1.0),(("the","man","."),0.333333333333333),(("man
",".","the"),1.0),((".","the","man"),1.0),(("the","man","saw"),0.333333333333333)]
"saw"
```

### generateText
According to the content of the docs list in the DataFile.hs file and given a string of 2 items (words/-
punctuation) and number n, you should generate n words/punctuation taking into consideration
the statistics mentioned above and return the whole text including the two words you started with.
- Example: A possible output to the following (using the shorter list docs)
```
> generateText "the man" 2
"the man saw the
```

## Note
> there are two docs lists in the `DataFile.hs`, a shorter one for testing and the longer
one *(commented)* to try the whole project on at the end. The longer one is a preprocessed one from [this link.](https://simple.wikipedia.org/)


