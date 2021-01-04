#Text Mining Basics in R: 
#Using speech "I have a dream" given by Martin Luther King to American citizens.

#install.packages("tm")  # for text mining
#install.packages("SnowballC") # for text stemming
#install.packages("wordcloud") # word-cloud generator 
#install.packages("RColorBrewer") # color palettes
# Load
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")

#Text mining----
#1.load the text
#The text is loaded using Corpus() function from text mining (tm) package. 
#Corpus is a list of a document (in our case, we only have one document).
#We start by importing the text file. Choose the text file as below:
text <- readLines(file.choose())
data <- as.data.frame(text)
View(data)

#Load the data as a corpus
# A corpus is a collection of documents.
docs <- Corpus(VectorSource(text))

#Inspect the content of the document
inspect(docs)

#Text transformation:----
#Transformation is performed using tm_map() function to replace, for example, 
#special characters from the text. Replacing "/", "@" and "|" with space:
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, toSpace, "/")
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")
docs <- tm_map(docs, toSpace, ":")
inspect(docs)

#Cleaning the text
#tm_map() function is used to remove unnecessary white space, to convert  text to lower case,
#to remove common stopwords like 'the', "we".

# Convert the text to lower case
docs <- tm_map(docs, content_transformer(tolower))
inspect(docs)

# Remove numbers
docs <- tm_map(docs, removeNumbers)
inspect(docs)

# Remove english common stopwords
docs <- tm_map(docs, removeWords, stopwords("english"))
inspect(docs)

# Remove your own stop word
# specify your stopwords as a character vector
docs <- tm_map(docs, removeWords, c("allow", "blabla2")) 
inspect(docs)

# Remove punctuations
docs <- tm_map(docs, removePunctuation)
inspect(docs)

# Eliminate extra white spaces
docs <- tm_map(docs, stripWhitespace)
inspect(docs)

#Text stemming:---- 
#bringing the word to its root form,i.e., converting 'gone' to 'go'.
docs <- tm_map(docs, stemDocument)
inspect(docs)

#limitation of stemming: 
#it sometimes removes prefixes & suffixes when it is not even required.
##Clean up to fix the nuances of stemming
docs <- tm_map(docs,content_transformer(gsub), pattern = "abl", replacement = "able")
docs <- tm_map(docs,content_transformer(gsub), pattern = "togeth", replacement = "together")
docs <- tm_map(docs,content_transformer(gsub), pattern = "everi", replacement = "everything")
docs <- tm_map(docs,content_transformer(gsub), pattern = "almighti", replacement = "almighty")
inspect(docs)
#Build a term-document matrix----
#Document matrix is a table containing the frequency of the words. 
#The function TermDocumentMatrix() from text mining package can be used as follow :
dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
View(d)
head(d, 10)

#Generate the Word cloud----
wordcloud(words = d$word, freq = d$freq, min.freq = 2,
          max.words=200, random.order=FALSE, rot.per=0.30,
          colors=brewer.pal(8, "Dark2"))

#The above word cloud clearly shows that "Will", "freedom", "dream", "day" and "together" are
#the five most important words in the speech document being analyzed. 

#Explore frequent terms and their associations----

#You can have a look at the frequent terms in the term-document matrix as follow. 
#In the example below we want to find words that occur at least four times :
findFreqTerms(dtm, lowfreq = 4)

#Association between terms using fxn: findAssocs()
#We analyze the association between frequent terms using findAssocs()function. 
#Below code identifies which words are associated with "freedom" in speech "I have a dream" being analyzed.

findAssocs(dtm, terms = "freedom", corlimit = 0.3)

#Frequency table of words
head(d, 10)

#Plot word frequencies
#The frequency of the first 10 frequent words are plotted :
  
barplot(d[1:10,]$freq, las = 2, names.arg = d[1:10,]$word,
          col ="lightblue", main ="Most frequent words",
          ylab = "Word frequencies")
