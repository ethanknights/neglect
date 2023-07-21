#PURPOSE:
#Load Data from .csv table
#==================================================================
library(ggplot2)
library(dplyr)
library(tidyverse)
library(singcar) #v0.1.3
require(gdata)
rm(list = ls()) # clears environment
cat("\f") # clears console
dev.off() # clears graphics device
graphics.off() #clear plots


#---- Setup ----#
# wd = '/Users/ethanknights/PycharmProjects/neglect'  # Lineage
wd = dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(wd)

rawDir = '../data'

outDir = 'derivatives'
outImageDir = file.path(outDir,'images')
dir.create(outDir,showWarnings = FALSE)
dir.create(outImageDir,showWarnings = FALSE)

cmheight = 18
cmwidth = 18

# Load Data
rawD <- read.csv(file.path(rawDir,'UNIBI.csv'), header=TRUE, sep=",")
df = rawD; rm(rawD)

# Add full_condition_name (e.g. UNI-LH-LH-Far, BICON-RH-Close)
df['full_condition_name'] <- paste(df$condition_name, df$hand_name, sep = "_")
df = df %>% relocate(full_condition_name, .after=subjName)

# Add patient/control label column
## NB: Subset to just patient with:  df['patient_label'] = df['subjName'] == 'EB'
df['patient_label'] = ''  # init 
df['patient_label'][df['subjName'] == 'EB'] = 'Patient'
df['patient_label'][df['subjName'] != 'EB'] = 'Control'
df = df %>% relocate(patient_label, .after=subjName)

#Calculate Pointing_Error (distance error)
df['Pointing_Error'] = sqrt(
  df[,'X.Error'] ^ 2 + df[,'Y.Error'] ^ 2
)

# Global string to append to analysis derivative files
analysis_descript_str = ''

# Prepare df_summary (i.e. not collapsing any conditions/hands/targets)
df_summary <- group_by(df, subjName, full_condition_name, patient_label)
df_summary <- summarise(df_summary, 
                        mean_Pointing_Error = mean(Pointing_Error),
                        sd_Pointing_Error = sd(Pointing_Error),
                        mean_reaction.time = mean(reaction.time),
                        sd_reaction.time = sd(reaction.time),
                        mean_movement.time = mean(movement.time),
                        sd_movement.time = sd(movement.time),
                        mean_PV = mean(PV),
                        sd_PV = sd(PV)
                        )

# Re-order the levels
new_order <- c(	
  'UNI_LH',	
  'UNI_RH',	
  
  'CON_LH',	
  'CON_RH',	
  
  'INC_LH',	
  'INC_RH'	
)	

df_summary$full_condition_name <- reorder.factor(df_summary$full_condition_name, new.order = new_order)
df_summary = df_summary %>%
  arrange(full_condition_name)

## Reorder summary table (patient first, alphaebtical control)
df_summary = rbind(df_summary[df_summary['subjName'] == 'EB',], df_summary[df_summary['subjName'] != 'EB',])  # versatile for plotting single controls (i.e. ignore patient_label)!

# Reorder factor patient labels so patient on top in plots
df_summary$patient_label <- factor(df_summary$patient_label, levels = c("Patient", "Control"))



# Next source:   run_analysis.R
# Next source:   run_bimanualCost_analysis.R

# Next source:   plotting.R
