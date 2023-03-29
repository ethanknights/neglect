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

# TEMPORARY: LEAVE PATIENT + 1 CONTROL ONLY !
df = df.iloc[1:222,:]

# Assign condition / hand / target names
tmp_condition = []  # UNI_LH / UNI_RH / BI_CON / BI_INC
tmp_hand = []  # LH / RH
tmp_target = []  # Far / Near
for idx, _ in enumerate(df['Trial Name']):  # idx=0; _ = df['Trial Name'][idx]

    # init
    tmp_condition.append('NaN')
    tmp_hand.append('NaN')
    tmp_target.append('NaN')

    if 'LH' in _:
        tmp_condition[idx] = 'UNI'
        tmp_hand[idx] = 'LH'
        if '1' in df['target'][idx]:
            tmp_target[idx] = 'Far'
        elif '2' in df['target'][idx]:
            tmp_target[idx] = 'Near'

    elif 'RH' in _:
        tmp_condition.append('UNI')
        tmp_hand.append('RH')
        if df['target'][idx] == 1:
            tmp_target.append('Far')
        elif df['target'][idx] == 2:
            tmp_target.append('Near')
    elif 'BICON' in _ or 'BI_CON' in _ or 'cong' in _ or 'AW0727052016_BI' in _:
        tmp_condition.append('CON')
        if df['target'][idx] == 1:
            tmp_hand.append('RH')
            tmp_target.append('Far')
        elif df['target'][idx] == 2:
            tmp_hand.append('RH')
            tmp_target.append('Near')
        elif df['target'][idx] == 3:
            tmp_hand.append('LH')
            tmp_target.append('Far')
        elif df['target'][idx] == 4:
            tmp_hand.append('LH')
            tmp_target.append('Near')
    elif 'INC' in _:
        tmp_condition.append('INC')
        if df['target'][idx] == 1:
            tmp_hand.append('RH')
            tmp_target.append('Far')
        elif df['target'][idx] == 2:
            tmp_hand.append('RH')
            tmp_target.append('Near')
        elif df['target'][idx] == 3:
            tmp_hand.append('LH')
            tmp_target.append('Far')
        elif df['target'][idx] == 4:
            tmp_hand.append('LH')
            tmp_target.append('Near')
    else:

df['condition_name'] = tmp_condition
df['hand_name']      = tmp_hand
df['target_name']    = tmp_target

# assert none missing!
tmp = df[df['condition_name'] == 'NaN']
tmp = df[df['hand_name'] == 'NaN']
tmp = df[df['target_name'] == 'NaN']
assert(len(tmp) == 0)




# Write
df.to_excel('./data/UNIBI_longFormat.xlsx')


