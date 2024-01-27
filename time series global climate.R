library(tidyr)
library(dplyr)
library(ggplot2)
library(car)
library(readr)

df <- read_csv("C:/Users/mudas/OneDrive/Desktop/QMB/GLB.Ts+dSST.csv", skip = 1)

df = df[,-c(14:19)]

df_clean = gather(df,key='Month',value='Temperature', 2:13)

summary(df_clean)
str(df_clean)

df_clean$Temperature = as.numeric(df_clean$Temperature)

#check for missing values

sum(is.na(df_clean))

#remove missing values
df_clean = na.omit(df_clean)

#Encoding months as numericals 
df_clean$month_num = match(df_clean$Month, month.abb)

#Create a date column as required in the task 

df_clean$date = as.Date(paste(df_clean$Year,df_clean$month_num, 01, sep = "-"),"%Y-%m-%d")

#Arranging the data as per the date for better visibility 
df_clean = arrange(df_clean,date)

#Creating lags
df_clean$Temperature_lag1 = c(NA,head(df_clean$Temperature,-1))

df_clean$Temperature_lag2 = c(NA,NA,head(df_clean$Temperature,-2))


#create yearly dummies as temperatures tend to have yearly seasonallity 

df_clean$yearly_dummies = ifelse(df_clean$month_num %% 12 == 0,1,0) 


#Plotting the time series
ggplot(df_clean, aes(date,Temperature)) +
  geom_line(color = 'red') +
  labs(title = "Global Surface Temperatures ", 
       x="Years",
       y="Temperatures")
  

#Time series modelling

#Train and test split

df_train = subset(df_clean, Year>=1880 & Year<=2009)
df_test =  subset (df_clean, Year>= 2010 & Year <=2019)

#fit a Linear model 
lm1.out = lm(Temperature ~ Temperature_lag1 + Year + month_num +yearly_dummies, data = df_train )
lm2.out = lm(Temperature ~ Temperature_lag1 + Temperature_lag2 + Year + month_num +yearly_dummies, data = df_train )

library(stargazer)
stargazer(lm1.out,lm2.out, type="text")


#predicitng on the test set
pred = predict(lm1.out, df_test)
pred2 = predict(lm2.out, df_test)
print(pred2)



#calculating rmse using Metrics library
library(Metrics)
rmse(df_test$Temperature, pred)

rmse(df_test$Temperature, pred2)


#Durbin Watson Test for Auto Correlation.

durbinWatsonTest(lm1.out)
durbinWatsonTest(lm2.out)









