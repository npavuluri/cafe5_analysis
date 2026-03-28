#!/usr/bin/env python3

import sys
# ploidy levels/factors
# The keys MUST match the column headers in your og_gene_counts.tsv file exactly.
ploidy_factors = {
    "Arabidopsis_thaliana": 1,
    "Oryza_sativa": 1,
    "Zea_mays": 1,
    "Sorghum_bicolor": 1,
    "Brachypodium_distachyon": 1,
    "Hordeum_vulgare": 1,
    "Triticum_aestivum": 3,
    "Triticum_turgidum": 2,
    "Avena_sativa": 3  
}

input_file = "og_gene_counts.tsv"
output_file = "ploidy_normalized_og_gene_counts.tsv"

# normalise the gene counts
with open(input_file, 'r') as fin, open(output_file, 'w') as fout:
    header = fin.readline().strip()
    fields = header.split('\t')
    
    # Write the header unchanged
    fout.write(header + '\n')
    
    # Create a list of divisors for each column. First two columns are 'Desc' and 'OG'.
    divisors = [1, 1]  # Don't divide the first two columns - Desc and OG
    for i in range(2, len(fields)):
        species = fields[i]
        divisors.append(ploidy_factors.get(species, 1))  # Use 1 if species not found
    
    # Process each data line
    for line in fin:
        line = line.strip()
        if not line:
            continue
        values = line.split('\t')
        new_values = []
     
        for i, value in enumerate(values):
            if i < 2:  # Keep 'Desc' and 'OG' as they are
                new_values.append(value)
            else:
                try:
                    count = int(value)
                    divisor = divisors[i]
                    # If count is 0, keep it as 0
                    if count == 0:
                        new_values.append("0")
                    else:
                        # Divide and round for non-zero counts
                        normalized_count = round(count / divisor)
                        new_values.append(str(normalized_count))
                except ValueError:
                    # In case it's not a number, just use the original value
                    new_values.append(value)
        
        # Write the new, normalised line to the output file
        fout.write('\t'.join(new_values) + '\n')
