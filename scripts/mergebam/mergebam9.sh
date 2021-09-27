#!/bin/bash
#SBATCH --job-name=mergebam
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p med2
#SBATCH -t 07-00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=4

samtools merge -@ 4 data/merged_bams/25636_1.bam data/raw_bams/AN20TSCR000006_CKDL200167244-1a-D701-AK1544_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000069_CKDL200167244-1a-D709-AK1543_HMHFTDSXY_L4_srt_dedup.bam

samtools merge -@ 4 data/merged_bams/25636_2.bam data/raw_bams/AN20TSCR000081_CKDL200167244-1a-D711-AK1680_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000082_CKDL200167244-1a-D711-AK1681_HMHFTDSXY_L4_srt_dedup.bam

samtools merge -@ 4 data/merged_bams/25636_3.bam data/raw_bams/AN20TSCR000029_CKDL200167244-1a-D704-AK1543_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000060_CKDL200167244-1a-D708-AK1780_HMHFTDSXY_L4_srt_dedup.bam

samtools merge -@ 4 data/merged_bams/25636_4.bam data/raw_bams/AN20TSCR000061_CKDL200167244-1a-D708-AK1543_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000083_CKDL200167244-1a-D711-AK1682_HMHFTDSXY_L4_srt_dedup.bam

samtools merge -@ 4 data/merged_bams/25636_5.bam data/raw_bams/AN20TSCR000035_CKDL200167244-1a-D705-AK1682_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000072_CKDL200167244-1a-D709-AK1546_HMHFTDSXY_L4_srt_dedup.bam
