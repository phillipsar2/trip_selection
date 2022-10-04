#!/bin/bash
#SBATCH --job-name=ebg_input
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p bigmemm
#SBATCH -t 00-11:00
#SBATCH --mem=32G

cat scripts/ebg/create.20k.ebg.af.R
module load R
srun Rscript scripts/ebg/create.20k.ebg.af.R
