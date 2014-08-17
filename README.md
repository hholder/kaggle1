# Kaggle Competition: Sentiment Analysis on Movie Reviews
http://www.kaggle.com/c/sentiment-analysis-on-movie-reviews

I choose this competition for the Kaggle COmpetition Peer Review assignment of the Introduction to Data Science course on coursera. Here's a run down of my approach.

In addition to the competition data I downloaded the AFINN-111.txt dataset that we used for the Twitter sentiment analysis assignment to use in my solution. My initial approach was fairly simple, I wrote a function that calculated a sentiment score for a phrase by summing the sentiment scores from the AFINN-111 dataset for each word in the phrase. I then loaded the train dataset and used the mean score for each group of phrases to write a function that mapped my assigned sentiment score to one of the 5 sentiment numbers:
* 0 - negative
* 1 - somewhat negative
* 2 - neutral
* 3 - somewhat positive
* 4 - positive
I then loaded the test dataset and calculated my sentiment score for each phrase then mapped that score to a sentiment number using my mapping function. My first submission using this method yeilded a score of 0.18791
