#!/bin/bash
#SBATCH --job-name=mergebam
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p med2
#SBATCH -t 07-00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=4

samtools merge -@ 4 data/merged_bams/25558_3.bam data/raw_bams/AN20TSCR000047_CKDL200167244-1a-D706-AK1545_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000074_CKDL200167244-1a-D710-AK1681_HMHFTDSXY_L4_srt_dedup.bam

samtools merge -@ 4 data/merged_bams/25558_4.bam data/raw_bams/AN20TSCR000015_CKDL200167244-1a-D702-AK1545_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000026_CKDL200167244-1a-D704-AK1681_HMHFTDSXY_L4_srt_dedup.bam

samtools merge -@ 4 data/merged_bams/25558_5.bam data/raw_bams/AN20TSCR000042_CKDL200167244-1a-D706-AK1681_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000070_CKDL200167244-1a-D709-AK1544_HMHFTDSXY_L4_srt_dedup.bam

samtools merge -@ 4 data/merged_bams/25560_1.bam data/raw_bams/AN20TSCR000056_CKDL200167244-1a-D707-AK1546_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000073_CKDL200167244-1a-D710-AK1680_HMHFTDSXY_L4_srt_dedup.bam

samtools merge -@ 4 data/merged_bams/25560_2.bam data/raw_bams/AN20TSCR000038_CKDL200167244-1a-D705-AK1544_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000090_CKDL200167244-1a-D712-AK1681_HMHFTDSXY_L4_srt_dedup.bam


