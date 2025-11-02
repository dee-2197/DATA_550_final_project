library(here)
here::i_am("code/02_make_graph.R")

data <-  readRDS(
  file = here::here("output/clean_data.rds")
)

library(ggplot2)

boxplot <- ggplot(data, aes(x = factor(Outcome), y = Glucose)) +
  geom_boxplot(fill = "lightblue", color = "darkblue") +
  labs(
    x = "Diabetes Outcome (0 = No, 1 = Yes)",
    y = "Glucose",
    title = "Distribution of Glucose by Diabetes Outcome"
  )

ggsave(
  here::here("output/boxplot.png"),
  plot = boxplot,
  device = 'png'
)