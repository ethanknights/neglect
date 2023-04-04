# BSDT() allows Deficit Test using difference between two tasks. 
# e.g. is difference of LH & RH different for patient vs. controls


do_BSTD <- function(conditionStrs, df_big_summary, descript_str) {
  # do_BSTD() runs all pairs of BSTDs that are defined in conditionStrs
  ## conditionStrs: List of strings [a,b] defining the pairs of tests to run (stored as [1,2; 3,4; 5,6; 7,8] etc.)
  ## df_big_summary: Tibble incl. $full_condition_name (matching conditionStrs), $patient_label (patient vs. control) & scores (mean)
  ## descript_str: descriptive string used for output filenames describing this set of BSTDs (e.g. 'hand' for LH vs RH or 'condition' for UNI_LH vs. CON_LH or UNI_LH vs. INC_LH)
  
  outT <- as.data.frame(matrix(nrow = length(conditionStrs), ncol = 10))
  
  for (i in 1:length(conditionStrs)) { # ToDo: use mod() or whatever is equivalent to iterate odd i only
    
    conditionStr_a = conditionStrs[i]
    conditionStr_b = conditionStrs[i+1]
    print(c(i, conditionStr_a, 'vs', i+1, conditionStr_b))
    
    tmp_df_a <- df_big_summary[ df_big_summary$full_condition_name == conditionStr_a, ]
    tmp_df_b <- df_big_summary[ df_big_summary$full_condition_name == conditionStr_b, ]
    
    BSDT_res <- BSDT(
      case_a = tmp_df_a[tmp_df_a$patient_label == 'Patient','mean'],
      case_b = tmp_df_b[tmp_df_a$patient_label == 'Patient','mean'],
      controls_a = tmp_df_a[tmp_df_a$patient_label == 'Control','mean'],
      controls_b = tmp_df_b[tmp_df_b$patient_label == 'Control','mean'],
      # sd_a = NULL,          # We provided vector of controls scores, so unnecessary (see ?BSTD)
      # sd_b = NULL,          # We provided vector of controls scores, so unnecessary (see ?BSTD)
      # sample_size = NULL,   # We provided vector of controls scores for a & b, so unnecessary (see ?BSTD)
      # r_ab = NULL,          # We provided vector of controls scores for a & b, so unnecessary (see ?BSTD)
      alternative = c("two.sided"),
      int_level = 0.95,       
      iter = 10000,           
      unstandardised = FALSE, # default
      calibrated = TRUE       # default
    )
    
    # ToDo: Fix writing table:
    # outT[i,1] <- substr(conditionStr, start = 1, stop = 3)
    # outT[i,2] <- substr(conditionStr, start = 5, stop = 6)
    # outT[i,3] <- substr(conditionStr, start = 8, stop = 12)
    # outT[i,4] <- round(BSTD_res$p.value, digits = 3)
    # outT[i,5] <- round(BSTD_res$estimate[1], digits = 2)
    # outT[i,6] <- round(BSTD_res$interval[2], digits = 2)
    # outT[i,7] <- round(BSTD_res$interval[3], digits = 2)
    # outT[i,8] <- round(BSTD_res$estimate[2], digits = 2)
    # outT[i,9] <- round(BSTD_res$interval[4], digits = 2)
    # outT[i,10] <- round(BSTD_res$interval[5], digits = 2)
    
  }
  
  # ToDo: Fix formatting output table
  # colnames(outT) <- c("Condiiton",
  #                     "Hand", 
  #                     "Target", 
  #                     'p',
  #                     'Z-CC',
  #                     'CI Low.', 
  #                     'CI Upp.', 
  #                     'Prop. below case (%)', 
  #                     'CI Low.', 
  #                     'CI Upp.' )
  # idx = outT == 0; idx[1:nrow(idx),3] = FALSE ## Overwrite pval 0 as "<.001" # dont replace target 0
  # outT[idx] = "<.001"
  
  
  # ToDo: Fix Write output to ./derivatives
  # write.csv(outT,file.path(outDir,'Table_BSTD.csv'),row.names=FALSE)
  # 
}


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

