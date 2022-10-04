#!/bin/bash
#SBATCH --job-name=af
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/err_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/out_%j.txt
#SBATCH -p bigmemh
#SBATCH -t 01-00:00
#SBATCH --mem=16G

cat scripts/overallaf.R
module load R
srun Rscript scripts/overallaf.R
