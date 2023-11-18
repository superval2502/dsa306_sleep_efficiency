#' @apiTitle Sleep Efficiency Prediction API
#' @apiDescription This API predicts sleep efficiency based on various factors like age, sleep patterns, and lifestyle choices. It utilizes a machine learning model loaded in Sparklyr and returns a sleep efficiency score.


library(sparklyr); library(dplyr)

sc <- spark_connect(master = "local", version = "3.4.0")

sleep_efficiency_model <- ml_load(sc, path = "Sleep_efficiency_model")

#* @post /predict
#* @param Age The age of the individual in years
#* @param REM_sleep_percentage The percentage of REM sleep
#* @param Light_sleep_percentage The percentage of light sleep
#* @param Awakenings The number of awakenings during sleep
#* @param Caffeine_consumption The amount of caffeine consumed in mg
#* @param Alcohol_consumption the amount of alcohol consumed in the 24 hours prior to bedtime (in oz)
#* @param Exercise_frequency The frequency of exercise (No. of times in a week)
#* @param Smoking_status No for non-smoker, Yes for smokers
function(Age, REM_sleep_percentage, Light_sleep_percentage, Awakenings, 
         Caffeine_consumption, Alcohol_consumption, Exercise_frequency,
         Smoking_status){
  
  new_data <- data.frame(
    Age = as.numeric(Age),
    REM_sleep_percentage = as.numeric(REM_sleep_percentage),
    Light_sleep_percentage = as.numeric(Light_sleep_percentage),
    Awakenings = as.numeric(Awakenings),
    Caffeine_consumption = as.numeric(Caffeine_consumption),
    Alcohol_consumption = as.numeric(Alcohol_consumption),
    Exercise_frequency = as.numeric(Exercise_frequency),
    Smoking_status = as.integer(ifelse(Smoking_status == "Yes", 1, 0)),
    Sleep_efficiency = NA)
  
  new_data_r <- copy_to(sc, new_data, overwrite = TRUE)
  
  ml_transform(sleep_efficiency_model, new_data_r) |> 
    pull(prediction)
}