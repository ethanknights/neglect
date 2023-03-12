import warnings
warnings.simplefilter(action='ignore', category=FutureWarning) #iteritems warning!

import pandas as pd
import os
import json

sheet_to_df_map = pd.read_excel(os.path.join('data', 'rawData.xlsx'), sheet_name=None)
# sheet_to_df_map.head()

#Parameters
def readParameterFromJSON(fileName):
  with open(fileName) as f:
    parameters = json.load(f)
  subjNames = parameters['subjectNames']

  condNames = list()
  condMappings_original = list()
  condMappings_original_names = list()
  condMappings = list()
  condMappings_names = list()

  for conds in parameters['conditions']:
    #print(conds)
    condNames.append(conds['name'])

    condMappings_original.append(conds['original_mapping'])
    condMappings_original_names.append(conds['original_mapping_name'])

    #for analysis
    condMappings.append(conds['mapping'])
    condMappings_names.append(conds['mapping_name'])

  del(f); del(parameters)

  return subjNames, condNames, condMappings_original, condMappings_original_names,condMappings,\
         condMappings_names

subjNames, condNames, condMappings_original, condMappings_original_names,condMappings, \
  condMappings_names = readParameterFromJSON('parameters.json')

print(subjNames)
print(condNames)
print(condMappings_original)
print(condMappings_original_names)
print(condMappings)
print(condMappings_names)


master_df = pd.DataFrame()

for idx_subj in range(len(subjNames)):

  subjName = subjNames[idx_subj]
  print(subjName)

  for idx_cond in range(len(condMappings)):

    condName = condNames[idx_cond]
    print(condName)

    condMappings_names = condMappings_names[idx_cond]
    print(condMappings_name)


    condMapping = condMappings[idx_cond]
    print(condName)


def readSheet(subjName,condName):
  sheetName = subjName + '_' + condName
  df = sheet_to_df_map[sheetName]
  return df

df = readSheet(subjName, condName)

def cleanSheet(df, condName, condNames):
  # Grab data for these conditions (i.e. drop crap in xls + reference coords)
  # df_clean is a stack of all targets fot this subject
  #print('Mapping for condNames')




  return


def processSheet(df,
                 subjName, condName,
                 curr_condMappings_original, curr_condMappings, curr_condMappings_names
                 ):

  for idx, ignore in enumerate(curr_condMappings):
    curr_condMapping_original = curr_condMappings_original[idx]
    curr_condMapping = curr_condMappings[idx]
    curr_condMapping_name = curr_condMappings_names[idx]
    print(curr_condMapping)
    print(curr_condMapping_original)
    print(curr_condMapping_name)


  new_df = df.copy()
  new_df = new_df[new_df['target'] == curr_condMapping_original]
  new_df['target'] = curr_condMapping # reassign target val
  new_df = new_df.assign(subjectName = subjName)
  new_df = new_df.assign(conditionName = condName)
  new_df = new_df.assign(targetName = curr_condMapping_name)

  return new_df






for idx, ignore in enumerate(condMapping_original):
  curr_condMappings_original = condMapping_original[idx]
  curr_condMappings = condMapping[idx]
  curr_condMappings_names = condMapping_names[idx]

  new_df = processSheet(df,
                         subjName, condName,
                         curr_condMappings_original, curr_condMappings, curr_condMappings_names
                         )

  master_df = pd.concat([master_df, new_df])










