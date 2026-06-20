# cafe5_analysis

## Overview
This repository contains the results of a CAFE5 analysis to identify the significant expansion and contraction in drought gene familes across major cereal crops.

## Input Data
- Species tree: `SpeciesTree_rooted_ultra.txt` (9 species, ultrametric)
- Gene families: OrthoFinder v3.1 results (Orthogroups.tsv; 21,912 families)
- Filtering: Removed families present in <2 species, removed gene families with lots of genes in a one or more species (n_max < 100).

## Analysis Commands
```bash
cafe5 -i ./ploidy_normalised_og_gene_counts.tsv -t ./SpeciesTree_rooted_ultra.txt -o results/ -p -k 3 -eBase_error_model.txt --cores 30 ## Estimate a lambda along with a gamma distribution using three rate categories.
```

## Output files:

- Gamma_asr.tre ## Tree file for each gene family
- Gamma_branch_probabilities.tab  ## Probabilities calculated for each branch
- Gamma_category_likelihoods.txt 
- Gamma_change.tab ## Number of contractions and expansions for each gene family at each node
- Gamma_clade_results.txt ## Number of expansions/contractions for gene families at each node
- Gamma_count.txt ## Number of gene families at each node
- Gamma_family_likelihoods.txt
- Gamma_family_results.txt ## p-values and significance results for gene family changes
- Gamma_results.txt ## Parameter information, including the model, final likelihood value, final Lambda value, etc.
