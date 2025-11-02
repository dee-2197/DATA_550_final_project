library(here)
here::i_am("code/01_make_table1.R")

data <- readRDS(
  file = here::here("output/clean_data.rds")
)

library(gtsummary)
table1 <-  data |> 
  select("Glucose","Pregnancies", "Insulin", "BMI", "Age", "diabetes") |> 
  tbl_summary(by = diabetes) |> 
  modify_spanning_header(c("stat_1", "stat_2") ~  "Outcome of Diabetes") |> 
  add_n() |> 
  add_overall() |> 
  add_p()

saveRDS(
  table1,
  file = here::here("output/table1.rds")
)
