#!/bin/bash
#SBATCH --job-name=filter_vcf
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p high2
#SBATCH -t 07-00:00
#SBATCH --mem=32G

module load bcftools
bcftools view -T data/af/regions.noNA.bed -o data/vcf/final/reduced.noNA.vcf.gz -Oz \
data/vcf/final/ALL.DP1_8.rename.vcf.gz
