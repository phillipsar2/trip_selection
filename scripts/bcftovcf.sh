#!/bin/bash
#SBATCH --job-name=bcftovcf
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p bigmemh
#SBATCH -t 07-00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=8

bcftools view -O z -o tmp.vcf.gz data/vcf/raw_vcf/vcf_scaf_205,scaf_206,scaf_207.vcf
mv tmp.vcf.gz data/vcf/raw_vcf/vcf_scaf_205,scaf_206,scaf_207.vcf.gz
bcftools index -t data/vcf/raw_vcf/vcf_scaf_205,scaf_206,scaf_207.vcf.gz
