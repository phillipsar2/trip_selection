#!/bin/bash
#SBATCH --job-name=sum_cov
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p high
#SBATCH -t 14-00:00
#SBATCH --mem=24G
#SBATCH --array=1-7

#for repeat in 17SrRNA 28SrRNA 5.8SrRNA brepeat centromere chloroplast mitochondria telomere
for repeat in 17SrRNA 25SrRNA 5.8SrRNA brepeat chloroplast mitochondria telomere
do
  echo "$repeat total repeat coverage per individual" > data/repeat_abundance/coverage/sum/$repeat.flipped.sum_cov.txt
  for indiv in data/repeat_abundance/coverage/$repeat/*
  do
# step 2: sum the per base coverage using awk to get total coverage of repeat/individual and write to text file
    echo "$indiv" >> data/repeat_abundance/coverage/sum/$repeat.flipped.sum_cov.txt
    awk -F '\t' '{sum += $5} END {print sum}' $indiv >> data/repeat_abundance/coverage/sum/$repeat.flipped.sum_cov.txt
# step 3: re-zip coverage file
    gzip $indiv
  done
done
