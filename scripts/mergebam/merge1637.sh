#!/bin/bash
#SBATCH --job-name=mergebam
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p med2
#SBATCH -t 07-00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=4

samtools merge -@ 4 data/merged_bams/25625_8.bam data/raw_bams/AN20TSCR000016_CKDL200167244-1a-D702-AK1546_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000037_CKDL200167244-1a-D705-AK1543_HMHFTDSXY_L4_srt_dedup.bam

samtools index -b data/merged_bams/25625_8.bam

