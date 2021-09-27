#!/bin/bash
#SBATCH --job-name=tripsacum_snp_calling_test1
#SBATCH -D /home/group/jrigrp10/tripsacum_dact
#SBATCH -e /home/group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /home/group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p med
#SBATCH -t 0:12:00
#SBATCH --mem=32G 
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-user=julporter@ucdavis.edu

module load bcftools
bcftools mpileup -Ou -f /tripsacum_dact/data/genome/Tripsacum_dactyloides-southern_hifiasm-bionano_scaffolds_v1.0.fasta.gz \
/tripsacum_dact/data/raw_bams/AN20TSCR000001_CKDL200167244-1a-D701-AK1680_HMHFTDSXY_L4_srt_dedup.bam \
-- annotate FORMAT/AD, FORMAT/DP | bcftools call -mv -Oz -o /tripsacum_dact/data/vcf/AN20TSCR000001_CKDL200167244-1a-D701-AK1680_HMHFTDSXY_L4_srt_dedup.vcf
## mpileup = generates BCF/VCF w/ genotype likelihoods for one or multiple aligment files (BAM)
## -Ou = output is uncompressed BCF files
## -f =  FASTA reference file
## -b = list of input  BAM files --> dont need for test, but will need LATER
## -mv = use the default calling method(m) and output only variant sites(v)
## -Oz = output type is compressed VCF
## -o = output file

##questions:
##do i include .vcf in the name of the output?
