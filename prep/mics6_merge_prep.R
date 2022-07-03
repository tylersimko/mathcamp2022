
library(tidyverse)

df <- read_csv("lessons/data/mics6.csv")

to_write <- df %>% 
  select(-age, -inschool, -age) %>% 
  filter(country %in% c("Ghana", "Mongolia", "Nepal"))

write_csv(to_write, "prep/mics6_for_merge.csv")
