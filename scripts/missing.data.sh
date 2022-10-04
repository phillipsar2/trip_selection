#!/bin/bash
#SBATCH --job-name=quant_NA
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p bigmemh
#SBATCH -t 07-00:00
#SBATCH --mem=24G

#gunzip -d data/vcf/final/20k.DP1_8.filtered.vcf.gz

module load bcftools
paste \
<(bcftools query -f '[%SAMPLE\t]\n' <<`data/vcf/final/20k.DP1_8.filtered.vcf`>> | head -1 | tr '\t' '\n') \
<(bcftools query -f '[%GT\t]\n' <<`data/vcf/final/20k.DP1_8.filtered.vcf`>> | \
awk -v OFS="\t" '{for (i=1;i<=NF;i++) if ($i == "./.") sum[i]+=1 } END {for (i in sum) print i, sum[i] / NR }' | sort -k1,1n | cut -f 2)
