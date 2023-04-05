#!/bin/bash
#SBATCH --job-name=uniqreads
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/err_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/out_%j.txt
#SBATCH -p high2
#SBATCH -t 07-00:00
#SBATCH --mem=32G

cd data/repeat_abundance/bed_files/indiv/final/



for indiv in *merged.sorted.cut.merged.bed
do
  
