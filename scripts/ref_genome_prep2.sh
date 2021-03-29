#!/bin/bash
#SBATCH --job-name=tripsacum_ref_prep
#SBATCH -D /group/jrigrp10/tripsacum_dact/data/genome
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p med2
#SBATCH -t 07-00:00
#SBATCH --mem=32G
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-user=julporter@ucdavis.edu

samtools faidx /group/jrigrp10/tripsacum_dact/data/genome/Tripsacum_dactyloides-southern_hifiasm-bionano_scaffolds_v1.0.fasta
