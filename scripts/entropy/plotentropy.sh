#!/bin/bash
#SBATCH --job-name=plotentropy
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p med
#SBATCH -t 07-00:00
#SBATCH --mem=24G

module load bio3
source activate entropy-2.0

# extract the mean posterior value of q
#for k in 2 3 4 5 6 7 8
#do
#  estpost.entropy -p q -s 0 data/entropy/mcmc.20k.k$k.chain1.hdf5 -o data/entropy/qest.k$k.chain1.txt
#done

# run script to plot entropy results
#cat scripts/entropy/plotentropy.R
#module load R
#srun Rscript scripts/entropy/plotentropy.R
