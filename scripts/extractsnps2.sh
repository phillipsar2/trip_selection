#!/bin/bash
#SBATCH --job-name=extractsnps
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p bigmemh
#SBATCH -t 07-00:00
#SBATCH --mem=64G

# update index files
module load samtools
module load bcftools
for name in scaf_2 scaf_16,scaf_17 scaf_41,scaf_44
do
   tabix -f data/vcf/snps/$name.snps.vcf.gz
   tabix -f data/vcf/hard_filter/$name.nocall.filtered.2.snps.vcf.gz
# extract # of SNPs from VCFS in directory: data/vcf/snps/
   echo "$name.snps.vcf.gz" > data/reports/snpcount/$name.snpcount.txt
   bcftools stats data/vcf/snps/$name.snps.vcf.gz | grep "number of SNPs:" >> data/reports/snpcount/$name.snpcount.txt
# extract # of SNPs from VCFs in directory: data/vcf/hard_filter
   echo "$name.nocall.filtered.2.snps.vcf.gz" >> data/reports/snpcount/$name.snpcount.txt
   bcftools stats data/vcf/hard_filter/$name.nocall.filtered.2.snps.vcf.gz | grep "number of SNPs:" >> data/reports/snpcount/$name.snpcount.txt
   for dp in DP1_12 DP1_8 DP2_4 DP2_8 DP2_12
   do
      tabix -f data/vcf/depth_filter/$dp/$name.nocall.$dp.filtered.snps.vcf.gz
      tabix -f data/vcf/max_no_call/$dp/$name.maxnocall.$dp.filtered.snps.vcf.gz
# extract # of SNP from VCFa in directorty: data/vcf/depth_filter/
      echo "$name.nocall.$dp.filtered.snps.vcf.gz" >> data/reports/snpcount/$name.snpcount.txt
      bcftools stats data/vcf/depth_filter/$dp/$name.nocall.$dp.filtered.snps.vcf.gz | grep "number of SNPs:" >> data/reports/snpcount/$name.snpcount.txt
# extract # of SNPs from VCFs in directory: data/vcf/max_no_call/
      echo "$name.maxnocall.$dp.filtered.snps.vcf.gz" >> data/reports/snpcount/$name.snpcount.txt
      bcftools stats data/vcf/max_no_call/$dp/$name.maxnocall.$dp.filtered.snps.vcf.gz | grep "number of SNPs:" >> data/reports/snpcount/$name.snpcount.txt
   done
done
