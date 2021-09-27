#!/bin/bash
#SBATCH --job-name=bwamem
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p high2
#SBATCH -t 07-00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=8

#bwa index data/genome/Tripsacum_dactyloides-southern_hifiasm-bionano_scaffolds_v1.0.fasta
bwa mem -t 8 -a data/genome/Tripsacum_dactyloides-southern_hifiasm-bionano_scaffolds_v1.0.fasta \
data/repeatseq/180knob_centromere.fasta | samtools view -Sb > data/mapped_seq/180knob_centromere.map.all.bam
