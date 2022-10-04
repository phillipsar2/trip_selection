#!/bin/bash
#SBATCH --job-name=grep
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p high
#SBATCH -t 07-00:00
#SBATCH --mem=32G
#SBATCH --array=1-3

for repeat in helitron TIR LTR
do
  grep -iv "alt" data/repeat_abundance/bed_files/repeat/class/$repeat.final.bed > data/repeat_abundance/bed_files/repeat/class/$repeat.noalt.final.bed
done
