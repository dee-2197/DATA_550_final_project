library(here)
here::i_am("code/00_load_data.R")
absolute_path_to_data <- here::here("raw_data/diabetes.csv")
data <- read.csv(absolute_path_to_data, header = TRUE)
library(labelled)

var_label(data) <- list(
  Outcome = "Diabetes"
)
data$diabetes <- ifelse(data$Outcome == 0, "Non-Diabetic","Diabetic")

saveRDS(
  data, 
  file = here::here("output/clean_data.rds")
)

