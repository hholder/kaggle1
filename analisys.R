sentiments <- read.delim("afinn.tsv")
sentStems <- cbind(sentiments, stem=wordStem(as.vector(sentiments[,1])))
train <- read.delim("train.tsv")

smap <- rbind(data.frame(score=4, sentiment=4),
              data.frame(score=1, sentiment=3),
              data.frame(score=0, sentiment=2),
              data.frame(score=-1, sentiment=1),
              data.frame(score=-2, sentiment=0))

calcSentimentNum <- function(phrase) {
    scores <- train[train$Phrase == phrase, ]
    score <- 0
    if (length(scores$Sentiment) > 0) {
      score <- scores$Sentiment[1]
    } else {
      sentScore <- calcSentimentScore(phrase)
      score <- getSentimentNum(sentScore)
    }
    score
}

# calculate the sentiment of the given phrase by summing the sentiment rank
# of each word in the phrase if the phrase does not exist in afinn
calcSentimentScore <- function(phrase) {
  scores <- sentiments[sentiments$phrase == phrase, ]
  score <- 0
  if (length(scores$score) > 0) {
    score <- scores$score[1]
  } else {
    score <- sumWordSentimentScores(phrase)
  }
  score
}

sumWordSentimentScores <- function(phrase) {
  score <- 0
  words <- unlist(strsplit(phrase, " ", T))
  for (word in words) {
    word_scores <- sentiments[sentiments$phrase == word, ]
    if (length(word_scores$score) > 0) {
      word_score <- word_scores$score[1]
      score <- score + word_score
    } else {
      stem <- wordStem(word)
      word_scores <- sentStems[sentStems$stem == stem, ]
      if (length(word_scores$score) > 0) {
        word_score <- word_scores$score[1]
        score <- score + word_score
      } 
    }
  }
  score
}

getSentimentNum <- function(sentScore) {
  num <- 2
  if (sentScore >= 4) {
    num <- 4
  } else if (sentScore < 4 && sentScore >= 1) {
    num <- 3
  } else if (sentScore < 1 && sentScore >= 0) {
    num <- 2
  } else if (sentScore < 0 && sentScore >= -1) {
    num <- 1
  } else {
    num <- 0
  }
  num
}

# calculates a sentiment score for each phrase in the Phrase column of the
# given data frame and returns a data frame with all the columns of the
# given data frame as well as a Score column containing the calculated
# scores
appendSentimentScores <- function(data) {
  phrases <- as.vector(data[['Phrase']])
  scores <- unlist(lapply(phrases, calcSentimentScore))
  nums <- unlist(lapply(phrases, calcSentimentNum))
  result <- cbind(data, score=scores, sentiment=nums)
  result
}

