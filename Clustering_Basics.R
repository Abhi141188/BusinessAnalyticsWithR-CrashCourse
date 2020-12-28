#Clustering Basics:

#Clustering----
#Example:
#We have data on the total spend of customers and their ages. 
#To improve advertising, marketing team wants to send more targeted emails to their customers.

#Plot the total spend and the age of the customers.
library(ggplot2)
df <- data.frame(age = c(18, 21, 22, 24, 26, 26, 27, 30, 31, 35, 39, 40, 41, 42, 44, 46, 47, 48, 49, 54),
                 spend = c(10, 11, 22, 15, 12, 13, 14, 33, 39, 37, 44, 27, 29, 20, 28, 21, 30, 31, 23, 24)
)
ggplot(df, aes(x = age, y = spend)) +
  geom_point()

#Partition Clustering ----
#Kmeans clustering on iris dataset
data("iris")
View(iris)
i1<-iris
i1$Species=NULL
head(i1)

#Kmeans with k = 3

res <- kmeans(i1,3)
res
res$size
res$cluster

#To check the accuracy of clusters formed:
#Plot
par(mfcol = c(1, 2))
plot(iris[c("Petal.Length","Petal.Width")],col= res$cluster)
plot(iris[c("Petal.Length","Petal.Width")],col= iris$Species)

#table cmd:
iris$CL<-res$cluster
View(iris)
table(iris$Species,iris$CL)

#Accuracy:
#Total Correctly classifed instances = 50+48+36
#Accuracy = (134)/(150) = 89.3%


#Hierarchical Clustering----
summary(iris)

#Method1=Complete
#Using hclust function on the dataset for hierarchical clustering
c1 = hclust(dist(iris[,3:4]),method = "complete")
plot(c1)
plot(c1, cex=0.3)
#cut the dendrogram tree with a horizontal line at a height where the line can traverse 
#without intersecting the merging point. Hence, We can see the ideal no. of clusters is 2.
#But that will not divide the dataset correctly, hence, taking no. of clusters as 3.
#we can cut-off the tree at desired no. of clusters using cutree.
Cut1 = cutree(c1,3)
table(iris$Species, Cut1)
#Rectangular Clusters
rect.hclust(c1,k=3,border = 2:5)
#Accuracy:
#Total Correctly classifed instances = 50+50+29
#Accuracy = (50+29+50)/(150) = 85 %

#Method2=ward.D
c2 = hclust(dist(iris[,3:4]),method = "ward.D")
plot(c2, cex=0.3)
#We see that the ideal n. of clusters is 3 or 4.
#We cut the tree at the desired no. of clusters using cutree.
Cut2 = cutree(c2,3)
table(iris$Species,Cut2)
rect.hclust(c2,k=3,border = 2:5)
#Accuracy:
#Total Correctly classifed instances = 50+45+49
#Accuracy = (50+45+49)/(150) = 96 %

#Method3=Average
c3 = hclust(dist(iris[,3:4]),method = "average")
plot(c3, cex=0.3)
#We see that the ideal n. of clusters is 3 or 4.
#We cut the tree at the desired no. of clusters using cutree.
Cut3 = cutree(c3,3)
table(iris$Species,Cut3)
rect.hclust(c3,k=3,border = 2:5)
#Accuracy:
#Total Correctly classifed instances = 50+45+49
#Accuracy = (50+45+49)/(150) = 96 %
