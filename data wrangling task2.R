
#0:Loading the necessary packages
library(dplyr)
library(stringr)
#Importing "titanic_original.csv" dataset
data<-data.frame(read.csv("titanic_original.csv",sep=";",stringsAsFactors = FALSE))


#1:Replacing the missing value from embarked column with "S" using replace() function
data$embarked=data%>%
              select(embarked)%>%
              replace(.,.=="","S")%>%
              unlist()

#2:Subsituting the missing values in the Age column with mean value
#First is to replace comma "," with "dot", so the value can be converted to numeric for averaging
data$age=gsub(",","\\.",data$age)

#Next is to replace value of NA to 0, converting all values to numeric,
#and replacing the missing value with mean()

data$age<-data %>%  
          select(age)%>%
          replace(.,.==""|NA,0)%>%
          unlist()%>%
          as.numeric()%>%
          replace(.,.==0,mean(.))

#3:Replacing the missing value in the boat collumn with "None" value
data$boat<-data %>%  
           select(boat)%>%
           replace(.,.==""|NA,"None")

#4:Creating new variable "has_cabin_number", which has value 1 if there is a cabin number, and 0 otherwise
data<- data %>%
       mutate(has_cabin_number=ifelse(is.na(cabin)|cabin==""|cabin==" ",0,1))
       

#To write the result into the csv file
write.csv(data,file="titanic_clean.csv")


   
       
         
