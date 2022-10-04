#!/bin/bash
#SBATCH --job-name=merge_vcf
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p high2
#SBATCH -t 07-00:00
#SBATCH --mem=32G

module load bcftools
#bcftools concat data/vcf/max_no_call/DP1_8/*.maxnocall.DP1_8.filtered.snps.vcf.gz -Oz \
#-o data/vcf/final/ALL.DP1_8.filtered.snps.vcf.gz

bcftools concat data/vcf/raw_vcf/*.vcf.gz -Oz \
-o data/vcf/raw_vcf/ALL.raw.vcf.gz

bcftools concat data/vcf/snps/*.snps.vcf.gz -Oz \
-o data/vcf/snps/ALL.snps.vcf.gz

bcftools stats data/vcf/raw_vcf/ALL.raw.vcf.gz > data/vcf/final/raw_vcf.stats.txt
bcftools stats data/vcf/snps/ALL.snps.vcf.gz > data/vcf/final/snps.vcf.stats.txt
