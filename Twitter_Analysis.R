#Sentiment - twitter

# Tweeter Download and Analysis
#connect all libraries
library(plyr)
library(dplyr)
library(stringr)
library(ggplot2)
library(tidytext)
#install.packages("rtweet")
library(rtweet) 
#install.packages("syuzhet")
library(syuzhet)
#install.packages("twitteR")

# whatever name you assigned to your created app
appname <- "IRMA_Analytics"

#keys
consumerKey="zgMD6WP9LMSwmyOj8mN70IlXi"
consumerSecret="l0feGaIUzF0KbEqhhJLSbBIyjM618eJ25xXv9jUlyluO3hvkOs"
AccessToken="1212320988563558406-SnRpB6bNlIvoZNpOHMdfx18Lz145q4"
AccessTokenSecret="Q4lVgVqcKQEYg2nO732sM4M12EHKcFBSH6XxjKas6Lpeb"

# create token named "twitter_token"
twitter_token <- create_token(
  app = appname,
  consumer_key = consumerKey,
  consumer_secret = consumerSecret,
  access_token = AccessToken,
  access_secret = AccessTokenSecret)
#check token
get_token()

users = c("cnn", "BBCWorld", "realDonaldTrump")
famousUsers = lookup_users(users)
tweets_data(famousUsers)

#download tweets in json file
tweets1 <- search_tweets(q = searchString1, n = 50, retryonratelimit = T)
stream_tweets("realdonaldtrump",   timeout = 30,  file_name = "tweetsabouttrump.json",  parse = FALSE)
?stream_tweets
#https://cran.r-project.org/web/packages/rtweet/vignettes/intro.html
## read in the data as a tidy tbl data frame
djt <- parse_stream("tweetsabouttrump.json")
dim(djt)
ts_plot(djt,'secs') #frequency of tweets over a specified interval of time.
summary(djt[1:5])
names(djt[1:5])
djt$text[1:5]
View(djt)
#Remove hashtags & unnecessary characters
  tweets2a <- gsub("http.*","",djt$text)  #https
  tweets2a[1:4]
  tweets2b <- gsub("https.*","",tweets2a)  #https
  tweets2b[1:4]
  tweets2c <- gsub("#.*","",tweets2b) #others # topics
  tweets2c[1:4]
  tweets2d <- gsub("@.*","",tweets2c)  #others @ names
  tweets2d[1:4]
  
  head(tweets2d)
  View(tweets2d)
#-----
word.df <- as.vector(tweets2d)
word.df[1:2]
#library(syuzhet)
emotion.df <- get_nrc_sentiment(word.df)
emotion.df2 <- cbind(tweets2d, emotion.df) 
head(emotion.df2)
View(emotion.df2)
#-----

sent.value <- get_sentiment(word.df)
sent.value
most.positive <- word.df[sent.value == max(sent.value)]
most.positive
most.negative<- word.df[sent.value <= min(sent.value)] 
most.negative
#-----

positive.tweets <- word.df[sent.value > 0]
head(positive.tweets)
negative.tweets <- word.df[sent.value < 0] 
head(negative.tweets)
neutral.tweets <- word.df[sent.value == 0]
head(neutral.tweets)
#----
# Alternate way to classify as Positive, Negative or Neutral tweets
category_senti <- ifelse(sent.value < 0, "Negative", ifelse(sent.value > 0, "Positive", "Neutral"))
head(category_senti)
category_senti2 <- cbind(djt$text,category_senti,sent.value) 
head(category_senti2)
View(category_senti2)

table(category_senti)
barplot(table(category_senti))
#-----------------------------------------------------------------------------