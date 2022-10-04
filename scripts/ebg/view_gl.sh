#!/bin/bash
#SBATCH --job-name=view_gl
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p high2
#SBATCH -t 07-00:00
#SBATCH --mem=8G

cat scripts/ebg/view_gl.R
module load R
srun Rscript scripts/ebg/view_gl.R
