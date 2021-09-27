#!/bin/bash
#SBATCH --job-name=index
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p high2
#SBATCH -t 07-00:00
#SBATCH --mem=24G

samtools index -b data/merged_bams/25625_10.bam
samtools index -b data/merged_bams/25625_11.bam
samtools index -b data/merged_bams/25636_1.bam
samtools index -b data/merged_bams/25636_2.bam
samtools index -b data/merged_bams/25636_3.bam
samtools index -b data/merged_bams/25636_4.bam
samtools index -b data/merged_bams/25636_5.bam
