#!/bin/bash
#SBATCH --job-name=extractdepth
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p bigmemh
#SBATCH -t 07-00:00
#SBATCH --mem=64G

module load maven R java GATK
gatk VariantsToTable -R data/genome/v1/Td-KS_B6_1-Draft-PanAnd-1.0.noalternate.fasta \
-V data/vcf/hard_filter/scaf_2.nocall.filtered.2.snps.vcf.gz -F CHROM -F POS -GF GT -GF DP \
-O data/reports/DP/scaf_2.nocall.filtered.DP.table

gatk VariantsToTable -R data/genome/v1/Td-KS_B6_1-Draft-PanAnd-1.0.noalternate.fasta \
-V data/vcf/hard_filter/scaf_16,scaf_17.nocall.filtered.2.snps.vcf.gz -F CHROM -F POS -GF GT -GF DP \
-O data/reports/DP/scaf_16,17.nocall.filtered.DP.table

gatk VariantsToTable -R data/genome/v1/Td-KS_B6_1-Draft-PanAnd-1.0.noalternate.fasta \
-V data/vcf/hard_filter/scaf_41,scaf_44.nocall.filtered.2.snps.vcf.gz -F CHROM -F POS -GF GT -GF DP \
-O data/reports/DP/scaf_41,44.nocall.filtered.DP.table
