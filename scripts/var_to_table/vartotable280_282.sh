#!/bin/bash
#SBATCH --job-name=vartotable280_282
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p bigmemh
#SBATCH -t 07-00:00
#SBATCH --mem=32G

module load maven R java GATK
gatk VariantsToTable -R data/genome/Tripsacum_dactyloides-southern_hifiasm-bionano_scaffolds_v1.0.fasta \
-V data/vcf/hard_filter/scaf_280,scaf_281,scaf_282.filtered.nocall.snps.vcf.gz -F CHROM -F POS -F QUAL -F QD -F DP -F MQ -F AD \
-O data/reports/variantstotable/scaf_280_282.nocall.snps.vcf.gz.table