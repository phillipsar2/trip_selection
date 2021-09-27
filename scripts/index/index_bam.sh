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

samtools index -b data/merged_bams/25560_2.bam
samtools index -b data/merged_bams/25560_3.bam
samtools index -b data/merged_bams/25560_4.bam
samtools index -b data/merged_bams/25560_5.bam
samtools index -b data/merged_bams/25560_6.bam
samtools index -b data/merged_bams/25560_9.bam
samtools index -b data/merged_bams/25612_3.bam
samtools index -b data/merged_bams/25612_4.bam
samtools index -b data/merged_bams/25612_8.bam
samtools index -b data/merged_bams/25614_11.bam

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

samtools index -b data/merged_bams/25625_10.bam
samtools index -b data/merged_bams/25625_11.bam
samtools index -b data/merged_bams/25636_1.bam
samtools index -b data/merged_bams/25636_2.bam
samtools index -b data/merged_bams/25636_3.bam
samtools index -b data/merged_bams/25636_4.bam
samtools index -b data/merged_bams/25636_5.bam
