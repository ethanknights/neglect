do_BTD <- function(conditionStrs, df_summary, descript_str, analysis_descript_str) {
  # do_BTD() runs BTD for each condition defined in conditionStrs
  ## conditionStrs: List of strings defining the conditions to run BTD on
  ## df_summary: Tibble including $full_condition_name (matching the strings in conditionStrs), $patient_label ('patient' vs. 'control'), and scores ($mean)
  ## analysis_descript_str: Descriptive string for this analysis
  
  cat(paste0('Running do_BTD() for analysis: ', analysis_descript_str, '\n'))
  
  outT <- as.data.frame(matrix(nrow = length(conditionStrs), ncol = 10))
  
  for (i in 1:length(conditionStrs)) {
    
    conditionStr <- conditionStrs[i]
    print(c(i, conditionStr))
    
    tmp_df <- df_summary[df_summary$full_condition_name == conditionStr, ]
    
    BTD_res <- BTD(
      case = tmp_df[tmp_df$patient_label == 'Patient', 'mean'],
      controls = tmp_df[tmp_df$patient_label == 'Control', 'mean'],
      alternative = c("two.sided"),
      int_level = 0.95,
      iter = 10000
    )
    
    outT[i, 1] <- substr(conditionStr, start = 1, stop = 3)
    outT[i, 2] <- substr(conditionStr, start = 5, stop = 6)
    outT[i, 3] <- substr(conditionStr, start = 8, stop = 12)
    outT[i, 4] <- round(BTD_res$p.value, digits = 3)
    outT[i, 5] <- round(BTD_res$estimate[1], digits = 2)
    outT[i, 6] <- round(BTD_res$interval[2], digits = 2)
    outT[i, 7] <- round(BTD_res$interval[3], digits = 2)
    outT[i, 8] <- round(BTD_res$estimate[2], digits = 2)
    outT[i, 9] <- round(BTD_res$interval[4], digits = 2)
    outT[i, 10] <- round(BTD_res$interval[5], digits = 2)
    
  }
  
  # Format output table
  colnames(outT) <- c("Condition",
                      "Hand",
                      "Target",
                      'p',
                      'Z-CC',
                      'CI Low.',
                      'CI Upp.',
                      'Prop. below case (%)',
                      'CI Low.',
                      'CI Upp.' )
  idx <- outT == 0
  idx[1:nrow(idx), 3] <- FALSE
  outT[idx] <- "<.001"
  
  # Write output to ./derivatives
  fN = file.path(outDir, paste0('Table_BTD_',descript_str,analysis_descript_str,'.csv', sep='') )
  print(c('Writing table:', fN))
  write.csv(outT, fN, row.names = FALSE)
  
  return(outT)
}
