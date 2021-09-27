#!/bin/bash
#SBATCH --job-name=index
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p high2
#SBATCH -t 07-00:00
#SBATCH --mem=24G

samtools index -b data/merged_bams/25615_6.bam
samtools index -b data/merged_bams/25615_8.bam
samtools index -b data/merged_bams/25615_9.bam
samtools index -b data/merged_bams/25618_10.bam
samtools index -b data/merged_bams/25618_11.bam
samtools index -b data/merged_bams/25618_4.bam
samtools index -b data/merged_bams/25618_5.bam
samtools index -b data/merged_bams/25618_6.bam
samtools index -b data/merged_bams/25618_7.bam
samtools index -b data/merged_bams/25618_9.bam
