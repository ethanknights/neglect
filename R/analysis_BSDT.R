# BSDT() allows Deficit Test using difference between two tasks. 
# e.g. is difference of LH & RH different for patient vs. controls


do_BSTD <- function(conditionStrs, df_big_summary, descript_str) {
  # do_BSTD() runs all pairs of BSTDs that are defined in conditionStrs
  ## conditionStrs: List of strings [a,b] defining the pairs of tests to run (stored as [1,2; 3,4; 5,6; 7,8] etc.)
  ## df_big_summary: Tibble incl. $full_condition_name (matching the strings in conditionStrs), $patient_label ('patient' vs. 'control') & scores ($mean)
  ## descript_str: descriptive string used for output filenames describing this set of BSTDs (e.g. 'hand' for LH vs RH or 'condition' for UNI_LH vs. CON_LH or UNI_LH vs. INC_LH)
  
  outT <- as.data.frame(matrix(nrow = length(conditionStrs), ncol = 10))
  
  for (i in 1:length(conditionStrs)) { if(i %% 2) { # ToDo: use mod() or whatever is equivalent to iterate odd i only
    
    j = 1 # iterator to store data in outT
    
    conditionStr_a = conditionStrs[i]
    conditionStr_b = conditionStrs[i+1]
    print(c(i, conditionStr_a, 'vs', i+1, conditionStr_b))
    print(j)
    
    tmp_df_a <- df_big_summary[ df_big_summary$full_condition_name == conditionStr_a, ]
    tmp_df_b <- df_big_summary[ df_big_summary$full_condition_name == conditionStr_b, ]
    
    BSDT_res <- BSDT(
      case_a = tmp_df_a[tmp_df_a$patient_label == 'Patient','mean'],
      case_b = tmp_df_b[tmp_df_b$patient_label == 'Patient','mean'],
      controls_a = tmp_df_a[tmp_df_a$patient_label == 'Control','mean'],
      controls_b = tmp_df_b[tmp_df_b$patient_label == 'Control','mean'],
      alternative = c("two.sided"),
      int_level = 0.95,       
      iter = 10000,           
      unstandardised = FALSE, # default
      calibrated = TRUE       # default
    )
    
    # Write table:
    outT[i,1] <- paste(substr(conditionStr_a, start = 1, stop = 3),substr(conditionStr_b, start = 1, stop = 3), sep = ' vs. ')
    outT[i,2] <- paste(substr(conditionStr_a, start = 5, stop = 6),substr(conditionStr_b, start = 5, stop = 6), sep = ' vs. ')
    outT[i,3] <- paste(substr(conditionStr_a, start = 8, stop = 12),substr(conditionStr_b, start = 8, stop = 12), sep = ' vs. ')
    outT[i,4] <- round(BSDT_res$p.value, digits = 3)
    outT[i,5] <- round(BSDT_res$estimate[3], digits = 2)
    outT[i,6] <- round(BSDT_res$interval[2], digits = 2)
    outT[i,7] <- round(BSDT_res$interval[3], digits = 2)
    outT[i,8] <- round(BSDT_res$estimate[4], digits = 2)
    outT[i,9] <- round(BSDT_res$interval[4], digits = 2)
    outT[i,10] <- round(BSDT_res$interval[5], digits = 2)

    } } #for / if

  # Format output table
  colnames(outT) <- c("Condiiton",
                      "Hand",
                      "Target",
                      'p',
                      'Z-CC',
                      'CI Low.',
                      'CI Upp.',
                      'Prop. below case (%)',
                      'CI Low.',
                      'CI Upp.' )
  idx = outT == 0; idx[1:nrow(idx),3] = FALSE ## Overwrite pval 0 as "<.001" # dont replace target 0
  outT[idx] = "<.001"
  
  # Write output to ./derivatives
  fN = file.path(outDir, paste('Table_BSTD_',descript_str,'.csv', sep='') )
  print(c('Writing table:', fN))
  write.csv(outT, fN, row.names=FALSE)

} # do_BSDT()

  


# Reference: Print all available conditionStrs
# print(new_order) # inherited: load_data.R

# Define tests (a vs. b) for BSDT
## Compare Hands
descript_str = 'Hands'
conditionStrs = c( # Pairs of tests (a,b) as in 1,2; 3,4; 5,6; 7,8 etc.
  'UNI_LH_Far',   'UNI_RH_Far',
  'UNI_LH_Close', 'UNI_RH_Close',
  
  'CON_LH_Far',   'CON_RH_Far',
  'CON_LH_Close', 'CON_RH_Close',
  
  'INC_LH_Far',   'INC_RH_Far',
  'INC_LH_Close', 'INC_RH_Close'
)


do_BSTD(conditionStrs, df_big_summary, descript_str)

