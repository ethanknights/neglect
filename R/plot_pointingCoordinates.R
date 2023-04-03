
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
# ggsave(file.path(outImageDir,'pointingCoordinates_allConditions.png'), plot = p)

# png(file.path(outImageDir,'pointingCoordinates_allConditions.png'))
# print(p)
# dev.off()

# ggsave(
#   filename = file.path(outImageDir,'pointingcoordinates_allConditions.png'),
#   plot = p,
#   width = cmwidth,
#   height = cmheight,
#   units = 'cm',
#   dpi = 300,
#   limitsize = TRUE,
# )