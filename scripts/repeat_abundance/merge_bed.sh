#!/bin/bash
#SBATCH --job-name=merge
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p bigmemh
#SBATCH -t 07-00:00
#SBATCH --mem=24G

#for TE in helitron LTR TIR
#  do
#    bedtools merge -c 1 -o count -i data/repeat_abundance/bed_files/repeat/$TE.nonoverlap.bed > \
#    data/repeat_abundance/bed_files/repeat/$TE.final.bed
#  done

module load bedtools
bedtools merge -c 1 -o count -i data/repeat_abundance/bed_files/repeat/TIR.nonoverlap.bed > \
data/repeat/abundance/bed_files/repeat/TIR.final.bed
