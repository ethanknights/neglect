#
import pandas as pd

fN = './data/rawData.xlsx'

#Stack data
df = pd.concat(pd.read_excel(fN, sheet_name=None), ignore_index=True)

# Drop data that isn't a trial (row)
df = df.dropna(subset=['target', 'Trial Name'])

# Drop columns with junk
df.columns
df = df.loc[:, :'Zerody']  # Drop all columns after Zerody
df.columns
df = df.drop(df.filter(regex='Unnamed:').columns, axis=1) # df.drop(columns=['Unnamed: 27', 'Unnamed: 30'])  # DDrop some specific cols
df = df.reset_index()

# Add subj Names
tmp = []
for idx, _ in enumerate(df['Trial Name']):
    tmp.append(df['Trial Name'][idx][0:4])
    if tmp[idx] == 'DA_2':
        tmp[idx] = 'DA'
df['subjName'] = tmp

# Add cond Names
tmp = []
for idx, _ in enumerate(df['Trial Name']):
    if 'LH' in _:
        tmp.append('UNI_LH')
    elif 'RH' in _:
        tmp.append('UNI_RH')
    elif 'BICON' in _ or 'BI_CON' in _ or 'cong' in _ or 'AW0727052016_BI' in _:
        tmp.append('BI_CON')
    elif 'INC' in _ or 'cong' in _:
        tmp.append('BI_INC')
    else:
        tmp.append('NaN')
df['condName_noHand'] = tmp

# assert none missing!
tmp = df[df['condName_noHand'] == 'NaN']
assert(len(tmp) == 0)


# Add hand names
# tmp = df[df['condName_noHand'] == 'BI_CON']
# df.to_excel('./data/tmp.xlsx')


# Write
#df.to_excel('./data/rawData2.xlsx')

