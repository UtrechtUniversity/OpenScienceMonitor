# Function to create attitude behavior gap tables
att_beh_gap <- function(position = NULL, faculty = NULL, data = NULL){
  if(is.null(position) & is.null(faculty)){
    data <- data
  } else{
    if(is.null(faculty) & !is.null(position)){
      data <- data[data$Pos_2 == position, ]
    } else{
      if (!is.null(faculty) & is.null(position)){
        data <- data[data$Faculty_2 == faculty,]
      }
    }
  }
  att_beh_gap <- matrix(nrow = 12, ncol = 7)
  dat_copy <- data
  for (i in 1:12){
    att <- names(dat_copy %>% select(Prac_Att_1:Prac_Att_12))[i]
    beh <- names(dat_copy %>% select(Prac_Beh_1:Prac_Beh_12))[i]
    
    dat_copy[,att] <- as.numeric(dat_copy[,att])
    dat_copy[,beh] <- as.numeric(dat_copy[,beh])
    
    res <- dat_copy %>%
      tidyr::gather(key = "variable", value = "score", att, beh) %>%
      mutate(ID = factor(ID), 
             variable = factor(variable),
             score = as.numeric(score)) %>%
      rstatix::anova_test(dv = score, wid = ID, within = variable, effect.size = 'pes')
    
    # get descriptives
    data_compl_attbeh <- dat_copy %>% 
      select(c(att, beh))
    data_compl_attbeh <- data_compl_attbeh[complete.cases(data_compl_attbeh), ]
    
    att_beh_gap[i,1] <- mean(data_compl_attbeh[,1])
    att_beh_gap[i,2] <- sd(data_compl_attbeh[,1])
    att_beh_gap[i,3] <- mean(data_compl_attbeh[,2])
    att_beh_gap[i,4] <- sd(data_compl_attbeh[,2])
    att_beh_gap[i,5] <- nrow(data_compl_attbeh)
    att_beh_gap[i,6] <- res$p
    att_beh_gap[i,7] <- res$pes
  }
  colnames(att_beh_gap) <- c("Mean Attitude", "SD Attitude", "Mean Behavior", "SD Behavior", "N", "p-value", "Partial Eta-squared")
  
  rownames(att_beh_gap) <- c("Preregistration", "Pre-prints", "Open Access Publishing", "Open Data", "Open Research Materials", "Open Code", "Open Source Software", "Public Engagement", "Societal Stakeholder Involvement", "Team Science", "Open Science Teaching", "Open Education Resources")
  
  att_beh_gap <- as.data.frame(att_beh_gap) %>%
    mutate(`SE Attitude` = `SD Attitude`/sqrt(`N`),
           `SE Behavior` = `SD Behavior`/sqrt(`N`),
           `Att CI Lower` = `Mean Attitude`-1.96*`SE Attitude`,
           `Att CI Upper` = `Mean Attitude`+1.96*`SE Attitude`,
           `Beh CI Lower` = `Mean Behavior`-1.96*`SE Behavior`,
           `Beh CI Upper` = `Mean Behavior`+1.96*`SE Behavior`)
  return(att_beh_gap)
}