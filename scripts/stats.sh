#!/bin/bash
#SBATCH --job-name=stats
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p high
#SBATCH -t 07-00:00
#SBATCH --mem=24G

module load bcftools
bcftools stats data/vcf/final/ALL.DP1_12.filtered.snps.vcf.gz > data/vcf/final/final.vcf.stats.txt
