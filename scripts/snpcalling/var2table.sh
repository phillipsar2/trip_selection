#!/bin/bash
#SBATCH --job-name=var2table
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p bigmemh
#SBATCH -t 07-00:00
#SBATCH --mem=32G

tabix data/vcf/hard_filter/scaf_20,scaf_21.nocall.filtered.2.snps.vcf.gz

module load maven R java GATK
gatk VariantsToTable -R data/genome/v1/Td-KS_B6_1-Draft-PanAnd-1.0.noalternate.fasta \
-V data/vcf/hard_filter/scaf_20,scaf_21.nocall.filtered.2.snps.vcf.gz -F CHROM -F POS -F QUAL -F DP -F MQ \
-O data/reports/var2table/scaf_20_21.nocall.filtered.2.snps.vcf.gz.table
