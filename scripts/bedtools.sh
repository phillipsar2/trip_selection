#!/bin/bash
#SBATCH --job-name=bedtools
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p high2
#SBATCH -t 07-00:00
#SBATCH --mem=90G
#SBATCH --cpus-per-task=16

module load bedtools
bedtools intersect -sorted -c -a data/bed_files/telomere.sorted.final.bed \
-b data/merged_bams/bamtobed/12836_10.sorted.bed > data/intersect/telomere.12836_10.test.intersect.bed
