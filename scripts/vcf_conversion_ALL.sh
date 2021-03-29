#!/bin/bash
#SBATCH --job-name=tripsacum_vcf_conversion_ALL
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p med2
#SBATCH -t 07-00:00
#SBATCH --mem=32G
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-user=julporter@ucdavis.edu

module load bcftools
bcftools mpileup -Ou --annotate "FORMAT/AD,FORMAT/DP" -f data/genome/Tripsacum_dactyloides-southern_hifiasm-bionano_scaffolds_v1.0.fasta \
-b data/raw_bams/bam_list.txt -r [scaffold] | bcftools call -mv -Oz -o vcf_[scaffold].vcf
