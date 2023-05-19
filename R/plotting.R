# Produce & write a point plot with a gist of the results
source('calculate_bimanual_cost.R')

do_line_plot <- function(df_summary, descript_str) {
  
  p <- ggplot(data=df_summary, aes(x=full_condition_name, y=mean, colour=patient_label, group = subjName)) +
    geom_point(size = 2, alpha = 0.8) +
    geom_line(size = 0.75, alpha = 0.25) + 
    scale_color_manual(values=c("magenta", "turquoise")) +  # scale_color_brewer(palette = "Set2") +
    scale_x_discrete(guide = guide_axis(angle = 60))
  p
  
  ggsave(
    filename = file.path(outImageDir,paste0('lineplot',descript_str,'.png')),
    plot = p,
    width = cmwidth,
    height = cmheight,
    units = 'cm',
    dpi = 300,
    limitsize = TRUE,
  )
  
  return(p)
}

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
descript_str_DV = 'mean_reaction.time' # Modify me only!
curr_df_summary <- df_summary %>% select(subjName, patient_label, full_condition_name, mean = descript_str_DV)
curr_df_summary <- calculate_bimanual_cost(curr_df_summary)
p <- do_line_plot(curr_df_summary, descript_str_DV); p
p <- p + labs(title = 'mean_RT BI COST by Condition and Patient'); p





