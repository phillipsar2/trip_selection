# Scripts used for Tripsacum project:
bgzip.sh - compresses files using bgzip
extractdepth.sh - uses GATK VariantsToTable to extracts GT and DP fields from vcfs and organizes into a table by SNP
GC%.sh - extracts GC% for all individuals from qualimap report and formats into a text file 
gunzip.sh - compresses files using gunzip
stats.sh - uses bcftools stats to create statistics file on a VCF
vartotable.sh - uses GATK VariantsToTable to extract QUAL, QD, DP, MQ, and AD fields and formats into a table by SNP
TEMPLATE.sh - a blank script that contains the necessary #SBATCH fields

# Directories of scripts:
ebg - scripts for generating input files required to run the program ebg ---> used to generate genotype likelihoods 
old_scripts - scripts used in the past that may no longer be relevant as data processing improves and transitions to snakemake 
repeat_abundance - scripts used for generating bed files to compare the relative abundance of 10 repeats in our Tripsacum individuals 
