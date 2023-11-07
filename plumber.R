# api.R

# Load required libraries
library(plumber)
library(sparklyr)
library(dplyr)

# Initialize Spark connection
sc <- sparklyr::spark_connect(master = "local", version = "3.4.0")

#' Predict Sleep Efficiency
#* @param Age The age of the individual in years
#* @param REM_sleep_percentage The percentage of REM sleep
#* @param Light_sleep_percentage The percentage of light sleep
#* @param Awakenings The number of awakenings during sleep
#* @param Caffeine_consumption The amount of caffeine consumed in mg
#* @param Alcohol_consumption the amount of alcohol consumed in the 24 hours prior to bedtime (in oz)
#* @param Exercise_frequency The frequency of exercise (times per week)
#* @param Smoking_status The smoking status ('0' for non-smoker, '1' for smoker)
#' @get /predict
function(Age, REM_sleep_percentage, Light_sleep_percentage, Awakenings, Caffeine_consumption, Alcohol_consumption, Exercise_frequency, Smoking_status) {
  
  new_data <- data.frame(
    Age = as.numeric(Age),
    REM_sleep_percentage = as.numeric(REM_sleep_percentage),
    Light_sleep_percentage = as.numeric(Light_sleep_percentage),
    Awakenings = as.numeric(Awakenings),
    Caffeine_consumption = as.numeric(Caffeine_consumption),
    Alcohol_consumption = as.numeric(Alcohol_consumption),
    Exercise_frequency = as.numeric(Exercise_frequency),
    Smoking_status = as.character(Smoking_status)
  )
  
  print("Created new_data")
  
  # Convert to Spark DataFrame
  result <- tryCatch({
    sparklyr::sdf_copy_to(sc, new_data, "new_data_spark", overwrite = TRUE)
    TRUE
  }, error = function(e) {
    print(paste("Error in sdf_copy_to:", e$message))
    FALSE
  })
  
  # If there's an error, return early
  if(!result) {
    return(list(error = "Failed to create Spark dataframe"))
  }
  
  print("Spark DataFrame created")
  
  # Load the trained model
  cv_model <- readRDS("cv_model.rds")
  
  print("Loaded the model")
  
  # Check the class of the loaded model
  print(paste("Class of cv_model:", toString(class(cv_model))))
  
  # Ensure it's the best model from cross validation if it's a cross-validated model
  if ("ml_cross_validator_model" %in% class(cv_model)) {
    cv_model <- cv_model$best_model
  }
  
  # Ensure cv_model is now a PipelineModel
  if (!("ml_pipeline_model" %in% class(cv_model))) {
    stop("cv_model is not a PipelineModel")
  }
  
  # Get Predictions
  predictions_spark <- ml_predict(cv_model, sdf_sql(sc, "SELECT * FROM new_data_spark"))

  # Check columns
  columns <- colnames(predictions_spark %>% collect())
  print(paste("Columns in predictions_spark:", toString(columns)))
  
  # Extract only necessary columns and then the predictions if the column exists
  if ("prediction" %in% columns) {
    predictions <- predictions_spark %>% 
      select(prediction) %>%
      collect() %>% 
      pull(prediction)
  } else {
    return(list(error = "Prediction column not found in the Spark DataFrame. Check the model's output."))
  }
  
  list(sleep_efficiency = predictions)
}
