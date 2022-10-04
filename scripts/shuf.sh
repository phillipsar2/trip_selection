#!/bin/bash
#SBATCH --job-name=shuf
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p high2
#SBATCH -t 07-00:00
#SBATCH --mem=24G

gunzip -d data/af/ref_af.noNA.txt.gz

head -n 1 data/af/ref_af.noNA.txt > data/af/ref.af.20k.noNA.txt

tail -n 5339630 data/af/ref_af.noNA.txt > data/af/ref_af.no.header.txt

shuf -n 20000 data/af/ref_af.no.header.txt >> data/af/ref.af.20k.noNA.txt
