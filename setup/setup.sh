#!/bin/bash

echo '
Downloading OSF data into ./data
'

mkdir ./data

curl -L 'https://osf.io/8f6nt?action=download&version=1' > './data/FREEPER_Database.xlsx'
curl -L 'https://osf.io/vpyqe?action=download&version=1' > './data/UNIBI_Database_2023.xlsx'

echo '
Setup complete. For analysis instructions see:
https://github.com/ethanknights/neglect
'

echo '
Consider environment setup with:
pip install -r requirements.txt
'
#pip install -r requirements.txt

# python convert2long_experiment-1.py
echo 'Converting data to long format for experiment 2: Bimanual Reaching'
python setup/convert2long_experiment-2.py
echo 'Finished!'
