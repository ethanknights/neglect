#!/bin/bash

echo 'Downloading data from the Open Science Framework used in: Knights et al. (2021)'

mkdir ./data

curl -L 'https://osf.io//jg2dr?action=download&version=1' > ./data/UNIBI_Database_editedForMatlab.xlsx

echo 'Setup complete. For analysis instructions see:
https://github.com/ethanknights/ <TBC>'