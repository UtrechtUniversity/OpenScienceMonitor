# load packages
library(tidyverse)
library(haven)
library(expss)
library(sjlabelled)

# load data
data1 <- read_sav("~/surfdrive/Shared/OS Monitor 2022/Data/Data/UOS WP_ Open Science Monitor 2022.sav")

data <- data1[, c(19, 36, 38, 40:46, 48, 50:56, 58:60, 65:108, 110:129, 131:142, 144:155, 158:189, 194:198, 200:214, 216:228, 230:241, 243:248, 256, 257, 263, 277:279)]

data_raw <- data %>%
  filter(Data_consent == 1,
         pens == 1,
         wp == 1)

data_filtered<- data_raw  %>%
  select(c(1:194))

haven::write_sav(data = data_filtered, path = "~/surfdrive/Shared/OS Monitor 2022/Data/Filtered datasets for YODA/OS Monitor 2022 WP Filtered.sav")

summary(as.numeric(data_filtered$Age))


# Mock data
data_mock <- read_sav("/Users/pepijnvink/surfdrive/Shared/OS Monitor 2022/Data/Mock data/Mock_WP__Open_Science_Monitor_2022.sav")
data_mock_filt <- data_mock[, c(19, 36, 38, 40:46, 48, 50:56, 58:60, 65:108, 110:129, 131:142, 144:155, 158:189, 194:198, 200:214, 216:228, 230:241, 243:248, 256, 257)] %>%
  mutate(Age = sample.int(n = 100, size = nrow(data_mock), replace = TRUE))
haven::write_sav(data = data_mock_filt, path = "~/surfdrive/Shared/OS Monitor 2022/Data/Mock data/Mock_WP_OSM_2022_Filtered.sav")

# create object with column names
vars_WP <- colnames(data)
# save WP variable names as file
save(vars_WP, file = "variables_WP.RData")

# Create seperate sav file for each Faculty
haven::write_sav(data1[data1$Faculty_2 == 1,], path = "~/surfdrive/Shared/OS Monitor 2022/Data/Data Analysis/Faculties/GEO.sav")
haven::write_sav(data1[data1$Faculty_2 == 2,], path = "~/surfdrive/Shared/OS Monitor 2022/Data/Data Analysis/Faculties/HUM.sav")
haven::write_sav(data1[data1$Faculty_2 == 3,,], path = "~/surfdrive/Shared/OS Monitor 2022/Data/Data Analysis/Faculties/REBO.sav")
haven::write_sav(data1[data1$Faculty_2 == 4,], path = "~/surfdrive/Shared/OS Monitor 2022/Data/Data Analysis/Faculties/GNK.sav")
haven::write_sav(data1[data1$Faculty_2 == 5,], path = "~/surfdrive/Shared/OS Monitor 2022/Data/Data Analysis/Faculties/BETA.sav")
haven::write_sav(data1[data1$Faculty_2 == 6,], path = "~/surfdrive/Shared/OS Monitor 2022/Data/Data Analysis/Faculties/FSW.sav")
haven::write_sav(data1[data1$Faculty_2 == 7,], path = "~/surfdrive/Shared/OS Monitor 2022/Data/Data Analysis/Faculties/DGK.sav")

