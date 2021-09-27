#!/bin/bash
#SBATCH --job-name=tripsacum_bam_qualimap_test
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p med2
#SBATCH -t 07-00:00
#SBATCH --mem=32G

module load R
module load qualimap
qualimap bamqc -bam data/merged_bams/25625_8.bam -outdir data/bam_qualimaps -outformat PDF
