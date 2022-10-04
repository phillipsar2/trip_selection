#!/bin/bash
#SBATCH --job-name=filterbed
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p high2
#SBATCH -t 07-00:00
#SBATCH --mem=32G
#-v : only report those entries in A that have no overlap in B

# filter 17S
bedtools intersect -sorted -v -a data/bed_files/17SrRNA.sorted.final.bed \
-b data/bed_files/5.8SrRNA.sorted.final.bed > data/bed_files/17SrRNA.no_overlap.bed

# filter 25S
bedtools intersect -sorted -v -a data/bed_files/25SrRNA.sorted.final.bed \
-b data/bed_files/5.8SrRNA.sorted.final.bed > data/bed_files/25SrRNA.no_overlap.bed

# filter 5.8S
bedtools intersect -sorted -v -a data/bed_files/5.8SrRNA.sorted.final.bed \
-b data/bed_files/17SrRNA.sorted.final.bed > data/bed_files/5.8SrRNA.temp.bed

bedtools intersect -sorted -v -a data/bed_files/5.8SrRNA.temp.bed \
-b data/bed_files/25SrRNA.sorted.final.bed > data/bed_files/5.8SrRNA.no_overlap.bed

rm data/bed_files/5.8SrRNA.temp.bed

# filter 180knob
bedtools intersect -sorted -v -a data/bed_files/180knob.sorted.final.bed \
-b data/bed_files/telomere.sorted.final.bed > data/bed_files/180knob.no_overlap.bed

# filter telomere
bedtools intersect -sorted -v -a data/bed_files/telomere.sorted.final.bed \
-b data/bed_files/180knob.sorted.final.bed > data/bed_files/telomere.no_overlap.bed
