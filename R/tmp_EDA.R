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


