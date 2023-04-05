#!/bin/bash
#SBATCH --job-name=kin
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/err_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/out_%j.txt
#SBATCH -p bigmemh
#SBATCH -t 07-00:00
#SBATCH --mem=16G

cat scripts/kinship/kinship.R
module load R
srun Rscript scripts/kinship/kinship.R
