# initial EDA
grouped <- group_by(df, subjName, condition_name, hand_name, target_name)
summary <- summarise(grouped, mean=mean(Pointing_Error), sd=sd(Pointing_Error))

# How is Patient?
tmp = summary[summary['subjName'] == 'EB',]