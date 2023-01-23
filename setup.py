import warnings
warnings.simplefilter(action='ignore', category=FutureWarning) #iteritems warning!

import pandas as pd
import os
import json

sheet_to_df_map = pd.read_excel(os.path.join('data', 'rawData.xlsx'), sheet_name=None)
# sheet_to_df_map.head()

#Parameters
def setupParameterFromJSON(fileName):
  with open(fileName) as f:
    parameters = json.load(f)
  subjNames = parameters['subjNames']
  condMapping_original = parameters['conditionMapping_original']
  condMapping = parameters['conditionMapping_analysis'] #for analysis
  del(f); del(parameters)

  condNames = list()
  for conds in condMapping_original:
    condNames.append(conds['name'])

  return subjNames, condNames, condMapping_original, condMapping


subjNames, condNames, condMapping_original, condMapping =  setupParameterFromJSON('parameters.json')








subjName = subjNames[0]; print(subjName)
condName = condNames[0]; print(condName)

df = readSheet(subjName,condName)

df_clean = cleanSheet(df, condName, condNames)


def readSheet(subjName,condName):
  sheetName = subjName + '_' + condName
  df = sheet_to_df_map[sheetName]
  return df


def cleanSheet(df, condName, condNames):
  # Grab data for these conditions (i.e. drop crap in xls + reference coords)
  # df_clean is a stack of all targets fot this subject
  print('Mapping for condNames')





  # asset here unique onyl includes condMapping_orig: df['target'].unique()

  df[df['target'] == 1]







  df['target']

    values = [i['status']

  for i in

  df[df['target'] == 1]

  :

    print(i)


  return df_clean



# stack single subj





