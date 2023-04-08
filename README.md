### Analysis instructions: Experiment 2 - Bimanual Reaching

Run setup.sh to download data and perform python light preprocessing:
```sh
./setup/setup_experiment-2.sh 
# Output: ./data/UNIBI.csv
```

Run plotting & analysis in R:
```r
# Load the dataset into a dataframe 'df_summary' by sourcing:
load_data.R  # Or for extra results without collapsing across target instead run: extra_load_data_nonCollapsed.R

# Run single case study statistical tests by sourcing:
analysis_BDT.R
analysis_BSDT.R
```
