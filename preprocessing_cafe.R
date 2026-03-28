#!/usr/bin/R Rscript
# code adapted from a Biostars answer by dariobar (https://www.biostars.org/p/9553290/)

# make sure the species tree is ultrametric
library(ape) 
library(data.table) 

tre <- read.tree('./Species_Tree/SpeciesTree_rooted.txt')
stopifnot(is.binary(tre))
stopifnot(is.rooted(tre))

if(is.ultrametric(tre)) {
    utre <- tre
} else{
    utre <- chronos(tre)
}
write.tree(utre, './SpeciesTree_rooted_ultra.txt')

library(data.table)
library(dplyr)
og <- fread('OrthoFinder_Results/Orthogroups/Orthogroups.tsv')
og <- melt(og, id.vars='Orthogroup', variable.name='species', value.name='pid') #Converts data from wide to long format. 'OG' column remains as identifier. Other column names become 'species' values, Cell values become 'pid' (gene IDs)
og <- og[pid != '']
og$n <- sapply(og$pid, function(x) length(strsplit(x, ', ')[[1]]))

# Exclude OGs with lots of genes in a one or more species. 
keep <- og[, list(n_max=max(n)), Orthogroup][n_max < 100]$Orthogroup
og <- og[Orthogroup %in% keep]

# Exclude OGs present in only 1 species
keep <- og[, .N, Orthogroup][N > 1]$Orthogroup
og <- og[Orthogroup %in% keep]

counts <- dcast(og, Orthogroup ~ species, value.var='n', fill=0, fun.aggregrate=sum)
counts[, Desc := 'n/a']
setcolorder(counts, 'Desc')
fwrite(counts, 'og_gene_counts.tsv', sep='\t')
