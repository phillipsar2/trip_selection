#!/bin/bash
#SBATCH --job-name=bedtools
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p bigmemh
#SBATCH -t 07-00:00
#SBATCH --mem=24G

module load bedtools

# intersect helitron.bed and report regions that do not overlap with any other .bed files
bedtools intersect -wa -wb \
-a data/repeat_abundance/bed_files/repeat/helitron.sorted.bed \
-b data/repeat_abundance/bed_files/repeat/*.final.bed data/repeat_abundance/bed_files/repeat/LTR.sorted.bed data/repeat_abundance/bed_files/repeat/TIR.sorted.bed \
-sorted -v > data/repeat_abundance/bed_files/repeat/helitron.nonoverlap.bed

# intersect LTR.bed and report any regions that have overlap with other .bed files
bedtools intersect -wa -wb \
-a data/repeat_abundance/bed_files/repeat/LTR.sorted.bed \
-b data/repeat_abundance/bed_files/repeat/*.final.bed data/repeat_abundance/bed_files/repeat/TIR.sorted.bed data/repeat_abundance/bed_files/repeat/helitron.sorted.bed \
-sorted -v > data/repeat_abundance/bed_files/repeat/LTR.nonoverlap.bed

# intersect TIR.bed and report any regions that have overlap with other .bed files
bedtools intersect -wa -wb \
-a data/repeat_abundance/bed_files/repeat/TIR.sorted.bed \
-b data/repeat_abundance/bed_files/repeat/*.final.bed data/repeat_abundance/bed_files/repeat/helitron.sorted.bed data/repeat_abundance/bed_files/repeat/LTR.sorted.bed \
-sorted -v > data/repeat_abundance/bed_files/repeat/TIR.nonoverlap.bed
