# Code Repository: Attention in Action - Bimanual Reaching Experiment
R & Python code for Bayesian analysis of a motion-tracking dataset from a rare neuropsychological stroke patient & control-group.

## Article
[Neuropsychologia Article](https://www.sciencedirect.com/science/article/pii/S0028393224001167)

## Citation
Knights, E., Ford, C., McIntosh, R. D., & Rossit, S. (2021, September 6). Attention in Action: evidence from peripheral and bimanual reaching deficits in a single case study of visual neglect and extinction post-stroke.

### Analysis instructions for Experiment - Bimanual Reaching
Run setup.sh to download data from OSF (https://osf.io/rbyne/ - Experiment 2) and perform python preprocessing:
```sh
./setup/setup_experiment-2.sh
# python setup/convert2long_experiment-2.py
# Output: ./data/UNIBI.csv
```

Run plotting & analysis in R from the 'R' directory:
```r
# Load the dataset into a dataframe 'df_summary' by sourcing:
load_data.R  # Or for extra results without collapsing across target instead run: extra_load_data_nonCollapsed.R

# Run single case study statistical tests by sourcing:
analysis_BDT.R
analysis_BSDT.R
# Create plots
plotting.R
```

### Analysis instructions for Experiment - Peripheral Reaching
See: https://github.com/ethanknights/Knightsetal2022_neglect-opticAtaxia
