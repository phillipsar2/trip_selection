#!/bin/bash
#SBATCH --job-name=sort
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p high2
#SBATCH -t 07-00:00
#SBATCH --mem=16G

samtools sort -o data/merged_bams/12836_10.sorted.bam data/merged_bams/12836_10.bam
