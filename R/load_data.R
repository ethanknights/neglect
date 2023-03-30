#PURPOSE:
#Load Data from .csv table
#==================================================================
library(ggplot2)
library(dplyr)
library(tidyverse)
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

pxheight = 600
pxwidth = 800

#---- Load Data ----#
rawD <- read.csv(file.path(rawDir,'UNIBI.csv'), header=TRUE, sep=",")
df = rawD

# Calculate Pointing_Error (distance error)
df['Pointing_Error'] = sqrt(
  df[,'X.Error'] ^ 2 + df[,'Y.Error'] ^ 2
  )

# Next:   ttests.R
# Next:   plot_ttest.R
