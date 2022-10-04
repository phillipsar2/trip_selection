#!/bin/bash
#SBATCH --job-name=tripsacum_ref_prep
#SBATCH -D /group/jrigrp10/tripsacum_dact/data/genome/v1
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p bigmemh
#SBATCH -t 07-00:00
#SBATCH --mem=135G

# remove alternate haplotype from reference
#module load seqtk
#seqtk subseq Td-KS_B6_1-Draft-PanAnd-1.0.fasta contig.lst > Td-KS_B6_1-Draft-PanAnd-1.0.noalternate.fasta

# prepare samtools index and GATK dictionaries
#samtools faidx Td-KS_B6_1-Draft-PanAnd-1.0.noalternate.fasta
#module load maven R java GATK
#gatk CreateSequenceDictionary -R Td-KS_B6_1-Draft-PanAnd-1.0.noalternate.fasta

# make bwamem2 index 
## requires 28x{ref}G in memory = 4.8G x 28 = 134.4G
module load bwa-mem2
bwa-mem2 index Td-KS_B6_1-Draft-PanAnd-1.0.noalternate.fasta

