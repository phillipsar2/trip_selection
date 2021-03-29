#!/bin/bash
#SBATCH --job-name=tripsacum_bam_qualimap_test
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p med2
#SBATCH -t 07-00:00
#SBATCH --mem=32G
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-user=julporter@ucdavis.edu

module load R
module load qualimap
qualimap bamqc -bam /group/jrigrp10/tripsacum_dact/data/raw_bams/AN20TSCR000001_CKDL200167244-1a-D701-AK1680_HMHFTDSXY_L4_srt_dedup.bam \
-outdir /group/jrigrp10/tripsacum_dact/data/bam_qualimaps -outformat PDF
