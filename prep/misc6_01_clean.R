
library(tidyverse)
library(readstata13)

# c_dat <- read.dta13("misc6/clean_fs_bangladesh.dta")

countries <- c("ghana", "kosovo", "nepal", "nigeria", "mongolia",
               "rwanda", "turkmenistan", "zimbabwe")

files <- list.files("prep/raw/misc6/")

s <- sapply(countries, function(i) {
  str_detect(files, i)
}) %>% rowSums()

to_read <- files[s == 1]

all_countries <- lapply(to_read, function(i) {
  read.dta13(paste0("prep/raw/misc6/", i)) %>% 
    mutate(country = gsub("clean_fs_|.dta", "", i)) %>% 
    select(country, highest_grade, 
           gender = boy, inschool, numeracy, age, urban) %>% as_tibble()
})

df <- bind_rows(all_countries)

to_write <- df %>% 
  filter(highest_grade >= 1 & highest_grade <= 6)

to_write$country <- tools::toTitleCase(to_write$country)

write_csv(to_write, "lessons/data/mics6.csv")
