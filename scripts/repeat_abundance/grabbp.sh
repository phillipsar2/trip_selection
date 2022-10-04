#!/bin/bash
#SBATCH --job-name=grab_bp
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p high2
#SBATCH -t 07-00:00
#SBATCH --mem=8G
#SBATCH --array=1-42

echo "Number of Sequenced Bases per Individual" >> data/reports/qualimap/seq_bp.txt
for indiv in data/reports/qualimap/*
do
  cd $indiv/
  cat genome_results.txt | grep "number of sequenced bases" > ../seq_bp.txt
  cd ../
done
