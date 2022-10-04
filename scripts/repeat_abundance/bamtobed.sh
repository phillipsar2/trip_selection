#!/bin/bash
#SBATCH --job-name=bamtobed
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p high2
#SBATCH -t 07-00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=8

module load bedtools
bedtools bamtobed -i data/merged_bams/12836_10.sorted.bam > data/merged_bams/bamtobed/12836_10.bed
sort -k1,1 -k2,2n data/merged_bams/bamtobed/12836_10.bed > data/merged_bams/bamtobed/12836_10.sorted.bed
