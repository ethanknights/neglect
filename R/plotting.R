# Produce & write a point plot with a gist of the results
source('calculate_bimanual_cost.R')

# Rearrange df rows so patient at bottom, for ggplot order
df_summary <- df_summary %>%
  arrange(factor(patient_label, levels = c("Control", "Patient")), subjName)

do_line_plot <- function(df_summary, descript_str) {

  p <- ggplot(data = df_summary, aes(x = full_condition_name, y = mean, colour = patient_label, group = subjName)) +
    geom_point(size = 4, alpha = 0.8, shape = 21, aes(fill = patient_label)) +
    geom_point(size = 4, alpha = 0.8, shape = 21, colour = "black", stroke = 0.6) +
    geom_line(size = 0.8, alpha = 0.8, aes(linetype = patient_label)) +
    scale_color_manual(values = c("magenta", "cyan")) +
    scale_fill_manual(values = c("magenta", "cyan")) +
    scale_linetype_manual(values = c("solid", "dashed")) +
    scale_x_discrete(guide = guide_axis(angle = 60)) +
    theme(panel.background = element_blank(), panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
  p

  ggsave(filename = file.path(outImageDir, paste0('lineplot', descript_str, '.png')),
         plot = p,
         width = 15,  #width = cmwidth,
         height = 9,  #height = cmheight,
         units = 'cm',
         dpi = 300,
         limitsize = TRUE)
  return(p)}

descript_str_DV = 'mean_Pointing_Error' # Modify me only!
curr_df_summary <- df_summary %>% select(subjName, patient_label, full_condition_name, mean = descript_str_DV)
p <- do_line_plot(curr_df_summary, descript_str_DV); p
p <- p + labs(title = 'Mean Pointing Error by Condition and Patient'); p

descript_str_DV = 'mean_reaction.time' # Modify me only!
curr_df_summary <- df_summary %>% select(subjName, patient_label, full_condition_name, mean = descript_str_DV)
p <- do_line_plot(curr_df_summary, descript_str_DV); p
p <- p + labs(title = 'Mean Reaction Time by Condition and Patient'); p

descript_str_DV = 'mean_movement.time' # Modify me only!
curr_df_summary <- df_summary %>% select(subjName, patient_label, full_condition_name, mean = descript_str_DV)
p <- do_line_plot(curr_df_summary, descript_str_DV); p
p <- p + labs(title = 'Mean movement Time by Condition and Patient'); p

descript_str_DV = 'mean_PV' # Modify me only!
curr_df_summary <- df_summary %>% select(subjName, patient_label, full_condition_name, mean = descript_str_DV)
p <- do_line_plot(curr_df_summary, descript_str_DV); p
p <- p + labs(title = 'mean_PV by Condition and Patient'); p


# BiCost
descript_str_DV = 'mean_Pointing_Error' # Modify me only!
curr_df_summary <- df_summary %>% select(subjName, patient_label, full_condition_name, mean = descript_str_DV)
curr_df_summary <- calculate_bimanual_cost(curr_df_summary)
p <- do_line_plot(curr_df_summary, paste0(descript_str_DV, '_', 'BI_cost')); p
p <- p + labs(title = 'mean_Pointing_Error BI COST by Condition and Patient'); p

descript_str_DV = 'mean_reaction.time' # Modify me only!
curr_df_summary <- df_summary %>% select(subjName, patient_label, full_condition_name, mean = descript_str_DV)
curr_df_summary <- calculate_bimanual_cost(curr_df_summary)
p <- do_line_plot(curr_df_summary, paste0(descript_str_DV, '_', 'BI_cost')); p
p <- p + labs(title = 'mean_RT BI COST by Condition and Patient'); p

descript_str_DV = 'mean_movement.time' # Modify me only!
curr_df_summary <- df_summary %>% select(subjName, patient_label, full_condition_name, mean = descript_str_DV)
curr_df_summary <- calculate_bimanual_cost(curr_df_summary)
p <- do_line_plot(curr_df_summary, paste0(descript_str_DV, '_', 'BI_cost')); p
p <- p + labs(title = 'mean_MT BI COST by Condition and Patient'); p

descript_str_DV = 'mean_PV' # Modify me only!
curr_df_summary <- df_summary %>% select(subjName, patient_label, full_condition_name, mean = descript_str_DV)
curr_df_summary <- calculate_bimanual_cost(curr_df_summary)
p <- do_line_plot(curr_df_summary, paste0(descript_str_DV, '_', 'BI_cost')); p
p <- p + labs(title = 'mean_PV BI COST by Condition and Patient'); p
