#!/bin/bash
#SBATCH --job-name=combine_vcfs
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p high2
#SBATCH -t 07-00:00
#SBATCH --mem=36G

#gzip -d data/vcf/max_no_call/DP1_12/scaf_100,scaf_101,scaf_102.maxnocall.DP1_12.filtered.snps.vcf.gz
#gzip -d data/vcf/max_no_call/DP1_12/scaf_103,scaf_104,scaf_105.maxnocall.DP1_12.filtered.snps.vcf.gz

#bgzip data/vcf/max_no_call/DP1_12/scaf_100,scaf_101,scaf_102.maxnocall.DP1_12.filtered.snps.vcf
#bgzip data/vcf/max_no_call/DP1_12/scaf_103,scaf_104,scaf_105.maxnocall.DP1_12.filtered.snps.vcf

#tabix data/vcf/max_no_call/DP1_12/scaf_100,scaf_101,scaf_102.maxnocall.DP1_12.filtered.snps.vcf.gz
#tabix data/vcf/max_no_call/DP1_12/scaf_103,scaf_104,scaf_105.maxnocall.DP1_12.filtered.snps.vcf.gz

module load bcftools
bcftools concat data/vcf/max_no_call/DP1_12/scaf_100,scaf_101,scaf_102.maxnocall.DP1_12.filtered.snps.vcf.gz \
data/vcf/max_no_call/DP1_12/scaf_103,scaf_104,scaf_105.maxnocall.DP1_12.filtered.snps.vcf.gz \
-Oz -o data/vcf/merge_vcf/combine.test.vcf.gz
