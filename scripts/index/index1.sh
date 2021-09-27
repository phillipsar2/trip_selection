#!/bin/bash
#SBATCH --job-name=index
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p high2
#SBATCH -t 07-00:00
#SBATCH --mem=24G

samtools index -b data/merged_bams/12836_10.bam
samtools index -b data/merged_bams/12836_16.bam
samtools index -b data/merged_bams/12836_1.bam
samtools index -b data/merged_bams/12836_9.bam
samtools index -b data/merged_bams/25558_1.bam
samtools index -b data/merged_bams/25558_2.bam
samtools index -b data/merged_bams/25558_3.bam
samtools index -b data/merged_bams/25558_4.bam
samtools index -b data/merged_bams/25558_5.bam
samtools index -b data/merged_bams/25560_1.bam
