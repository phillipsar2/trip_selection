#!/bin/bash
#SBATCH --job-name=filter_bed
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p bigmemm
#SBATCH -t 07-00:00
#SBATCH --mem=8G

cat scripts/repeat_abundance/filter_bed.R
module load R
srun Rscript scripts/repeat_abundance/filter_bed.R
