#!/bin/bash
#SBATCH --job-name=vartotable220_222
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p bigmemm
#SBATCH -t 07-00:00
#SBATCH --mem=32G

module load maven R java GATK
gatk VariantsToTable -R data/genome/Tripsacum_dactyloides-southern_hifiasm-bionano_scaffolds_v1.0.fasta \
-V data/vcf/snps/scaf_220,scaf_221,scaf_222.snps.vcf.gz -F CHROM -F POS -F QUAL -F QD -F DP -F MQ -F AD \
-O data/reports/variantstotable/scaf_220_222.snps.vcf.gz.table
