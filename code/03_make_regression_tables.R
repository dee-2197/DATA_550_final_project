library(here)
here::i_am("code/03_make_regression_tables.R")

data <- readRDS(
  file = here::here("output/clean_data.rds")
)
library(gtsummary)
mod <- glm(Outcome ~ Glucose + Pregnancies + Insulin + BMI + Age,
           data = data)
primary_regression_table <- tbl_regression(mod) |>
  add_global_p()

saveRDS(
  primary_regression_table,
  file = here::here("output/regression_tables.rds")
)
