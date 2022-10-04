#!/bin/bash
#SBATCH --job-name=extractAD
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p bigmemh
#SBATCH -t 07-00:00
#SBATCH --mem=32G

module load R java maven
module load GATK
gatk VariantsToTable -R data/genome/v1/Td-KS_B6_1-Draft-PanAnd-1.0.noalternate.fasta \
-V data/vcf/max_no_call/DP1_8/scaf_1.maxnocall.DP1_8.filtered.snps.vcf.gz \
-F CHROM -F POS -GF AD -O data/reports/AD/uncut/scaf_1.maxnocall.DP1_8.filtered.snps.AD.table

gatk VariantsToTable -R data/genome/v1/Td-KS_B6_1-Draft-PanAnd-1.0.noalternate.fasta \
-V data/vcf/max_no_call/DP1_8/scaf_2.maxnocall.DP1_8.filtered.snps.vcf.gz \
-F CHROM -F POS -GF AD -O data/reports/AD/uncut/scaf_2.maxnocall.DP1_8.filtered.snps.AD.table
