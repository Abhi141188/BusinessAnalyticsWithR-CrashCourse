#Data Structures in R

#----Vectors----
# A vector is a one-dimensional array. 
# We can create a vector with all the basic data type
# The simplest way to build a vector is to use the c command.
# Creating a Numerical Vector:
vec_num <- c(1, 10, 49)
vec_num
class(vec_num)
# Creating a Character Vector:
vec_chr <- c("a", "b", "c")
vec_chr
class(vec_chr)
# Creating a Boolean Vector
vec_bool <-  c(TRUE, FALSE, TRUE)
vec_bool
class(vec_bool)

#----Matrix----
# Let's construct two 5x2 matrix with a sequence of number from 1 to 10, 
# one with byrow = TRUE and one with byrow = FALSE to see the difference.

#Construct a matrix with 5 rows that contain the numbers 1 up to 10 and byrow=TRUE 
matrix_a <-matrix(1:10, byrow = TRUE, nrow = 5)
matrix_a
# Print dimension of the matrix with dim()
dim(matrix_a)

# Construct a matrix with 5 rows that contain the numbers 1 up to 10 and byrow=FALSE
matrix_b <-matrix(1:10, byrow = FALSE, nrow = 5)
matrix_b
# Print dimension of the matrix with dim()
dim(matrix_b)

# Construct a matrix with 5 rows that contain the numbers 1 up to 10 with byrow not mentioned.
matrix_c <-matrix(1:10, nrow = 5)
matrix_c
# Hence, by default, byrow is set to FALSE in a matrix if not mentioned explicitely.

#----Data Frame----
#We can create a dataframe by combining variables of same length.
# Create a, b, c, d variables
a <- c(10,20,30,40)
b <- c('book', 'pen', 'textbook', 'pencil_case')
c <- c(TRUE,FALSE,TRUE,FALSE)
d <- c(2.5, 8, 10, 7)
# Join the variables to create a data frame
df <- data.frame(a,b,c,d)
df

# Print the structure
str(df)
# Note: By default, data frame returns string variables as a factor.

str(df) #structure of DF
head(df) #top 6 rows
head(df,n=3) #top 3 rows
tail(df) #last 6 rows
View(df)
class(df) # DF
summary(df) #summary
#Slice Data Frame: 
#We select rows and columns to return into bracket preceded by the name of the data frame

## Select row 1 in column 2
df[1,2]

## Select Rows 1 to 2
df[1:2,]

## Select Columns 1
df[,1]

## Select Rows 1 to 3 and columns 3 to 4
df[1:3, 3:4]

#Append a Column to Data Frame (use the symbol $ to append a new variable.)
# Create a new vector
quantity <- c(10, 35, 40, 5)
# Add `quantity` to the `df` data frame
df$quantity <- quantity
df

#Note:The number of elements in the vector has to be equal to the no of elements in data frame. 
#Hence, executing the below statement will give error
quantity <- c(10, 35, 40)
# Add `quantity` to the `df` data frame
df$quantity <- quantity

#----List----
#We  use list() function to create a list.

#We will create three different objects: vector, matrix and data frame.
#And will create a list with all these objects combined together.

#Creating a Vector with numeric from 1 up to 5
vect  <- 1:5
#Creating a 2x 5 matrix
mat  <- matrix(1:10, ncol = 5)
dim(mat)
# Creating a data frame by selecting the 10th row of the built-in R data set EuStockMarkets
df <- EuStockMarkets[1:10,]
# Construct list with these vec, mat, and df:
my_list <- list(vect, mat, df)
my_list

#Select Elements from List
#We need to use the [[index]] to select an element in a list. 
#The value inside the double square bracket represents the position of the item in a list we want to extract.
# Print second element of the list
my_list[[2]]