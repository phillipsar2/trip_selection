#!/bin/bash
#SBATCH --job-name=mergebam
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p med2
#SBATCH -t 07-00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=4

samtools merge -@ 4 data/merged_bams/25560_3.bam data/raw_bams/AN20TSCR000091_CKDL200167244-1a-D712-AK1682_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000093_CKDL200167244-1a-D712-AK1543_HMHFTDSXY_L4_srt_dedup.bam

samtools merge -@ 4 data/merged_bams/25560_4.bam data/raw_bams/AN20TSCR000002_CKDL200167244-1a-D701-AK1681_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000059_CKDL200167244-1a-D708-AK1682_HMHFTDSXY_L4_srt_dedup.bam

samtools merge -@ 4 data/merged_bams/25560_5.bam data/raw_bams/AN20TSCR000018_CKDL200167244-1a-DY0088-AK1681_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000058_CKDL200167244-1a-D708-AK1681_HMHFTDSXY_L4_srt_dedup.bam

samtools merge -@ 4 data/merged_bams/25560_6.bam data/raw_bams/AN20TSCR000010_CKDL200167244-1a-D702-AK1681_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000085_CKDL200167244-1a-D711-AK1543_HMHFTDSXY_L4_srt_dedup.bam

samtools merge -@ 4 data/merged_bams/25612_3.bam data/raw_bams/AN20TSCR000011_CKDL200167244-1a-D702-AK1682_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000049_CKDL200167244-1a-D707-AK1680_HMHFTDSXY_L4_srt_dedup.bam
