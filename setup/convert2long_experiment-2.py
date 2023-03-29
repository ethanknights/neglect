#
import pandas as pd

fN = './data/UNIBI_Database_2023.xlsx' # fN = './data/UNIBI_Database.xlsx'

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

# Front-append subjName column
tmp = []
for idx, _ in enumerate(df['Trial Name']):
    tmp.append(df['Trial Name'][idx][0:4])
    # edge case
    if tmp[idx] == 'EB_2':
        tmp[idx] = 'EB'
df.insert(0, 'subjName', tmp)
del tmp
df = df.drop('index', axis=1)

# Write
df.to_csv('./data/UNIBI.csv', index=False)
