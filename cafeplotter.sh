#!/bin/bash

set -uo pipefail # leave out -e so you can see failures, all the jobs were failing before even writing to error file.
IFS=$'\n\t'

source ~/miniconda3/etc/profile.d/conda.sh
conda activate cafe || { echo "Conda failed to activate" >&2; exit 1; } #sbatch job fails before even activating the env, so to see what causes it.

cafeplotter -i ./after_normalisation/results_p_k3_error/ -o ./after_normalisation/results_p_k3_error/ --format 'svg' --fig_height 0.5 --fig_width 5 --count_label_size 5 --leaf_label_size 5 --ignore_branch_length 

# Significant expansion(red)/contraction(blue) gene family result
# Always deactivate safely
set +u
conda deactivate
set -u


