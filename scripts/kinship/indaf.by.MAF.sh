#!/bin/bash
#SBATCH --job-name=af
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p high2
#SBATCH -t 00-10:00
#SBATCH --mem=16G

cat scripts/kinship/indaf.by.MAF.R
module load R
srun Rscript scripts/kinship/indaf.by.MAF.R
