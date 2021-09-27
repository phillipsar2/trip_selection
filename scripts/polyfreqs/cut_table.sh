#!/bin/bash
#SBATCH --job-name=cut_table
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p high
#SBATCH -t 07-00:00
#SBATCH --mem=24G

cut -f 3-49 data/reports/variantstotable/ALL.DP1_12.filtered.snps.AD.table > data/reports/variantstotable/ALL.DP1_12.AD.cut.table
