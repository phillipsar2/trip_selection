#!/bin/bash
#SBATCH --job-name=awk
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/err_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/out_%j.txt
#SBATCH -p high2
#SBATCH -t 01-00:00
#SBATCH --mem=16G

# awk syntax: awk options 'selection _criteria {action }' input-file > output-file
#awk -F '\t' '{sum += $5-$4} END {print sum}' data/edta/noalt.edta.TE.gff3 > data/edta/TEbpsum.txt
awk -F '\t' '{sum += $2} END {print sum}' data/genome/v1/Td-KS_B6_1-Draft-PanAnd-1.0.noalternate.fasta.fai > data/genome/v1/bpinref.txt
