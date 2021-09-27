#!/bin/bash
#SBATCH --job-name=mergebam
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p med2
#SBATCH -t 07-00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=4

samtools merge -@ 4 data/merged_bams/25614_2.bam data/raw_bams/AN20TSCR000003_CKDL200167244-1a-D701-AK1682_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000067_CKDL200167244-1a-D709-AK1682_HMHFTDSXY_L4_srt_dedup.bam

samtools merge -@ 4 data/merged_bams/25614_4.bam data/raw_bams/AN20TSCR000001_CKDL200167244-1a-D701-AK1680_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000023_CKDL200167244-1a-DY0088-AK1545_HMHFTDSXY_L4_srt_dedup.bam

samtools merge -@ 4 data/merged_bams/25614_5 data/raw_bams/AN20TSCR000024_CKDL200167244-1a-DY0088-AK1546_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000054_CKDL200167244-1a-D707-AK1544_HMHFTDSXY_L4_srt_dedup.bam

samtools merge -@ 4 data/merged_bams/25614_6.bam data/raw_bams/AN20TSCR000052_CKDL200167244-1a-D707-AK1780_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000092_CKDL200167244-1a-D712-AK1780_HMHFTDSXY_L4_srt_dedup.bam

samtools merge -@ 4 data/merged_bams/25614_7.bam data/raw_bams/AN20TSCR000017_CKDL200167244-1a-DY0088-AK1680_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000063_CKDL200167244-1a-D708-AK1545_HMHFTDSXY_L4_srt_dedup.bam
