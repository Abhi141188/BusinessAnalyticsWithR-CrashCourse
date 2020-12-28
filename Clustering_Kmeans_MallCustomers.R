#Projects: Customer Segmentation
#A Company wants to identify segments of customers for targetted marketing.
library(ggplot2)
#Import data in R & read it.----
customer_data=read.csv("F:/rWork/rProjects/AbhiAnalytics/Mall_Customers.csv",header = T)
str(customer_data)
names(customer_data)
View(customer_data)
#Checking the summary of few variables:
summary(customer_data)

#Customer Gender Visualization----
#creating barplot & piechart to show  gender distribution across our customer_data dataset.
a=table(customer_data$Gender)
barplot(a,main="Using BarPlot to display Gender Comparision",
        ylab="Count",
        xlab="Gender",
        col=rainbow(2))
#From barplot, we observe that the number of females is higher than the males. 

#Visualization of Age Distribution----
#Ploting histogram to view the distribution of customer ages. 
summary(customer_data$Age)
hist(customer_data$Age,
     col="blue",
     main="Histogram to Show Count of Age Class",
     xlab="Age Class",
     ylab="Frequency",
     labels=TRUE)
#Boxplot for identifying outliers if any in Age.
boxplot(customer_data$Age,
        col="#ff0066",
        main="Boxplot for Analysis of Age")

#From above two visualizations, we conclude that max customer ages are between 30 and 35. 
#The minimum age of customers is 18, whereas, the maximum age is 70.

#Visualization of Annual Income of the Customers----
#Visualizations to analyze the annual income of the customers. 
#Plot a histogram & proceed to examine this data using a density plot.
summary(customer_data$Annual.Income..k..)
hist(customer_data$Annual.Income..k..,
     col="#660033",
     main="Histogram for Annual Income",
     xlab="Annual Income Class",
     ylab="Frequency",
     labels=TRUE)
#Density Plot to check for outliers if any in Annual Income.
plot(density(customer_data$Annual.Income..k..),
     col="yellow",
     main="Density Plot for Annual Income",
     xlab="Annual Income Class",
     ylab="Density")
polygon(density(customer_data$Annual.Income..k..),
        col="#ccff66")
#From above we conclude that the minimum annual income of customers is 15 & the max is 137. 
#People earning an average income of 70 have the highest frequency count in our histogram distribution.
#In the Kernel Density Plot, we observe that annual income has a normal distribution.

#Visualizing Spending scores of Customers:----
summary(customer_data$Spending.Score..1.100.)
## 1.00 34.75 50.00 50.20 73.00 99.00
hist(customer_data$Spending.Score..1.100.,
     main="HistoGram for Spending Score",
     xlab="Spending Score Class",
     ylab="Frequency",
     col="#6600cc",
     labels=TRUE)
#Finding outliers if any
boxplot(customer_data$Spending.Score..1.100.,
        horizontal=TRUE,
        col="#990000",
        main="BoxPlot for Analysis of Spending Score")

#K-Means Algorithm:---- 
# Finding Optmial Value of Clusters (K): Three popular methods -
#Elbow method
#Silhouette method
#Gap statistic

#Elbow Method(Most frequenctly used):
#Construct a function to compute the total within clusters sum of squares
kmean_withinss <- function(k) {
  cluster <- kmeans(customer_data[,3:5], k)
  return (cluster$tot.withinss)
}
#Try with 2 cluster
kmean_withinss(2)

#Run the algorithm n times
#Use sapply() function to run the algorithm over a range of k. 
#This technique is faster than creating a loop and store the value.

# Set maximum cluster 
max_k <-10
#Run algorithm over a range of k 
wss <- sapply(2:max_k, kmean_withinss)

#Create a data frame with the results of the algorithm
#Post creation and testing function, we can run the k-mean algorithm over a range
#from 2 to 10, store the tot.withinss values.

# Create a data frame to plot the graph
elbow <-data.frame(2:max_k, wss)
View(elbow)
#Plot the results
# We plot to visualize where is the elbow point

#Plot the graph with gglop
ggplot(elbow, aes(x = X2.max_k, y = wss)) +
  geom_point() +
  geom_line() +
  scale_x_continuous(breaks = seq(1, 10, by = 1))

#From the graph, we see the optimal k is four, where the curve is starting to have 
#a diminishing return. Once we have optimal k, we re-run the algorithm with k=4 
#and evaluate the clusters.

#Now, let us take k = 4 as our optimal cluster
k4<-kmeans(customer_data[,3:5],4)
k4
k4$cluster
k4$size
k4$centers
#Visualizing the Clustering Results 
set.seed(1)
ggplot(customer_data, aes(x =Annual.Income..k.., y = Spending.Score..1.100.)) + 
  geom_point(stat = "identity", aes(color = as.factor(k4$cluster))) +
  scale_color_discrete(name=" ",
                       breaks=c("1", "2", "3", "4"),
                       labels=c("Cluster 1", "Cluster 2", "Cluster 3", "Cluster 4")) +
  ggtitle("Segments of Mall Customers", subtitle = "Using K-means Clustering")

#By visualizing we observe that 5 clusters would have been better for Cust Segmentation:
#Hence, now let us take k = 5 as our optimal cluster
k5<-kmeans(customer_data[,3:5],5)
k5
k5$cluster
k5$size
k5$centers
#Visualizing the Clustering Results 
set.seed(1)
ggplot(customer_data, aes(x =Annual.Income..k.., y = Spending.Score..1.100.)) + 
  geom_point(stat = "identity", aes(color = as.factor(k5$cluster))) +
  scale_color_discrete(name=" ",
                       breaks=c("1", "2", "3", "4","5"),
                       labels=c("Cluster 1", "Cluster 2", "Cluster 3", "Cluster 4","Cluster 5")) +
  ggtitle("Segments of Mall Customers", subtitle = "Using K-means Clustering")







