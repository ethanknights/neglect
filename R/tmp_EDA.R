# initial EDA


# How is Patient?
#tmp = summary[summary['subjName'] == 'EB',]
tmp = summary

# gist plot
p <- ggplot(data=df_big_summary, aes(x=full_condition_name, colour=patient_label)) +
  geom_point(aes(y = mean)) + 
               scale_x_discrete(guide = guide_axis(angle = 60))
p



# Reminder: Main singcar funcions:
# BTD() which supersedes Deficit test i.e. TD().
# e.g. Is LH error different than controls? 

# BSDT() which allows Deficit Test using difference between two tasks. 
# e.g. is difference of LH & RH different for patient vs. controls


