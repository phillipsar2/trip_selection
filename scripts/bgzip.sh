#!/bin/bash
#SBATCH --job-name=bgzip
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p bigmemh
#SBATCH -t 07-00:00
#SBATCH --mem=100G

bgzip data/coverage/raw_data/17SrRNA/25612_8.17SrRNA.coverage.bed
#bgzip data/coverage/raw_data/17SrRNA/25614_13.17SrRNA.coverage.bed
#bgzip data/coverage/raw_data/17SrRNA/25614_2.17SrRNA.coverage.bed
#bgzip data/coverage/raw_data/17SrRNA/25614_5.17SrRNA.coverage.bed
#bgzip data/coverage/raw_data/17SrRNA/25615_3.17SrRNA.coverage.bed
#bgzip data/coverage/raw_data/17SrRNA/25618_4.17SrRNA.coverage.bed
#bgzip data/coverage/raw_data/17SrRNA/25618_5.17SrRNA.coverage.bed
#bgzip data/coverage/raw_data/17SrRNA/25618_6.17SrRNA.coverage.bed
#bgzip data/coverage/raw_data/17SrRNA/25618_7.17SrRNA.coverage.bed
#bgzip data/coverage/raw_data/17SrRNA/25625_10.17SrRNA.coverage.bed
#bgzip data/coverage/raw_data/17SrRNA/25636_2.17SrRNA.coverage.bed
