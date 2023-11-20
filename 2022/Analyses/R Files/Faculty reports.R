library(knitr)
library(readr)
library(dplyr)
library(foreign)

faculties_path <- "~/surfdrive/Shared/OS Monitor 2022/Data/Data Analysis/Faculties"

filelist <- list.files(faculties_path)

for (file in filelist) {
  
  fp <- paste("~/surfdrive/Shared/OS Monitor 2022/Data/Data Analysis/Faculties/", file, sep="")
  
  # read in data
  data_full<- read.spss(fp, to.data.frame = TRUE)
  
  rmarkdown::render(input = "~/surfdrive/Shared/OS Monitor 2022/Data/Data Analysis/OSM 2022 Faculties.Rmd", 
                    output_format = "html_document",
                    output_file = paste0(gsub(".sav","", file), ".html"),
                    output_dir = "Faculty reports")
}
