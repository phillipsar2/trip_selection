#!/bin/bash
#SBATCH --job-name=coverage
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p high2
#SBATCH -t 07-00:00
#SBATCH --mem=24G

module load bedtools
bedtools coverage -a data/repeat_abundance/bed_files/repeat/centromere.final.bed \
-b data/repeat_abundance/bed_files/indiv/final/25614_4.MCRGD001_CKDL200167244-1a-D701-AK1680_HMHFTDSXY_L4.MCRGD023_CKDL200167244-1a-DY0088-AK1545_HMHFTDSXY_L4.merged.sorted.cut.merged.bed -d > data/repeat_abundance/coverage/centromere/25614_4.centromere.flipped.coverage.bed
