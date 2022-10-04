#!/bin/bash
#SBATCH --job-name=coverage_hist
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/err_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/out_%j.txt
#SBATCH -p high2
#SBATCH -t 01-00:00
#SBATCH --mem=24G

cat scripts/cov_hist.sh
module load R
srun Rscript scripts/cov_hist.R
