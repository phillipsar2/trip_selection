#!/bin/bash
#SBATCH --job-name=postq
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/err_%A_%a.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/out_%A_%a.txt
#SBATCH -p bigmemh
#SBATCH -t 07-00:00
#SBATCH --mem=10G
#SBATCH --array=2-8%3

module load bio3
source activate entropy-2.0

estpost.entropy -p q -s 0 \
data/entropy/output/mcmc.20k.noNA.k${SLURM_ARRAY_TASK_ID}.c1.hdf5 \
-o data/entropy/output/qest.k${SLURM_ARRAY_TASK_ID}.c1.txt

estpost.entropy -p q -s 0 \
data/entropy/output/mcmc.20k.noNA.k${SLURM_ARRAY_TASK_ID}.c2.hdf5 \
-o data/entropy/output/qest.k${SLURM_ARRAY_TASK_ID}.c2.txt

estpost.entropy -p q -s 0 \
data/entropy/output/mcmc.20k.noNA.k${SLURM_ARRAY_TASK_ID}.c3.hdf5 \
-o data/entropy/output/qest.k${SLURM_ARRAY_TASK_ID}.c3.txt
