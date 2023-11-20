# load data
dat_obp <- read_sav("~/surfdrive/Shared/OS Monitor 2022/Data/Data/UOS OBP_ Open Science Monitor 2022.sav")

# create separate files
dat_obp %>%
  mutate(Fac_new = case_when(as.numeric(Fac_2) <= 8 | as.numeric(Fac_2) == 12 ~ "Faculty",
                             as.numeric(Fac_2) == 9 | as.numeric(Fac_2) == 10 ~ "UBD/UB",
                             TRUE ~ NA) %>% factor()) %>%
  filter(Fac_new == "Faculty") %>%
  haven::write_sav(path = "~/surfdrive/Shared/OS Monitor 2022/Data/Data Analysis/OBP Faculties vs UBD:UB/Faculty.sav")

dat_obp %>%
  mutate(Fac_new = case_when(as.numeric(Fac_2) <= 8 | as.numeric(Fac_2) == 12 ~ "Faculty",
                             as.numeric(Fac_2) == 9 | as.numeric(Fac_2) == 10 ~ "UBD/UB",
                             TRUE ~ NA) %>% factor()) %>%
  filter(Fac_new == "UBD/UB") %>%
  haven::write_sav(path = "~/surfdrive/Shared/OS Monitor 2022/Data/Data Analysis/OBP Faculties vs UBD:UB/UBD:UB.sav")
