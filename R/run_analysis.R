# Purpose; Run all analyses (BTD and BSDTs) for Deficit Test inferences.
# Writes BTD()/BSTD analysis output tables (BTDs: UNI_LH_Far, UNI_LH_Close etc.) to ./derivatives/

# Run all BTDs
source("do_BTD.R")

descript_str = 'Main'
conditionStrs = new_order # inherited: load_data.R

descript_str_DV = 'mean_Pointing_Error' # Modify me only!
curr_df_summary <- df_summary %>% select(subjName, patient_label, full_condition_name, mean = descript_str_DV)
outT <- do_BTD(conditionStrs, curr_df_summary, paste0(descript_str, '_', descript_str_DV), analysis_descript_str)

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
source("do_BSDT.R")
#### COMPARE HANDS ####
descript_str = 'Hands'
conditionStrs = c( # Pairs of tests (a,b) as in 1,2; 3,4; 5,6; 7,8 etc.
  'UNI_LH',   'UNI_RH',

  'CON_LH',   'CON_RH',
  
  'INC_LH',   'INC_RH'
)

descript_str_DV = 'mean_reaction.time' # Modify me only!
curr_df_summary <- df_summary %>% select(subjName, patient_label, full_condition_name, mean = descript_str_DV)
outT <- do_BSDT(conditionStrs, curr_df_summary, paste0(descript_str, '_', descript_str_DV), analysis_descript_str)

descript_str_DV = 'mean_movement.time' # Modify me only!
curr_df_summary <- df_summary %>% select(subjName, patient_label, full_condition_name, mean = descript_str_DV)
outT <- do_BSDT(conditionStrs, curr_df_summary, paste0(descript_str, '_', descript_str_DV), analysis_descript_str)

descript_str_DV = 'mean_PV' # Modify me only!
curr_df_summary <- df_summary %>% select(subjName, patient_label, full_condition_name, mean = descript_str_DV)
outT <- do_BSDT(conditionStrs, curr_df_summary, paste0(descript_str, '_', descript_str_DV), analysis_descript_str)


#### COMPARE CONDITIONS ####
descript_str = 'Conditions'
conditionStrs = c( # Pairs of tests (a,b) as in 1,2; 3,4; 5,6; 7,8 etc.
  'UNI_LH',   'CON_LH',
  'UNI_LH',   'INC_LH',
  'CON_LH',   'INC_LH',
  
  'UNI_RH',   'CON_RH',
  'UNI_RH',   'INC_RH',
  'CON_RH',   'INC_RH'
)

descript_str_DV = 'mean_reaction.time' # Modify me only!
curr_df_summary <- df_summary %>% select(subjName, patient_label, full_condition_name, mean = descript_str_DV)
outT <- do_BSDT(conditionStrs, curr_df_summary, paste0(descript_str, '_', descript_str_DV), analysis_descript_str)

descript_str_DV = 'mean_movement.time' # Modify me only!
curr_df_summary <- df_summary %>% select(subjName, patient_label, full_condition_name, mean = descript_str_DV)
outT <- do_BSDT(conditionStrs, curr_df_summary, paste0(descript_str, '_', descript_str_DV), analysis_descript_str)

descript_str_DV = 'mean_PV' # Modify me only!
curr_df_summary <- df_summary %>% select(subjName, patient_label, full_condition_name, mean = descript_str_DV)
outT <- do_BSDT(conditionStrs, curr_df_summary, paste0(descript_str, '_', descript_str_DV), analysis_descript_str)


