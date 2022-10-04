#!/bin/bash
#SBATCH --job-name=sort
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p bigmemm
#SBATCH -t 07-00:00
#SBATCH --mem=24G

sort -k1,1 -k2,2n data/repeat_abundance/bed_files/repeat/helitron.unfiltered.bed \
> data/repeat_abundance/bed_files/repeat/helitron.sorted.bed

sort -k1,1 -k2,2n data/repeat_abundance/bed_files/repeat/LTR.unfiltered.bed \
> data/repeat_abundance/bed_files/repeat/LTR.sorted.bed

sort -k1,1 -k2,2n data/repeat_abundance/bed_files/repeat/TIR.unfiltered.bed \
> data/repeat_abundance/bed_files/repeat/TIR.sorted.bed


