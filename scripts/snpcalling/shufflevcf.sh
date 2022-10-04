#!/bin/bash
#SBATCH --job-name=shuffle
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p high2
#SBATCH -t 00-12:00
#SBATCH --mem=32G

module load bcftools
bcftools view -h data/vcf/final/ALL.DP1_8.rename.vcf.gz > data/vcf/final/20k.DP1_8.rename.vcf

#shuf -n 10000 <(bcftools view -H data/vcf/final/ALL.DP1_8.rename.vcf.gz) >> data/vcf/final/10k.DP1_8.rename.vcf

bcftools view -H data/vcf/final/ALL.DP1_8.rename.vcf.gz | shuf -n 20000 >> data/vcf/final/20k.DP1_8.rename.vcf
