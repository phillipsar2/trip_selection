#!/bin/bash
#SBATCH --job-name=mergebam
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p med2
#SBATCH -t 07-00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=4

samtools merge -@ 4 data/merged_bams/256165_9.bam data/raw_bams/AN20TSCR000064_CKDL200167244-1a-D708-AK1546_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000094_CKDL200167244-1a-D712-AK1545_HMHFTDSXY_L4_srt_dedup.bam

samtools merge -@ 4 data/merged_bams/25618_10.bam data/raw_bams/AN20TSCR000004_CKDL200167244-1a-D701-AK1780_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000025_CKDL200167244-1a-D704-AK1680_HMHFTDSXY_L4_srt_dedup.bam

samtools merge -@ 4 data/merged_bams/25618_11.bam data/raw_bams/AN20TSCR000053_CKDL200167244-1a-D707-AK1543_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000068_CKDL200167244-1a-D709-AK1780_HMHFTDSXY_L4_srt_dedup.bam

samtools merge -@ 4 data/merged_bams/25618_4.bam data/raw_bams/AN20TSCR000008_CKDL200167244-1a-D701-AK1546_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000027_CKDL200167244-1a-D704-AK1682_HMHFTDSXY_L4_srt_dedup.bam

samtools merge -@ 4 data/merged_bams/25618_5.bam data/raw_bams/AN20TSCR000022_CKDL200167244-1a-DY0088-AK1544_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000065_CKDL200167244-1a-D709-AK1680_HMHFTDSXY_L4_srt_dedup.bam
