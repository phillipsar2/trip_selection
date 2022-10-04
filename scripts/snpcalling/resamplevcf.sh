#!/bin/bash
#SBATCH --job-name=re-sample
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p bigmemh
#SBATCH -t 07-00:00
#SBATCH --mem=32G

module load bcftools
bcftools reheader -s data/vcf/final/sample.names.txt \
-o data/vcf/final/ALL.DP1_8.rename.vcf.gz \
data/vcf/final/ALL.DP1_8.filtered.snps.vcf.gz
