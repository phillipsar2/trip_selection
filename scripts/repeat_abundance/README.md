Scripts utilized to compare the relative abundance of 10 repeats for our Tripsacum individuals 
bamtobed.sh - converts BAM files for Tripsacum individuals into BED file format 
blast2bed.sh - converts BLAST results for repeats Blasted to reference genome into BED file format 
rm_dup_bed.sh - uses bedtools intersect to remove regions from repeat BED files that contain overlap with other repeats

Directories of scripts:
avg_cov - test/draft scripts for using R script to average the coverage reported by bedtools coverage -d by region and create new file
blast - contains scripts necessary to blast 10 repeats to the Tripsacum refence genome including: 1) a scripts to prepare a BLAST database for the reference genome and 2) a scripts to BLAST the repeats to the reference genome 
