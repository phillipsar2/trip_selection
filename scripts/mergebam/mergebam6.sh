#!/bin/bash
#SBATCH --job-name=mergebam
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p med2
#SBATCH -t 07-00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=4

samtools merge -@ 4 data/merged_bams/25615_2.bam data/raw_bams/AN20TSCR000028_CKDL200167244-1a-D704-AK1780_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000084_CKDL200167244-1a-D711-AK1780_HMHFTDSXY_L4_srt_dedup.bam

samtools merge -@ 4 data/merged_bams/25615_3.bam data/raw_bams/AN20TSCR000031_CKDL200167244-1a-D704-AK1545_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000076_CKDL200167244-1a-D710-AK1780_HMHFTDSXY_L4_srt_dedup.bam

samtools merge -@ 4 data/merged_bams/25615_4.bam data/raw_bams/AN20TSCR000020_CKDL200167244-1a-DY0088-AK1780_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000044_CKDL200167244-1a-D706-AK1780_HMHFTDSXY_L4_srt_dedup.bam

samtools merge -@ 4 data/merged_bams/25615_6.bam data/raw_bams/AN20TSCR000088_CKDL200167244-1a-D711-AK1546_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000095_CKDL200167244-1a-D712-AK1546_HMHFTDSXY_L4_srt_dedup.bam

samtools merge -@ 4 data/merged_bams/25615_8.bam data/raw_bams/AN20TSCR000048_CKDL200167244-1a-D706-AK1546_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000062_CKDL200167244-1a-D708-AK1544_HMHFTDSXY_L4_srt_dedup.bam
