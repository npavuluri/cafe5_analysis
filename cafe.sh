#!/bin/bash

source ~/miniconda3/etc/profile.d/conda.sh
conda activate cafe

#initial run to calculate an error rate
cafe5 -i ./ploidy_normalised_og_gene_counts.tsv -t ./SpeciesTree_rooted_ultra.txt -o cafe/results_errorrate -p -e --cores 30 ## Estimating a single lambda for the whole tree

#calculating discrete rate categories
cafe5 -i ./ploidy_normalised_og_gene_counts.tsv -t ./SpeciesTree_rooted_ultra.txt -o cafe/results_p_k3_error -p -k 3 -eBase_error_model.txt --cores 30 ## Estimate a lambda along with a gamma distribution using three rate categories.
cafe5 -i ./ploidy_normalised_og_gene_counts.tsv -t ./SpeciesTree_rooted_ultra.txt -o cafe/results_p_k4_error -p -k 4 -eBase_error_model.txt --cores 30 ## Estimate a lambda along with a gamma distribution using four rate categories.
cafe5 -i ./ploidy_normalised_og_gene_counts.tsv -t ./SpeciesTree_rooted_ultra.txt -o cafe/results_p_k5_error -p -k 5 -eBase_error_model.txt --cores 30 ## Estimate a lambda along with a gamma distribution using five rate categories.

# Always deactivate safely
set +u
conda deactivate
set -u


