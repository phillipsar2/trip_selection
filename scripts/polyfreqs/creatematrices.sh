#!/bin/bash
#SBATCH --job-name=read_counts
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p bigmemm
#SBATCH -t 07-00:00
#SBATCH --mem=250G

cat scripts/polyfreqs/creatematrices.R
module load R
srun Rscript --min-vsize=10M --max-vsize=100M --min-nsize=500k --max-nsize=40G scripts/polyfreqs/creatematrices.R

sed 's/"//g' data/polyfreqs/ref_read.txt > data/polyfreqs/reference_reads.txt
sed 's/"//g' data/polyfreqs/tot_read.txt > data/polyfreqs/total_reads.txt
#rm data/polyfreqs/ref_read.txt
#rm data/polyfreqs/tot_read.txt
