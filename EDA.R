library(tidyverse)
library(caret)
library(magrittr)
library(glmnet)
library(randomForest)
library(gbm)
library(e1071)
traindf<-read_csv('train.csv')
#
traindf1<-traindf %>%
        select(-PassengerId,-Name,-Ticket,-Cabin) %>%
        mutate(Survived = as.factor(Survived),
               Pclass   = as.factor(Pclass),
               Sex      = as.factor(Sex),
               Embarked = as.factor(Embarked))
#
traindf1$Age[is.na(traindf1$Age)]=mean(traindf1$Age,na.rm=T)
traindf1$Embarked[is.na(traindf1$Embarked)]='S'
apply(traindf1,2,function(x){sum(is.na(x))})
#
index=createDataPartition(traindf1$Survived,p=0.6,list = F)
train=traindf1[index,]
valid=traindf1[-index,]
fitc<-trainControl(number = 10,method = 'cv',repeats = 10)
logfit<-train(Survived~.,data=train,method='glmnet',trControl=fitc)
rffit<-train(Survived~.,data=train,method='rf',trControl=fitc)
gbmfit<-train(Survived~.,data=train,method='gbm',trControl=fitc)
