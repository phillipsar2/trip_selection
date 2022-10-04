#!/bin/bash
#SBATCH --job-name=sum_cov
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p high2
#SBATCH -t 07-00:00
#SBATCH --mem=16G

repeat=chloroplast
echo "$repeat total repeat coverage per individual" > data/repeat_abundance/coverage/sum/$repeat.sum_cov.txt

for indiv in data/repeat_abundance/coverage/$repeat/*
do
# step 1: unzip coverage file
#  gunzip -d $indiv
# step 2: sum the per base coverage using awk to get total coverage of repeat/individual and write to text file
  echo "$indiv" >> data/repeat_abundance/coverage/sum/$repeat.sum_cov.txt
  awk -F '\t' '{sum += $5} END {print sum}' $indiv >> data/repeat_abundance/coverage/sum/$repeat.sum_cov.txt
# step 3: re-zip coverage file
  gzip $indiv
done
