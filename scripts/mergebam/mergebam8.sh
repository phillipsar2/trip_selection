#!/bin/bash
#SBATCH --job-name=mergebam
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p med2
#SBATCH -t 07-00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=4

samtools merge -@ 4 data/merged_bams/25618_6.bam data/raw_bams/AN20TSCR000039_CKDL200167244-1a-D705-AK1545_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000089_CKDL200167244-1a-D712-AK1680_HMHFTDSXY_L4_srt_dedup.bam

samtools merge -@ 4 data/merged_bams/25618_7.bam data/raw_bams/AN20TSCR000036_CKDL200167244-1a-D705-AK1780_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000075_CKDL200167244-1a-D710-AK1682_HMHFTDSXY_L4_srt_dedup.bam

samtools merge -@ 4 data/merged_bams/25618_9.bam data/raw_bams/AN20TSCR000019_CKDL200167244-1a-DY0088-AK1682_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000066_CKDL200167244-1a-D709-AK1681_HMHFTDSXY_L4_srt_dedup.bam

samtools merge -@ 4 data/merged_bams/25625_10.bam data/raw_bams/AN20TSCR000032_CKDL200167244-1a-D704-AK1546_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000071_CKDL200167244-1a-D709-AK1545_HMHFTDSXY_L4_srt_dedup.bam

samtools merge -@ 4 data/merged_bams/25625_11.bam data/raw_bams/AN20TSCR000051_CKDL200167244-1a-D707-AK1682_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000079_CKDL200167244-1a-D710-AK1545_HMHFTDSXY_L4_srt_dedup.bam
