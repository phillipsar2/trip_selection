#!/bin/bash
#SBATCH --job-name=pop_af
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/err_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/out_%j.txt
#SBATCH -p high2
#SBATCH -t 01-00:00
#SBATCH --mem=16G

cat scripts/popaf.R
module load R
srun Rscript scripts/popaf.R
