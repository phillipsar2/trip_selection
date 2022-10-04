#!/bin/bash
#SBATCH --job-name=convergence
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/err_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/out_%j.txt
#SBATCH -p bigmemh
#SBATCH -t 07-00:00
#SBATCH --mem=16G

cat scripts/entropy/assess.convergence.R
module load R
srun Rscript scripts/entropy/assess.convergence.R data/entropy/output/mcmc.20k.noNA.k8.c3.hdf5
