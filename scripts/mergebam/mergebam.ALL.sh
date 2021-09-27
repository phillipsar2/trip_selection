#!/bin/bash
#SBATCH --job-name=mergebam
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p med2
#SBATCH -t 07-00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=4

samtools merge data/raw_bams/AN20TSCR000043_CKDL200167244-1a-D706-AK1682_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000055_CKDL200167244-1a-D707-AK1545_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000021_CKDL200167244-1a-DY0088-AK1543_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000078_CKDL200167244-1a-D710-AK1544_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000014_CKDL200167244-1a-D702-AK1544_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000077_CKDL200167244-1a-D710-AK1543_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000033_CKDL200167244-1a-D705-AK1680_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000040_CKDL200167244-1a-D705-AK1546_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000046_CKDL200167244-1a-D706-AK1544_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000080_CKDL200167244-1a-D710-AK1546_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000012_CKDL200167244-1a-D702-AK1780_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000050_CKDL200167244-1a-D707-AK1681_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000047_CKDL200167244-1a-D706-AK1545_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000074_CKDL200167244-1a-D710-AK1681_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000015_CKDL200167244-1a-D702-AK1545_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000026_CKDL200167244-1a-D704-AK1681_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000042_CKDL200167244-1a-D706-AK1681_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000070_CKDL200167244-1a-D709-AK1544_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000056_CKDL200167244-1a-D707-AK1546_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000073_CKDL200167244-1a-D710-AK1680_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000038_CKDL200167244-1a-D705-AK1544_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000090_CKDL200167244-1a-D712-AK1681_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000091_CKDL200167244-1a-D712-AK1682_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000093_CKDL200167244-1a-D712-AK1543_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000002_CKDL200167244-1a-D701-AK1681_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000059_CKDL200167244-1a-D708-AK1682_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000018_CKDL200167244-1a-DY0088-AK1681_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000058_CKDL200167244-1a-D708-AK1681_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000010_CKDL200167244-1a-D702-AK1681_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000085_CKDL200167244-1a-D711-AK1543_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000011_CKDL200167244-1a-D702-AK1682_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000049_CKDL200167244-1a-D707-AK1680_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000045_CKDL200167244-1a-D706-AK1543_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000057_CKDL200167244-1a-D708-AK1680_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000009_CKDL200167244-1a-D702-AK1680_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000087_CKDL200167244-1a-D711-AK1545_HMHFTDSXY_L4_srt_dedup.bam

samtools merge data/raw_bams/AN20TSCR000005_CKDL200167244-1a-D701-AK1543_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000041_CKDL200167244-1a-D706-AK1680_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000030_CKDL200167244-1a-D704-AK1544_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000086_CKDL200167244-1a-D711-AK1544_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000013_CKDL200167244-1a-D702-AK1543_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000034_CKDL200167244-1a-D705-AK1681_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000003_CKDL200167244-1a-D701-AK1682_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000067_CKDL200167244-1a-D709-AK1682_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000001_CKDL200167244-1a-D701-AK1680_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000023_CKDL200167244-1a-DY0088-AK1545_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000024_CKDL200167244-1a-DY0088-AK1546_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000054_CKDL200167244-1a-D707-AK1544_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000052_CKDL200167244-1a-D707-AK1780_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000092_CKDL200167244-1a-D712-AK1780_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000017_CKDL200167244-1a-DY0088-AK1680_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000063_CKDL200167244-1a-D708-AK1545_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000028_CKDL200167244-1a-D704-AK1780_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000084_CKDL200167244-1a-D711-AK1780_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000031_CKDL200167244-1a-D704-AK1545_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000076_CKDL200167244-1a-D710-AK1780_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000020_CKDL200167244-1a-DY0088-AK1780_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000044_CKDL200167244-1a-D706-AK1780_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000088_CKDL200167244-1a-D711-AK1546_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000095_CKDL200167244-1a-D712-AK1546_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000048_CKDL200167244-1a-D706-AK1546_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000062_CKDL200167244-1a-D708-AK1544_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000064_CKDL200167244-1a-D708-AK1546_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000094_CKDL200167244-1a-D712-AK1545_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000004_CKDL200167244-1a-D701-AK1780_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000025_CKDL200167244-1a-D704-AK1680_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000053_CKDL200167244-1a-D707-AK1543_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000068_CKDL200167244-1a-D709-AK1780_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000008_CKDL200167244-1a-D701-AK1546_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000027_CKDL200167244-1a-D704-AK1682_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000022_CKDL200167244-1a-DY0088-AK1544_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000065_CKDL200167244-1a-D709-AK1680_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000039_CKDL200167244-1a-D705-AK1545_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000089_CKDL200167244-1a-D712-AK1680_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000036_CKDL200167244-1a-D705-AK1780_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000075_CKDL200167244-1a-D710-AK1682_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000019_CKDL200167244-1a-DY0088-AK1682_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000066_CKDL200167244-1a-D709-AK1681_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000032_CKDL200167244-1a-D704-AK1546_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000071_CKDL200167244-1a-D709-AK1545_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000051_CKDL200167244-1a-D707-AK1682_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000079_CKDL200167244-1a-D710-AK1545_HMHFTDSXY_L4_srt_dedup.bam [output.bam]
``````````````
samtools merge data/raw_bams/AN20TSCR000006_CKDL200167244-1a-D701-AK1544_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000069_CKDL200167244-1a-D709-AK1543_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000081_CKDL200167244-1a-D711-AK1680_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000082_CKDL200167244-1a-D711-AK1681_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000029_CKDL200167244-1a-D704-AK1543_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000060_CKDL200167244-1a-D708-AK1780_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000061_CKDL200167244-1a-D708-AK1543_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000083_CKDL200167244-1a-D711-AK1682_HMHFTDSXY_L4_srt_dedup.bam [output.bam]

samtools merge data/raw_bams/AN20TSCR000035_CKDL200167244-1a-D705-AK1682_HMHFTDSXY_L4_srt_dedup.bam \
data/raw_bams/AN20TSCR000072_CKDL200167244-1a-D709-AK1546_HMHFTDSXY_L4_srt_dedup.bam [output.bam]


