# Purpose: Check trial distributions using single case study statistics.

library(singcar) #v0.1.3
library(tidyr)

rm(list = ls()) # clears environment
cat("\f") # clears console

# wd = '/Users/ethanknights/PycharmProjects/neglect'  # Lineage
wd = dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(wd)

rawDir = '../extra_data_trial_distributions'

outDir = 'derivatives'
outImageDir = file.path(outDir,'images')
dir.create(outDir,showWarnings = FALSE)
dir.create(outImageDir,showWarnings = FALSE)

cmheight = 18
cmwidth = 18


do_BTD <- function(conditionStrs, df_summary, descript_str) {
  # This function is a quick hack of do_BSTD() - see analysis_BSDT.R 

  outT <- as.data.frame(matrix(nrow = length(conditionStrs), ncol = 10))
  
  for (i in 1:length(conditionStrs)) {
    
    conditionStr = conditionStrs[i]
    print(c(i, conditionStr))
    
    idx = which(conditionStr == colnames(df_summary))
  
    tmp_df = df_summary[,idx]
    
    if ( nrow(unique(tmp_df[,1])) > 1 )  {
      # If all values being the same for case & controls (i.e. definitely no singe-case effect!):
      # Error in quantile.default(z_ast, c(alpha/2, (1 - alpha/2))) : 
      #  missing values and NaN's not allowed if 'na.rm' is FALSE
    
      BTD_res <- BTD(
        case = tmp_df[1,],
        controls = tmp_df[-1,],
        alternative = c("two.sided"),
        int_level = 0.95,
        iter = 10000)
      
      outT[i,1] <- substr(conditionStr, start = 1, stop = 3)
      outT[i,2] <- substr(conditionStr, start = 5, stop = 6)
      outT[i,3] <- substr(conditionStr, start = 8, stop = 12)
      outT[i,4] <- round(BTD_res$p.value, digits = 3)
      outT[i,5] <- round(BTD_res$estimate[1], digits = 2)
      outT[i,6] <- round(BTD_res$interval[2], digits = 2)
      outT[i,7] <- round(BTD_res$interval[3], digits = 2)
      outT[i,8] <- round(BTD_res$estimate[2], digits = 2)
      outT[i,9] <- round(BTD_res$interval[4], digits = 2)
      outT[i,10] <- round(BTD_res$interval[5], digits = 2)

    }
    
  }
  
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
  
  # if analysis IS collapsing targets, drop target colmumn in output table
  #if (analysis_descript_str != '_extra-notCollapsed') { 
    outT = outT[, -which(names(outT) == "Target")]
  #}
    
    write.csv(outT,file.path(outDir,paste0('checkTrialDistributions-',descript_str,'_Table_BTD','.csv')), row.names=FALSE)
    return(outT) 
}


wrapper_do_BTD <- function(descript_str) {
  
  #condition Strings that match above df_mean:
  conditionStrs <- c(
    'UNI_LH',
    'UNI_RH',
    
    'CON_LH',
    'CON_RH',
    
    'INC_LH',
    'INC_RH'
  )
  
  df <- read.xls(file.path(rawDir,'trialDistributions_exp2.xlsx'), header=TRUE, sep=",",
                 sheet = descript_str)
  df <- df %>% rename(Participant = Partipant)
  
  df_summary <- df %>% # mean-collapse target
    rowwise() %>% 
    mutate(UNI_LH = mean(c(UNI_LH_Far, UNI_LH_Close)),
           UNI_RH = mean(c(UNI_RH_Far, UNI_RH_Close)),
           CON_LH = mean(c(CON_LH_Far, CON_LH_Close)),
           CON_RH = mean(c(CON_RH_Far, CON_RH_Close)),
           INC_LH = mean(c(INC_LH_Far, INC_LH_Close)),
           INC_RH = mean(c(INC_RH_Far, INC_RH_Close))) %>% 
    ungroup() %>% 
    select(Participant, UNI_LH, UNI_RH, CON_LH, CON_RH, INC_LH, INC_RH)
  
  outT = do_BTD(conditionStrs,df_summary, descript_str)
  
  return(list(outT, df_summary))
  
}


output_nTrialsCollected <- wrapper_do_BTD('nTrialsCollected')
output_nNoResponses <- wrapper_do_BTD('nNoResponses')
output_nHandError <- wrapper_do_BTD('nHandError')
output_nEquipmentErrors <- wrapper_do_BTD('nEquipmentErrors')
output_nTrialsAnalysed <- wrapper_do_BTD('nTrialsAnalysed')

# percentgagess

sum(unlist(output_nEquipmentErrors[2])) / sum(unlist(output_nTrialsAnalysed[2])) * 100
sum(unlist(output_nHandError[2])) / sum(unlist(output_nTrialsAnalysed[2])) * 100







