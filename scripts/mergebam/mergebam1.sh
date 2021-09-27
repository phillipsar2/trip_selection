#!/bin/bash
#SBATCH --job-name=mergebam
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p med2
#SBATCH -t 07-00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=4

samtools merge -@ 4 data/merged_bams/12836_1.bam data/raw_bams/AN20TSCR000043_CKDL200167244-1a-D706-AK1682_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000055_CKDL200167244-1a-D707-AK1545_HMHFTDSXY_L4_srt_dedup.bam

samtools merge -@ 4 data/merged_bams/12836_10.bam data/raw_bams/AN20TSCR000021_CKDL200167244-1a-DY0088-AK1543_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000078_CKDL200167244-1a-D710-AK1544_HMHFTDSXY_L4_srt_dedup.bam

samtools merge -@ 4 data/merged_bams/12836_16.bam data/raw_bams/AN20TSCR000014_CKDL200167244-1a-D702-AK1544_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000077_CKDL200167244-1a-D710-AK1543_HMHFTDSXY_L4_srt_dedup.bam

samtools merge -@ 4 data/merged_bams/12836_9.bam data/raw_bams/AN20TSCR000033_CKDL200167244-1a-D705-AK1680_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000040_CKDL200167244-1a-D705-AK1546_HMHFTDSXY_L4_srt_dedup.bam

samtools merge -@ 4 data/merged_bams/25558_1.bam data/raw_bams/AN20TSCR000046_CKDL200167244-1a-D706-AK1544_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000080_CKDL200167244-1a-D710-AK1546_HMHFTDSXY_L4_srt_dedup.bam

samtools merge -@ 4 data/merged_bams/25558_2.bam data/raw_bams/AN20TSCR000012_CKDL200167244-1a-D702-AK1780_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000050_CKDL200167244-1a-D707-AK1681_HMHFTDSXY_L4_srt_dedup.bam
