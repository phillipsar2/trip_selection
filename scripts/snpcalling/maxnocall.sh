#!/bin/bash
#SBATCH --job-name=maxnocall
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p high2
#SBATCH -t 07-00:00
#SBATCH --mem=24G

# create index for vcf
#module load bcftools
#bcftools index -t data/vcf/final/ALL.DP1_8.filtered.snps.vcf.gz

# set stricter missing data fraction (10% instead of 20%)
#module load maven R java
#module load GATK/4.2.3.0

#gatk SelectVariants -V data/vcf/final/ALL.DP1_8.filtered.snps.vcf.gz --exclude-filtered true \
#--max-nocall-fraction .1 -O data/vcf/final/ALL.maxnocall10.vcf.gz

# subset the vcf to randomly grab 20k snps from the stricter filter
module load bcftools
bcftools view -h data/vcf/final/ALL.maxnocall10.vcf.gz > data/vcf/final/20k.maxnocall10.vcf

shuf -n 20001 <(bcftools view -H data/vcf/final/ALL.maxnocall10.vcf.gz) >> data/vcf/final/20k.maxnocall10.vcf
