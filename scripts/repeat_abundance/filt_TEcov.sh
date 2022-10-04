#!/bin/bash
#SBATCH --job-name=grep
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p med
#SBATCH -t 07-00:00
#SBATCH --mem=32G
#SBATCH --array=1-3

for repeat in helitron TIR LTR
do
  for indiv in 12836_16 12836_1 12836_9 25558_1 25558_3 25558_4 25558_5 25560_1 25560_2 25560_3 25560_4 25560_5 $
  do
  gunzip -d data/repeat_abundance/coverage/$repeat/$indiv.$repeat.flipped.coverage.bed.gz
  grep -iv "alt" data/repeat_abundance/coverage/$repeat/$indiv.$repeat.flipped.coverage.bed > data/repeat_abundance/coverage/$repeat/$indiv.$repeat.noalt.coverage.bed 
  gzip data/repeat_abundance/coverage/$repeat/$indiv.$repeat.flipped.coverage.bed
  gzip data/repeat_abundance/coverage/$repeat/$indiv.$repeat.noalt.coverage.bed
  done
done
