# Global-Climate-Change-Analysis_Time-Series

OBJECTIVE: Analyze the effects of global climate change using surface temperature data.

Data Wrangling:
Download the global surface temperature change data from NASA at:
https://data.giss.nasa.gov/gistemp/tabledata_v3/GLB.Ts+dSST.csv
Create a data frame in long format, ensuring that you retain the dates and months. Given that we are
modeling climate change at the monthly level, you may omit columns that report yearly aggregates. Be
mindful of potential missing values.

Plot the Resulting Time Series:
Plot the time series and discuss whether you observe any trends, seasonal, or cyclical components in the
data.

Time Series Model:
Using your intuition, build a time series model to predict the temperature change. Use the data from 1880
to 2009 as the training set and the data from 2010 to 2019 as the testing set. Validate your model using the
RMSE function developed in class and ensure to check for residual autocorrelation using the Durbin-Watson
test.

Summary of Findings:
Summarize your findings from the prediction exercise. Discuss whether global warming is predictable using
the training set and any insights gained from the analysis.
