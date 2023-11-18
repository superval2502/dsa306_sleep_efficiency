# Predicting Sleep Efficiency
This project aims to predict sleep efficiency based on various factors like age, sleep patterns, and lifestyle choices. It utilizes a machine learning model loaded in Sparklyr and returns a sleep efficiency score.

## Variables:
- ID: Unique identifier for each test subject – not needed in our analysis
- Age: Age of the test subject 
- Gender: Male or female – binary – female = 1, male = 0
- Bedtime: The time the test subject goes to bed each night
- Wakeup time: The time the test subject wakes up each morning 
- Sleep duration: The total amount of time the test subject slept (in hours)
- Sleep efficiency: A measure of the proportion of time in bed spent asleep
- Rem sleep percentage: The percentage of total sleep time spent in REM sleep
- Deep sleep percentage: The percentage of total sleep time spent in deep sleep
- Light sleep percentage: The percentage of total sleep time spent in light sleep
- Awakenings: The number of times the test subject wakes up during the night
- Caffeine consumption: The amount of caffeine consumed in the 24 hours prior to bedtime (in mg)
- Alcohol consumption: The amount of alcohol consumed in the 24 hours prior to bedtime (in oz)
- Smoking status: Whether or not the test subject smokes – binary -> Yes = 1 , No = 0
- Exercise frequency: The number of times the test subject exercises each week

## Dataset
**Source:** [Kaggle](https://www.kaggle.com/datasets/equilibriumm/sleep-efficiency)
