#!/bin/bash
#SBATCH --job-name=coverage
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p high2
#SBATCH -t 07-00:00
#SBATCH --mem=24G

module load bedtools
  for indiv in 12836_16 12836_1 12836_9 25558_1 25558_3 25558_4 25558_5 25560_1 25560_2 25560_3 25560_4 25560_5 25560_6 25560_9 25612_3 25612_4 25612_8 25614_11 25614_13 25614_1 25614_2 25614_4 25614_5 25614_6 25614_6 25614_7 25615_2 25615_2 25615_3 25615_4 25618_10 25618_11 25618_4 25618_5 25618_6 25618_7 25618_9 25625_10 25625_11 25636_1 25636_2 25636_3 25636_4 25636_5
  do
bedtools coverage -a data/repeat_abundance/bed_files/repeat/centromere.final.bed \
-b data/repeat_abundance/bed_files/indiv/final/25614_4 \
-d > data/repeat_abundance/coverage/allTE/$indiv.allTE.coverage.bed
  done
#done
