# Analysis of Covariance and Relationships Found Within Mutation Rates and Between Other Genomic Features

## Report submitted to Penn State's Huck Institute for Life Sciences

## Human Genome Mutation Rates Tested: Small Insertion, Small Deletion, Nucleotied Substitution, and Microsatellite Repeat Number Alteration


###  1. Do the four mutation rates co-vary with each other across the human genome? Can it be illustrated in a two-dimensional plot? 
#### Principal Component Analysis
Confirmed small insertion, small deletion, and nucleotide subsitution rates positvely co-vary

[principal_component_analysis.R](https://github.com/sienaroma/mutation-rate-covariation-and-relationship-with-genomic-elements/blob/main/principal_component_analysis.R)

### 2. Do our four mutation rates differ among the six states of genetic divergence identified in the human genome? Do the average mutation rates in state 1 significantly differ from those in state 6?
#### MANOVA Mutation Rate Comparison and MANOVA Contrasts
Concluded that all four mutation rates depend on the state of divergence and each mutation rate differs significantly in at least one of the six genetic states on average 

Additionally, the mean mutation rate found in state 1 is significantly different from that found in state 6

[manova_and_contrasts.sas](https://github.com/sienaroma/mutation-rate-covariation-and-relationship-with-genomic-elements/blob/main/manova_and_contrasts.sas)

### 3. Can we link mutation rates and their co-variation to the genomic features? 
#### Canonical Correlation Analysis
Determined that small insertion, small deletion, and nucleotide substitution rates correlate and capture the most variation with the nCGm and LINE genomic features

Individual regressions with each mutation rate as the response also confirmed nCGm and LINE are significant predictors for small insertion, small deletion, and nucleotide substitution rates

[canonical_correlation_analysis.sas](https://github.com/sienaroma/mutation-rate-covariation-and-relationship-with-genomic-elements/blob/main/canonical_correlation_analysis.sas)
