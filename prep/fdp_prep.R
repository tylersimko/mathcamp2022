
library(readxl)

fdp <- read_xls("prep/fdp/FDP2008a.xls")

fdp <- fdp %>% 
  rename(refugees = source) %>% 
  mutate(refugees = ifelse(is.na(refugees), 999, refugees))

sum(is.na(fdp$refugees))
table(fdp$refugees == 999)

fdp <- fdp %>% filter(!is.na(host) & !is.na(idp))

write_csv(fdp, "prep/fdp/fdp.csv")
