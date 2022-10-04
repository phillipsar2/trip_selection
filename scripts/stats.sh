#!/bin/bash
#SBATCH --job-name=stats
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p bigmemh
#SBATCH -t 07-00:00
#SBATCH --mem=10G

#module load bcftools
#bcftools stats data/vcf/final/20k.DP1_8.filtered.vcf > data/vcf/final/20k.DP1_8.stats.txt

module load vcftools
VCF=data/vcf/final/20k.DP1_8.filtered.vcf
OUT=data/vcf/final/20k.DP1_8.vcfstats.txt

# mean depth of coverage per individual
vcftools --vcf $VCF --depth --out $OUT
# mean deopth of coverage per site
vcftools --vcf $VCF --site-mean-depth --out $OUT
# proportion of missing data per sample
vcftools --vcf $VCF --missing-indv --out $OUT
# proportion of missing data per site
vcftools --vcf $VCF --missing-site --out $OUT
