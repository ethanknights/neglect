
# Produce & write a point plot with a gist of the results
p <- ggplot(data=df_summary, aes(x=full_condition_name, y=mean, colour=patient_label, group = subjName)) +
  geom_point(size = 2, alpha = 0.8) +
  geom_line(size = 0.75, alpha = 0.25) + 
  scale_color_manual(values=c("magenta", "turquoise")) +  # scale_color_brewer(palette = "Set2") +
  scale_x_discrete(guide = guide_axis(angle = 60))
p

# # Could use jitter (but not perfect either - too much jitter is odd and too little leads to overlap).
# p <- ggplot(data=df_summary, aes(x=full_condition_name, y=mean, group=subjName)) +
#   geom_point(aes(color=patient_label), size=2, position = position_dodge(width=0.2)) +
#   geom_line(aes(color=patient_label, group=interaction(patient_label, subjName)), size=0.2, alpha=0.25, position = position_dodge(width=0.75)) +
#   scale_color_manual(values=c("cyan", "magenta")) +
#   scale_x_discrete(guide=guide_axis(angle=60))
# 
# p

ggsave(
  filename = file.path(outImageDir,paste0('pointingError_allConditions',analysis_descript_str,'.png')),
  plot = p,
  width = cmwidth,
  height = cmheight,
  units = 'cm',
  dpi = 300,
  limitsize = TRUE,
)



