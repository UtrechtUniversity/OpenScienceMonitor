# read in data
data1 <- read_sav("~/surfdrive/Shared/OS Monitor 2022/Data/Data/UOS WP_ Open Science Monitor 2022.sav")

# Create seperate sav file for each Faculty
haven::write_sav(data1[data1$Faculty_2 == 1,], path = "~/surfdrive/Shared/OS Monitor 2022/Data/Data Analysis/Faculties/GEO.sav")
haven::write_sav(data1[data1$Faculty_2 == 2,], path = "~/surfdrive/Shared/OS Monitor 2022/Data/Data Analysis/Faculties/HUM.sav")
haven::write_sav(data1[data1$Faculty_2 == 3,,], path = "~/surfdrive/Shared/OS Monitor 2022/Data/Data Analysis/Faculties/REBO.sav")
haven::write_sav(data1[data1$Faculty_2 == 4,], path = "~/surfdrive/Shared/OS Monitor 2022/Data/Data Analysis/Faculties/GNK.sav")
haven::write_sav(data1[data1$Faculty_2 == 5,], path = "~/surfdrive/Shared/OS Monitor 2022/Data/Data Analysis/Faculties/BETA.sav")
haven::write_sav(data1[data1$Faculty_2 == 6,], path = "~/surfdrive/Shared/OS Monitor 2022/Data/Data Analysis/Faculties/FSW.sav")
haven::write_sav(data1[data1$Faculty_2 == 7,], path = "~/surfdrive/Shared/OS Monitor 2022/Data/Data Analysis/Faculties/DGK.sav")