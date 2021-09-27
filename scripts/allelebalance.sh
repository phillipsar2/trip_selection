#!/bin/bash
#SBATCH --job-name=calcAB
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p high2
#SBATCH -t 07-00:00
#SBATCH --mem=150G
#SBATCH -x c6-92

cat scripts/allelebalance.R
module load R
srun Rscript --min-vsize=10M --max-vsize=100M --min-nsize=100G scripts/allelebalance.R

