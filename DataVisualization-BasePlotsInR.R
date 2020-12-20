# Base Plots in R:

#bar Plot in R----
#count of categories.
#We can build them using the barplot() function available in base R.
View(mtcars)
cylinders = table(mtcars$cyl)
cylinders
barplot(table(mtcars$cyl))

barplot(table(mtcars$am))
barplot(table(mtcars$gear), 
        col=1:3, main='No of cars of each gear type', xlab='Gear Type', ylab='Count of Cars')

c = table(mtcars$carb)
c
barplot(table(mtcars$carb), col=1:5, horiz = T)

#--------------------------
#Histogram & Density Plots in R----
#We can build them using the hist() function available in base R.
# Simple Histogram
hist(mtcars$mpg)

# Colored Histogram with Different Number of Bins
hist(mtcars$mpg, breaks=10, col="red")

#Density plots:
#These plots are effective way to view the distribution of a variable.
#Density Plot
d <- density(mtcars$mpg) # returns the density data 
plot(d) # plots the results

# Filled Density Plot
d <- density(mtcars$mpg)
plot(d, main="Density of Miles Per Gallon")
polygon(d, col="red", border="blue")

#--------------------------
#box Plot----
#used for continuous values to depict 5 number summary.
#We can build them using the boxplot() function available in base R.
mtcars
summary(mtcars$mpg)
quantile(mtcars$mpg)

#box plot with line showing mean of mpg 
boxplot(mtcars$mpg)
abline(h=mean(mtcars$mpg))

#box plot with lines showing quantile values of mpg 
boxplot(mtcars$mpg, col='green')
abline(h=quantile(mtcars$mpg))  

qvalues = c(10, 20, 30)
#box plot with lines showing user defined points
boxplot(mtcars$mpg, col='yellow')
abline(h=qvalues, col=1:3)  
#specifying col 1 to 3 : maps to R colours

#--------------------------
#Line Plots in R----
#We can build them using the plot() function available in base R.

#plot
X=1:10
Y=11:20
plot(x=X, y=Y)
plot(x=X, y=Y, type='s') #points
plot(x=X, y=Y, type='p', pch=8) #points, plotting symbol=13
#see internet for different plotting symbols
plot(x=X, y=Y, type='p', cex=2) #points, double the size

#--------------------------
#Scatterplot & Pairs plots in R----
#We can build them using the plot() function available in base R.

X=1:10
Y=11:20
plot(x=X, y=Y)
mtcars
plot(mtcars$wt, mtcars$mpg, main="Scatterplot Example", 
     xlab="Car Weight ", ylab="Miles Per Gallon ", pch=11)

df<-mtcars
plot(x=df$wt, y=df$mpg, col=df$cyl)

#--------------------------
#Correlation Plot in R----
#Use cor( ) function to produce correlations in R and
#we use function corrgram( ) to plot correlograms in R.

# mtcars dataset is natively available in R
head(mtcars)
# Correlation matrix from mtcars
# with mpg, cyl, and disp as rows 
# and hp, drat, and wt as columns 
x <- mtcars[1:3]
y <- mtcars[4:6]
z<-cor(x, y)
z

#We use function corrplot( ) in package "corrplot" to plot correlograms.
#install.packages("corrplot")
library(corrplot)
corrplot(z, type = "upper", 
         tl.col = "black", tl.srt = 45)

#We use function corrgram( ) in package "corrgram" to plot correlograms.
#install.packages("corrgram")
library(corrgram)

# First
corrgram(mtcars, order=TRUE, lower.panel=panel.shade, 
         upper.panel=panel.pie, text.panel=panel.txt, 
         main="Car Milage Data in PC2/PC1 Order") 

# Second
corrgram(mtcars, order=TRUE, lower.panel=panel.ellipse, 
         upper.panel=panel.pts, text.panel=panel.txt, 
         diag.panel=panel.minmax, main="Car Milage Data in PC2/PC1 Order") 

# Third
corrgram(mtcars, order=NULL, lower.panel=panel.shade, 
         upper.panel=NULL, text.panel=panel.txt, 
         main="Car Milage Data (unsorted)")
#--------------------------
#pie chart in R----
#We can build them using the pie() function available in base R.
x = c(10,20,40,50)
pie(x)
xlabels = c('A','B','C','D')
pie(x, labels=xlabels)

#pie on mtcars
(cylinders = table(mtcars$cyl))
pie(x=cylinders)
pie(x=cylinders, labels=c('4-Cyl','6-Cyl','8-Cyl'))
pie(x=cylinders, labels=paste(c('4-Cyl','6-Cyl','8-Cyl'),'\n', cylinders, ' cars', sep='-')) #'\n' wraps the output

#--------------------------
#Mosaic Plots----
#We can build them using the mosaic() function available in base R.

# Mosaic Plot Example
#install.packages("vcd")
library(vcd)
HairEyeColor
View(HairEyeColor)
mosaic(HairEyeColor, shade=TRUE, legend=TRUE)

#--------------------------
#Heat Maps in R----
#We can build them using the heatmap() function available in base R.

#The mtcars dataset:
data <- as.matrix(mtcars)

#Default Heatmap
heatmap(data)

#Using 'scale' to normalize
heatmap(data, scale="column")

#Native palette from R
heatmap(data, scale="column", col = cm.colors(256))
heatmap(data, scale="column", col = terrain.colors(256))
