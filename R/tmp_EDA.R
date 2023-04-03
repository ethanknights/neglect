# initial EDA


# How is Patient?
#tmp = summary[summary['subjName'] == 'EB',]
tmp = summary

# gist plot
p <- ggplot(data=df_big_summary, aes(x=full_condition_name, colour=patient_label)) +
  geom_point(aes(y = mean)) + 
               scale_x_discrete(guide = guide_axis(angle = 60))
p


# Plot pointing coordinates
## assert no missing coordinates (xls formulae...)
tmp = df[which(is.na(df$Zerodx)),]
tmp = df[which(is.na(df$Zerody)),] 
# artificial shift for plotting
df$Zerodx_shift[df$hand_name == 'LH'] = df$Zerodx[df$hand_name == 'LH'] - 200
df$Zerodx_shift[df$hand_name == 'RH'] = df$Zerodx[df$hand_name == 'RH'] + 200


p <- ggplot(data=df, aes(colour=patient_label)) +
  geom_point(aes(x = Zerodx_shift, y = Zerody)) + 
  scale_x_discrete(guide = guide_axis(angle = 60))
p
p + facet_grid(cols = vars(full_condition_name))




# Reminder: Main singcar funcions:
# BTD() which supersedes Deficit test i.e. TD().
# e.g. Is LH error different than controls? 

# BSDT() which allows Deficit Test using difference between two tasks. 
# e.g. is difference of LH & RH different for patient vs. controls

#--- do BTD ---#


# For reference & future EDA: This snippet examples running a BTD for a single condition
# outT_UNI_LH_LH_Far <- as.data.frame(matrix(nrow = 10, ncol = 10))
# 
# tmp_df = df_big_summary
# tmp_df = tmp_df[tmp_df$full_condition_name == 'UNI-LH_LH_Far',]
# 
# BTD_res <- BTD(
#   case = tmp_df[tmp_df$patient_label == 'Patient','mean'],
#   controls = tmp_df[tmp_df$patient_label == 'Control','mean'],
#   alternative = c("two.sided"),
#   int_level = 0.95,
#   iter = 10000)
#
# i = 1  # lazy iteration!
# outT_UNI_LH_LH_Far[i,1] <- 'UNI-LH'
# outT_UNI_LH_LH_Far[i,2] <- 'LH'
# outT_UNI_LH_LH_Far[i,3] <- 'Far'
# outT_UNI_LH_LH_Far[i,4] <- round(BTD_res$p.value, digits = 3)
# outT_UNI_LH_LH_Far[i,5] <- round(BTD_res$estimate[1], digits = 2)
# outT_UNI_LH_LH_Far[i,6] <- round(BTD_res$interval[2], digits = 2)
# outT_UNI_LH_LH_Far[i,7] <- round(BTD_res$interval[3], digits = 2)
# outT_UNI_LH_LH_Far[i,8] <- round(BTD_res$estimate[2], digits = 2)
# outT_UNI_LH_LH_Far[i,9] <- round(BTD_res$interval[4], digits = 2)
# outT_UNI_LH_LH_Far[i,10] <- round(BTD_res$interval[5], digits = 2)

# Run all BTDs
conditionStrs = new_order # inherited: load_data.R
outT <- as.data.frame(matrix(nrow = length(conditionStrs), ncol = 10))

for (i in 1:length(conditionStrs)) {
  
  conditionStr = conditionStrs[i]
  print(c(i, conditionStr))
  
  tmp_df = df_big_summary[df_big_summary$full_condition_name == conditionStr,]
  
  BTD_res <- BTD(
    case = tmp_df[tmp_df$patient_label == 'Patient','mean'],
    controls = tmp_df[tmp_df$patient_label == 'Control','mean'],
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

# format table
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
#0 to "<.001"
idx = outT == 0; idx[1:nrow(idx),3] = FALSE #dont replace target 0
outT[idx] = "<.001"
