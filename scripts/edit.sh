#!/bin/bash
#SBATCH --job-name=edit
#SBATCH -D /group/jrigrp10/tripsacum_dact/data/bed_files
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p high
#SBATCH -t 07-00:00
#SBATCH --mem=32

sed 's/"//g' 180knob.filtered.sorted.bed > 180knob.bed
