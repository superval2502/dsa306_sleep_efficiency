# Predicting Sleep Efficiency
This project aims to predict sleep efficiency based on various factors like age, sleep patterns, and lifestyle choices. It utilizes a machine learning model loaded in Sparklyr and returns a sleep efficiency score.

## Variables:
- ID: unique identifier for each test subject – not needed in our analysis
- Age: age of the test subject 
- Gender: male or female – binary – female = 1, male = 0
- Bedtime: the time the test subject goes to bed each night
- Wakeup time: the time the test subject wakes up each morning 
- Sleep duration: the total amount of time the test subject slept (in hours)
- Sleep efficiency: a measure of the proportion of time in bed spent asleep
- Rem sleep percentage: the percentage of total sleep time spent in REM sleep
- Deep sleep percentage: the percentage of total sleep time spent in deep sleep
- Light sleep percentage: the percentage of total sleep time spent in light sleep
- Awakenings: the number of times the test subject wakes up during the night
- Caffeine consumption: the amount of caffeine consumed in the 24 hours prior to bedtime (in mg)
- Alcohol consumption: the amount of alcohol consumed in the 24 hours prior to bedtime (in oz)
- Smoking status: whether or not the test subject smokes – binary -> Yes = 1 , No = 0
- Exercise frequency: the number of times the test subject exercises each week

## Dataset
**Source:** [Kaggle](https://www.kaggle.com/datasets/equilibriumm/sleep-efficiency)
