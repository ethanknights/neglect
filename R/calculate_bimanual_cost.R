# Bimanual Cost:
# Positive = a cost to temporal vaiables for the bimanual version of an action.
# Negative = a benefit to remporal vvariables
# e.g.
# Bi = 2000ms, Uni = 800ms
# 2000-800 = 1200
# Bimanual cost = Doing action bimanually increased cost of behaviour by 1200ms.


calculate_bimanual_cost <- function(data) {
  bimanual_rows <- data %>%
    filter(grepl("CON|INC", full_condition_name)) %>%
    mutate(Unimanual_Condition = gsub("CON|INC", "UNI", full_condition_name))
  
  unimanual_data <- data %>%
    filter(full_condition_name %in% unique(bimanual_rows$Unimanual_Condition)) %>%
    select(subjName, full_condition_name, mean) %>%
    rename(Unimanual_Condition = full_condition_name, mean_unimanual = mean)
  
  bimanual_cost_df <- bimanual_rows %>%
    left_join(unimanual_data, by = c("subjName", "Unimanual_Condition")) %>%
    mutate(mean = mean - mean_unimanual) %>%
    select(subjName, patient_label, full_condition_name, mean)
  
  return(bimanual_cost_df)
}
