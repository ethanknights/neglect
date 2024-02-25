# Produce & write a point plot with a gist of the results
source('calculate_bimanual_cost.R')

do_line_plot <- function(df_summary, descript_str, y_lim_lo = NULL, y_lim_hi = NULL) {

  p <- ggplot() +
    geom_line(data = df_summary[df_summary$patient_label == "Control", ], 
              aes(x = full_condition_name, y = mean, linetype = patient_label, group = subjName),
              size = 0.8, alpha = 0.8, color = "cyan") +
    geom_line(data = df_summary[df_summary$patient_label == "Patient", ], 
              aes(x = full_condition_name, y = mean, linetype = patient_label, group = subjName),
              size = 0.8, alpha = 0.8, color = "magenta") +
    geom_point(data = df_summary[df_summary$patient_label == "Control", ], 
               aes(x = full_condition_name, y = mean, colour = patient_label, group = subjName),
               size = 4, alpha = 0.8, shape = 21, fill = "cyan", color = "black") +
    geom_point(data = df_summary[df_summary$patient_label == "Patient", ], 
               aes(x = full_condition_name, y = mean, colour = patient_label, group = subjName),
               size = 4, alpha = 0.8, shape = 21, fill = "magenta", color = "black") +
    scale_linetype_manual(values = c("dashed", "solid")) +
    scale_x_discrete(guide = guide_axis(angle = 60)) +
    theme(panel.background = element_blank(), panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"), 
          legend.position = "none"); p
    if (!is.null(y_lim_lo) && !is.null(y_lim_hi)) {
      p <- p + scale_y_continuous(limits = c(y_lim_lo, y_lim_hi))
    }
  
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
p <- do_line_plot(curr_df_summary, paste0(descript_str_DV, '_', 'BI_cost'), 0, 10); p
p <- p + labs(title = 'mean_Pointing_Error BI COST by Condition and Patient'); p

descript_str_DV = 'mean_reaction.time' # Modify me only!
curr_df_summary <- df_summary %>% select(subjName, patient_label, full_condition_name, mean = descript_str_DV)
curr_df_summary <- calculate_bimanual_cost(curr_df_summary)
p <- do_line_plot(curr_df_summary, paste0(descript_str_DV, '_', 'BI_cost'), -400, 400); p
p <- p + labs(title = 'mean_RT BI COST by Condition and Patient'); p

descript_str_DV = 'mean_movement.time' # Modify me only!
curr_df_summary <- df_summary %>% select(subjName, patient_label, full_condition_name, mean = descript_str_DV)
curr_df_summary <- calculate_bimanual_cost(curr_df_summary)
p <- do_line_plot(curr_df_summary, paste0(descript_str_DV, '_', 'BI_cost'), -400, 400); p
p <- p + labs(title = 'mean_MT BI COST by Condition and Patient'); p

descript_str_DV = 'mean_PV' # Modify me only!
curr_df_summary <- df_summary %>% select(subjName, patient_label, full_condition_name, mean = descript_str_DV)
curr_df_summary <- calculate_bimanual_cost(curr_df_summary)
p <- do_line_plot(curr_df_summary, paste0(descript_str_DV, '_', 'BI_cost')); p
p <- p + labs(title = 'mean_PV BI COST by Condition and Patient'); p
