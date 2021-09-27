#!/bin/bash
#SBATCH --job-name=mergebam
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p med2
#SBATCH -t 07-00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=4

samtools merge -@ 4 data/merged_bams/25612_4.bam data/raw_bams/AN20TSCR000045_CKDL200167244-1a-D706-AK1543_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000057_CKDL200167244-1a-D708-AK1680_HMHFTDSXY_L4_srt_dedup.bam

samtools merge -@ 4 data/merged_bams/25612_8.bam data/raw_bams/AN20TSCR000009_CKDL200167244-1a-D702-AK1680_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000087_CKDL200167244-1a-D711-AK1545_HMHFTDSXY_L4_srt_dedup.bam

samtools merge -@ 4 data/merged_bams/25614_1.bam data/raw_bams/AN20TSCR000005_CKDL200167244-1a-D701-AK1543_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000041_CKDL200167244-1a-D706-AK1680_HMHFTDSXY_L4_srt_dedup.bam

samtools merge -@ 4 data/merged_bams/25614_11.bam data/raw_bams/AN20TSCR000030_CKDL200167244-1a-D704-AK1544_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000086_CKDL200167244-1a-D711-AK1544_HMHFTDSXY_L4_srt_dedup.bam

samtools merge -@ 4 data/merged_bams/25614_13.bam data/raw_bams/AN20TSCR000013_CKDL200167244-1a-D702-AK1543_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000034_CKDL200167244-1a-D705-AK1681_HMHFTDSXY_L4_srt_dedup.bam
