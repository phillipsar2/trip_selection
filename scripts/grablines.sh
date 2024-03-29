#!/bin/bash
#SBATCH --job-name=awk
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p high2
#SBATCH -t 07-00:00
#SBATCH --mem=8G

awk 'NR % 200 ==0' data/af/SNPnames.noNA.txt > data/af/SNPnames.red.txt
