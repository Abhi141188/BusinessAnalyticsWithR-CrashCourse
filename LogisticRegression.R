# Logistic Regression 
#install.packages("mlbench")
data(BreastCancer, package="mlbench")
View(BreastCancer)
bc <-BreastCancer
str(bc)
summary(bc)
#Removing the rows with missing values
bc1 <- BreastCancer[complete.cases(BreastCancer), ]  # create copy
str(bc1)

summary(bc1)

# remove id column
bc1 <- bc1[,-1]
View(bc1)
str(bc1)
# convert factors to numeric
for(i in 1:9) {
  bc1[, i] <- as.numeric(as.character(bc1[, i]))
}
str(bc1)
#When converting a factor to a numeric variable,always convert it to character and
#then to numeric, else, the values can get screwed up.

# Change Y values to 1's and 0's
bc1$Class <- ifelse(bc1$Class == "malignant", 1, 0)
str(bc1)
bc1$Class <- factor(bc1$Class, levels = c(0, 1))
str(bc1)
# Prep Training and Test data.
#install.packages("BiocManager")
#install.packages("caret")
library(caret)

trainDataIndex <- createDataPartition(bc1$Class, p=0.7, list = F)
trainData <- bc1[trainDataIndex, ]
testData <- bc1[-trainDataIndex, ]
View(trainData)
# Class distribution of train data
table(trainData$Class)


# Build Logistic Model
logitmod <- glm(Class ~ ., 
                family = "binomial", data=trainData)

summary(logitmod)

logitmod <- glm(Class ~ Cl.thickness+Cell.shape+#Cell.size+
                  Marg.adhesion+Epith.c.size+#Mitoses+
                  Bare.nuclei+Bl.cromatin, 
                family = "binomial", data=trainData)

summary(logitmod)

pred <- predict(logitmod, newdata = testData, type = "response")
pred

# Recode factors
testData$y_pred_num <- ifelse(pred > 0.5, 1, 0)

#testData$y_pred <- factor(y_pred_num, levels=c(0, 1))

#y_act <- testData$Class

View(testData)
table_mat<-table(testData$Class,testData$y_pred_num)
table_mat

# Accuracy
  mean(y_pred == y_act)  # 94%
accuracy_Test <- sum(diag(table_mat)) / sum(table_mat)
