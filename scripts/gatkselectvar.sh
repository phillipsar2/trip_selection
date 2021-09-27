#!/bin/bash
#SBATCH --job-name=gatk
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p bigmemh
#SBATCH -t 07-00:00
#SBATCH --mem=16Gb
#SBATCH --cpus-per-task=4

module load maven R java GATK
gatk SelectVariants -R data/genome/Tripsacum_dactyloides-southern_hifiasm-bionano_scaffolds_v1.0.fasta \
-V data/vcf/raw_vcf/vcf_scaf_205,scaf_206,scaf_207.vcf.gz -select-type SNP --restrict-alleles-to BIALLELIC \
-O data/vcf/snps/scaf_205,scaf_206,scaf_207.snps.vcf.gz
