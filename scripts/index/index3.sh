#!/bin/bash
#SBATCH --job-name=index
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p high2
#SBATCH -t 07-00:00
#SBATCH --mem=24G

samtools index -b data/merged_bams/25614_13.bam
samtools index -b data/merged_bams/25614_1.bam
samtools index -b data/merged_bams/25614_2.bam
samtools index -b data/merged_bams/25614_4.bam
samtools index -b data/merged_bams/25614_5.bam
samtools index -b data/merged_bams/25614_6.bam
samtools index -b data/merged_bams/25614_7.bam
samtools index -b data/merged_bams/25615_2.bam
samtools index -b data/merged_bams/25615_3.bam
samtools index -b data/merged_bams/25615_4.bam


