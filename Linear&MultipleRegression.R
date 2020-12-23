#Regression
df <- read.csv("F:/rWork/rProjects/Analytics_Edge/Analytics_Edge_R/data/Stud_Reg_1.csv", header = T)
View(df)
df

#Single Linear Regression----
result<-lm(APPLICANTS ~ PLACE_RATE, data=df)
summary(result)


#Multiple Regression----
df <- read.csv("F:/rWork/rProjects/Analytics_Edge/Analytics_Edge_R/data/stud_reg.csv", header = T)
View(df)
df
result<-lm(APPLICANTS ~ PLACE_RATE + NO_GRAD_STUD, data=df)
summary(result)

#---------------------------------

