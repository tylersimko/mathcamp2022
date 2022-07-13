
library(tidyverse)

econ <- read_csv("prep/globalterrorismdb_0718dist.csv")

econ <- econ %>%
  select(iyear, country_txt, nkill, nkillter) %>% 
  filter(between(iyear, 2000, 2014)) %>% 
  mutate(region = case_when(
    country_txt == "Iraq" ~ "Iraq",
    country_txt == "Nigeria" ~ "Nigeria",
    country_txt  %in% c("Syria","Afghanistan","Pakistan") ~ "Syria, Afghanistan & Pakistan",
    country_txt %in% c("Andorra", "Argentina", "Australia", "Austria", "Belgium", "Canada", "Chile", "Croatia", "Czech Republic", "Denmark", "Estonia", "Finland", "France", "Germany", "Greece", "Hungary", "Iceland", "Ireland", "Israel", "Italy", "Latvia", "Liechtenstein", "Lithuania", "Luxembourg", "Malta", "Monaco", "Netherlands", "New Zealand", "Norway", "Poland", "Portugal", "San Marino", "Slovakia", "Slovenia", "Spain", "Sweden", "Switzerland", "United Kingdom", "United States", "Vatican City") ~ "Western Countries",
    TRUE ~ "Others",
  ))

unique(econ_sum$region)

write_rds(econ, "lessons/data/terrorism.rds", compress = "xz")
