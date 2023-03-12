#!/bin/bash

echo '
Downloading data to ./data (from the Open Science Framework used in: Knights et al. 2021)
'

mkdir ./data

curl -L 'https://osf.io/wtq5a?action=download&version=1' > ./data/UNIBI_Database_editedForMatlab.xlsx

mv ./data/UNIBI_Database_editedForMatlab.xlsx ./data/rawData.xlsx

echo '
Setup complete. For analysis instructions see:
https://github.com/ethanknights/ <TBC>
'

echo '
Consider environment setup with:
pip install -r requirements.txt
'
#pip install -r requirements.txt