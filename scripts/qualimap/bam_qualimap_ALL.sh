#!/bin/bash                                                                                                                                                                      #SBATCH --job-name=tripsacum_bam_qualimap_test
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p med2
#SBATCH -t 07-00:00
#SBATCH --mem=32G
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-user=julporter@ucdavis.edu

cd /group/jrigrp10/tripsacum_dact/data/raw_bams
for bamfile in *.bam
do
base= basename $bamfile _HMHFTDSXY_L4_srt_dedup.bam
module load R
module load qualimap
qualimap bamqc -bam $bamfile \
-outdir /group/jrigrp10/tripsacum_dact/data/bam_qualimaps -outformat PDF -outfile $base.pdf
done
