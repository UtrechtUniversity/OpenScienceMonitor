# load packages
library(tidyverse)
library(haven)
library(expss)
library(sjlabelled)

# load data
dat_obp1 <- read_sav("~/surfdrive/Shared/OS Monitor 2022/Data/Data/UOS OBP_ Open Science Monitor 2022.sav")

dat_obp <- dat_obp1[, c(19, 20, 41, 43, 45:57, 59:61, 66:68, 70, 72:83, 85:92, 96, 101:157, 167:169)]

data_raw_obp<- dat_obp %>%
  filter(Data_consent == 1)

data_filtered_obp <- data_raw_obp  %>%
  select(c(1:102))

haven::write_sav(data = data_filtered_obp, path = "~/surfdrive/Shared/OS Monitor 2022/Data/Filtered datasets for YODA/OS Monitor 2022 OBP Filtered.sav")

# Mock data
dat_obp_mock <- read_sav("/Users/pepijnvink/surfdrive/Shared/OS Monitor 2022/Data/Mock data/Mock OBP_ Open Science Monitor 2022.sav")
  
dat_obp_mock_filt <- dat_obp_mock[, c(19, 20, 41, 43, 45:57, 59:61, 66:68, 70, 72:83, 85:92, 96, 101:157)] %>%
  mutate(Age = sample.int(n = 100, size = nrow(dat_obp_mock), replace = TRUE))

haven::write_sav(data = dat_obp_mock_filt, path = "~/surfdrive/Shared/OS Monitor 2022/Data/Mock data/Mock_OBP_OSM_2022_Filtered.sav")

# create object with column names
vars_OBP <- colnames(dat_obp)
# save WP variable names as file
save(vars_OBP, file = "variables_OBP.RData")

# create seperate files for Faculty and UBD/UB
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
