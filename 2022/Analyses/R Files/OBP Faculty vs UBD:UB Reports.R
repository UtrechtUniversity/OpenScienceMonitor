library(knitr)
library(readr)
library(dplyr)
library(foreign)

faculties_path <- "~/surfdrive/Shared/OS Monitor 2022/Data/Data Analysis/OBP Faculties vs UBD:UB"

filelist <- list.files(faculties_path)

for (file in filelist) {
  
  fp <- paste("~/surfdrive/Shared/OS Monitor 2022/Data/Data Analysis/OBP Faculties vs UBD:UB/", file, sep="")
  
  # read in data
  data_full<- read.spss(fp, to.data.frame = TRUE)
  
  rmarkdown::render(input = "~/surfdrive/Shared/OS Monitor 2022/Data/Data Analysis/OSM 2022 OBP Faculty vs UBD:UB.Rmd", 
                    output_format = "html_document",
                    output_file = paste0(gsub(".sav","", file), ".html"),
                    output_dir = "OSM 2022 OBP Faculty vs UBD:UB Reports")
}
