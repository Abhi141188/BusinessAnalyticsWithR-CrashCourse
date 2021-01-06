#Text Mining: "Sentiment Analysis"

#install.packages("tidytext")# provides additional text mining functions
#install.packages("tidyr")
#install.packages("ggplot2")
#install.packages("textdata") #This pkg is used to call dictionary "afinn".

#Dictionaries to segreggate words:
#There are a variety of dictionaries that exist for evaluating the opinion or emotion in text. 
#The tidytext package contains three sentiment lexicons in the sentiments dataset.
library(tidytext)   
sentiments
View(sentiments)

#selecting  the lexicon:
Afinn_Dictionary <- get_sentiments("afinn")
View(Afinn_Dictionary)

Nrc_Dictionary <- get_sentiments("nrc")
View(Nrc_Dictionary)

Bing_Lexicon_Dictionary <- get_sentiments("bing")
View(Bing_Lexicon_Dictionary)

#Tidytext will allow us to perform efficient text analysis on our data. 

library(janeaustenr)
library(stringr)
library(dplyr)

#About the data we plan to use:
?austen_books()
View(austen_books())

#We will convert the text of our books into a tidy format using unnest_tokens() function.
tidy_data <- austen_books() %>%
  group_by(book) %>%
  mutate(linenumber = row_number(),
         chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]", 
                                                 ignore_case = TRUE)))) %>%
  ungroup() %>%
  unnest_tokens(word, text)

tidy_data
View(tidy_data)

#We will now make use of the "bing" lexicon to implement filter() over the words that correspond to joy or positivity.
positive_senti <- get_sentiments("bing") %>%
  filter(sentiment == "positive")

tidy_data %>%
  filter(book == "Emma") %>%
  semi_join(positive_senti) %>%
  count(word, sort = TRUE)

#From our above result, we observe many positive words like "good", "happy", "love" etc. 

#Now, we use spread() function to segregate our data into separate columns of positive and negative sentiments. 
library(tidyr)
bing <- get_sentiments("bing")
Emma_sentiment <- tidy_data %>%
  inner_join(bing) %>%
  count(book = "Emma" , index = linenumber %/% 80, sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative)
#We use the mutate() function to calculate the difference between positive and negative sentiment.

View(Emma_sentiment)
Emma_sentiment

#Visualizing the words present in book "Emma" based on their corresponding positive and negative scores.
library(ggplot2)
ggplot(Emma_sentiment, aes(index, sentiment, fill = book)) +
  geom_bar(stat = "identity", show.legend = TRUE) +
  facet_wrap(~book, ncol = 2, scales = "free_x")

#Let's count the most common positive and negative words that are present in the novel.
counting_words <- tidy_data %>%
  inner_join(bing) %>%
  count(word, sentiment, sort = TRUE)
head(counting_words)

#visualizing our sentiment score
counting_words %>%
  filter(n > 150) %>%
  mutate(n = ifelse(sentiment == "negative", -n, n)) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n, fill = sentiment))+
  geom_col() +
  coord_flip() +
  labs(y = "Sentiment Score")

#visualizing wordcloud to show the most recurring positive and negative words.
#using the comparision.cloud() function to plot both negative and positive words in a single wordcloud.
library(reshape2)
#install.packages("wordcloud")
library(wordcloud)
tidy_data %>%
  inner_join(bing) %>%
  count(word, sentiment, sort = TRUE) %>%
  acast(word ~ sentiment, value.var = "n", fill = 0) %>%
  comparison.cloud(colors = c("red", "dark green"),
                   max.words = 100)

#This word cloud will enable us to efficiently visualize the negative as well as positive groups of data.
#We are able to see different groups of data based on their corresponding sentiments.





















