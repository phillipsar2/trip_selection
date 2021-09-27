#!/bin/bash
#SBATCH --job-name=index
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p high2
#SBATCH -t 07-00:00
#SBATCH --mem=24G

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
