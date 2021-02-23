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

#vec_random <- c(1,"a",TRUE)
#vec_random
#class(vec_random)

#Object Properties
#vector
v1 <- c(1:100)
v1
class(v1) 
typeof(v1)
length(v1)

v2 <- letters[1:10]
v2
class(v2) ; 
typeof(v2)
length(v2)

# Arithmetic calculations on vectors:
# Create the vectors
vect_1 <- c(1, 3, 5)
vect_2 <- c(2, 4, 6)
# Take the sum of A_vector and B_vector
sum_vect <- vect_1 + vect_2
# Print out total_vector
sum_vect

# Slicing Vector:Slice the first five rows of the vector
slice_vector <- c(10,20,30,40,50,60,70,80,90,100)
slice_vector
slice_vector[1:5]
slice_vector[10:6]

# Applying Logical Operators on Vectors:

# Create a vector from 1 to 10
logical_vector <- c(1:10)
logical_vector
logical_vector > 5
# Print value strictly above 5
logical_vector[(logical_vector>5)]
# Print 5 and 6

logical_vector <- c(1:10)
logical_vector > 4
logical_vector[(logical_vector>4) & (logical_vector<7)]

#access elements
(x = seq(0,10,by=2))
x
x[3]  # access 3rd element

x[c(2,4)]     # access 2nd and 4th element

x[-1]          # access all but 1st element

x[c(2,-4)]    # cannot mix positive and negative integers

x[c(0,-4)] 
x[-4]

x[c(2.4, 3.54)]    # real numbers are truncated to integers

#modify
(x <- -3:2)
x
x[2] <- 0; # modify 2nd element
x        
x[x<0] = 5; # modify elements less than 0
x   
x = x[1:4]; # truncate x to first 4 elements
x      
#delete vector
#(x = seq(1,5, length.out = 10))

x = NULL
x

x[4]

#Warning Mesg:
Vect_1 <- c(1:10)
Vect_2 <- c(20:31)
Vect_3 <- Vect_1 + Vect_2
Vect_3

