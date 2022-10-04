#!/bin/bash
#SBATCH --job-name=entropy
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/err_%A_%a.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/out_%A_%a.txt
#SBATCH -p bigmemm
#SBATCH -t 07-00:00
#SBATCH --mem=10G
#SBATCH --array=2-8%3

SEED=4

mkdir -p /scratch/julespor/entropy/k${SLURM_ARRAY_TASK_ID}.c$SEED/

module load bio3
source activate entropy-2.0

entropy -i data/entropy/input/20k.noNA.mpgl \
-m 1 \
-n 4 \
-k ${SLURM_ARRAY_TASK_ID} \
-q data/entropy/input/qk${SLURM_ARRAY_TASK_ID}inds.noNA.txt \
-l 60000 \
-b 2000 \
-t 100 \
-D 0 \
-r $SEED \
-o /scratch/julespor/entropy/k${SLURM_ARRAY_TASK_ID}.c$SEED/mcmc.20k.noNA.k${SLURM_ARRAY_TASK_ID}.c$SEED.hdf5

mv /scratch/julespor/entropy/k${SLURM_ARRAY_TASK_ID}.c$SEED/* /group/jrigrp10/tripsacum_dact/data/entropy/output/
rmdir /scratch/julespor/entropy/k${SLURM_ARRAY_TASK_ID}.c$SEED/
