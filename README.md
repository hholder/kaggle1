# Kaggle Competition: Sentiment Analysis on Movie Reviews

http://www.kaggle.com/c/sentiment-analysis-on-movie-reviews"

I choose this competition for the Kaggle COmpetition Peer Review assignment of the Introduction to Data Science course on Coursera. Here's a run down of my approach.

In addition to the competition data I downloaded the AFINN-111.txt dataset that we used for the Twitter sentiment analysis assignment to use in my solution. My initial approach was fairly simple, I wrote a function that calculated a sentiment score for a phrase by summing the sentiment scores from the AFINN-111 dataset for each word in the phrase. I then loaded the train dataset and used the mean score for each group of phrases to write a function that mapped my assigned sentiment score to one of the 5 sentiment numbers:
* 0 - negative
* 1 - somewhat negative
* 2 - neutral
* 3 - somewhat positive
* 4 - positive

I then loaded the test dataset and calculated my sentiment score for each phrase then mapped that score to a sentiment number using my mapping function. My first submission using this method yielded a score of 0.18791

To improve my score I decided to include the train dataset as part of my solution. Prior to calculating a sentiment score, I check to see if the given phrase is included in the train dataset. If it is I use the sentiment number assigned to that phrase instead of calculating a sentiment score then mapping it to a sentiment number. This change gave a slight improvement and got my score up to 0.32621

One of the flaws of my latest approach was that many words did not match anything in the AFINN-111 dataset and therefore did not impact the sentiment score for a phrase. After some research I decided to further refine my approach by comparing word stems. I modified the AFINN-111 dataset to include the stem of the words and my method for calculating sentiment scores now searched for the the word in AFINN-111 and if it did not find a match it searched for the word stem. This refinement got my score up to 0.55269