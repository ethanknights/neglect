# Purpose; Run all analyses (BTD and BSDTs) for Deficit Test inferences.
# Writes BTD()/BSTD analysis output tables (BTDs: UNI_LH_Far, UNI_LH_Close etc.) to ./derivatives/

# Run all BTDs
source("do_BTD.R")

descript_str = 'Main' 
conditionStrs = new_order # inherited: load_data.R

descript_str_DV = 'mean_reaction.time' # Modify me only!
curr_df_summary <- df_summary %>% select(subjName, patient_label, full_condition_name, mean = descript_str_DV)
outT <- do_BTD(conditionStrs, curr_df_summary, paste0(descript_str, '_', descript_str_DV), analysis_descript_str)

descript_str_DV = 'mean_movement.time' # Modify me only!
curr_df_summary <- df_summary %>% select(subjName, patient_label, full_condition_name, mean = descript_str_DV)
outT <- do_BTD(conditionStrs, curr_df_summary, paste0(descript_str, '_', descript_str_DV), analysis_descript_str)

descript_str_DV = 'PV' # Modify me only!
curr_df_summary <- df_summary %>% select(subjName, patient_label, full_condition_name, mean = descript_str_DV)
outT <- do_BTD(conditionStrs, curr_df_summary, paste0(descript_str, '_', descript_str_DV), analysis_descript_str)


# Run all BSTDs
source("do_BSTD.R")
#### COMPARE HANDS ####
descript_str = 'Hands'
conditionStrs = c( # Pairs of tests (a,b) as in 1,2; 3,4; 5,6; 7,8 etc.
  'UNI_LH_Far',   'UNI_RH_Far',
  'UNI_LH_Close', 'UNI_RH_Close',
  
  'CON_LH_Far',   'CON_RH_Far',
  'CON_LH_Close', 'CON_RH_Close',
  
  'INC_LH_Far',   'INC_RH_Far',
  'INC_LH_Close', 'INC_RH_Close'
)

descript_str_DV = 'mean_reaction.time' # Modify me only!
curr_df_summary <- df_summary %>% select(subjName, patient_label, full_condition_name, mean = descript_str_DV)
outT <- do_BSTD(conditionStrs, curr_df_summary, paste0(descript_str, '_', descript_str_DV), analysis_descript_str)

descript_str_DV = 'mean_movement.time' # Modify me only!
curr_df_summary <- df_summary %>% select(subjName, patient_label, full_condition_name, mean = descript_str_DV)
outT <- do_BSTD(conditionStrs, curr_df_summary, paste0(descript_str, '_', descript_str_DV), analysis_descript_str)

descript_str_DV = 'mean_PV' # Modify me only!
curr_df_summary <- df_summary %>% select(subjName, patient_label, full_condition_name, mean = descript_str_DV)
outT <- do_BSTD(conditionStrs, curr_df_summary, paste0(descript_str, '_', descript_str_DV), analysis_descript_str)


#### COMPARE CONDITIONS ####
descript_str = 'Conditions'
conditionStrs = c( # Pairs of tests (a,b) as in 1,2; 3,4; 5,6; 7,8 etc.
  'UNI_LH_Far',   'CON_LH_Far',
  'UNI_LH_Far',   'INC_LH_Far',
  'CON_LH_Far',   'INC_LH_Far',
  
  'UNI_LH_Close',   'CON_LH_Close',
  'UNI_LH_Close',   'INC_LH_Close',
  'CON_LH_Close',   'INC_LH_Close',
  
  'UNI_RH_Far',   'CON_RH_Far',
  'UNI_RH_Far',   'INC_RH_Far',
  'CON_RH_Far',   'INC_RH_Far',
  
  'UNI_RH_Close',   'CON_RH_Close',
  'UNI_RH_Close',   'INC_RH_Close',
  'CON_RH_Close',   'INC_RH_Close'
)

descript_str_DV = 'mean_reaction.time' # Modify me only!
curr_df_summary <- df_summary %>% select(subjName, patient_label, full_condition_name, mean = descript_str_DV)
outT <- do_BSTD(conditionStrs, curr_df_summary, paste0(descript_str, '_', descript_str_DV), analysis_descript_str)

descript_str_DV = 'mean_movement.time' # Modify me only!
curr_df_summary <- df_summary %>% select(subjName, patient_label, full_condition_name, mean = descript_str_DV)
outT <- do_BSTD(conditionStrs, curr_df_summary, paste0(descript_str, '_', descript_str_DV), analysis_descript_str)

descript_str_DV = 'mean_PV' # Modify me only!
curr_df_summary <- df_summary %>% select(subjName, patient_label, full_condition_name, mean = descript_str_DV)
outT <- do_BSTD(conditionStrs, curr_df_summary, paste0(descript_str, '_', descript_str_DV), analysis_descript_str)


#### COMPARE TARGETS ####
descript_str = 'Targets'
conditionStrs = c( # Pairs of tests (a,b) as in 1,2; 3,4; 5,6; 7,8 etc.
  'UNI_LH_Far',   'UNI_LH_Close',
  'CON_LH_Far',   'CON_LH_Close',
  'INC_LH_Far',   'INC_LH_Close',
  
  'UNI_RH_Far',   'UNI_RH_Close',
  'CON_RH_Far',   'CON_RH_Close',
  'INC_RH_Far',   'INC_RH_Close'
)

descript_str_DV = 'mean_reaction.time' # Modify me only!
curr_df_summary <- df_summary %>% select(subjName, patient_label, full_condition_name, mean = descript_str_DV)
outT <- do_BSTD(conditionStrs, curr_df_summary, paste0(descript_str, '_', descript_str_DV), analysis_descript_str)

descript_str_DV = 'mean_movement.time' # Modify me only!
curr_df_summary <- df_summary %>% select(subjName, patient_label, full_condition_name, mean = descript_str_DV)
outT <- do_BSTD(conditionStrs, curr_df_summary, paste0(descript_str, '_', descript_str_DV), analysis_descript_str)

descript_str_DV = 'mean_PV' # Modify me only!
curr_df_summary <- df_summary %>% select(subjName, patient_label, full_condition_name, mean = descript_str_DV)
outT <- do_BSTD(conditionStrs, curr_df_summary, paste0(descript_str, '_', descript_str_DV), analysis_descript_str)

