#!/bin/bash
#SBATCH --job-name=blast.database
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p bigmemh
#SBATCH -t 07-00:00
#SBATCH --mem=32G

makeblastdb -in data/genome/v1/Td-KS_B6_1-Draft-PanAnd-1.0.noalternate.fasta \
-out data/genome/v1/Td-KS_B6_1-Draft-PanAnd-1.0.noalternate.fasta -dbtype nucl -title "Tripsacum dactyloides reference genome v1" -parse_seqids
