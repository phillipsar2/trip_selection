#!/bin/bash
#SBATCH --job-name=tripsacum_vcf_conversion_test
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
bcftools mpileup -Ou --annotate "FORMAT/AD,FORMAT/DP" -f /group/jrigrp10/tripsacum_dact/data/genome/Tripsacum_dactyloides-southern_hifiasm-bionano_scaffolds_v1.0.fasta \
/group/jrigrp10/tripsacum_dact/data/raw_bams/AN20TSCR000001_CKDL200167244-1a-D701-AK1680_HMHFTDSXY_L4_srt_dedup.bam | \
bcftools call -mv -Oz -o /group/jrigrp10/tripsacum_dact/data/vcf/AN20TSCR000001_CKDL200167244-1a-D701-AK1680_HMHFTDSXY_L4_srt_dedup.vcf
