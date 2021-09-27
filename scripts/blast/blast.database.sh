#!/bin/bash
#SBATCH --job-name=blast.database
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p bigmemh
#SBATCH -t 07-00:00
#SBATCH --mem=32G

makeblastdb -in data/genome/zea/Zm-B73-REFERENCE-NAM-5.0.fa \
-out data/genome/zea/B73_db -dbtype nucl -title "Zea mays B73 reference genome" -parse_seqids
