#!/bin/bash
#SBATCH --job-name=create.dict
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p bigmemm
#SBATCH -t 07-00:00
#SBATCH --mem=24G

module load maven R java GATK
gatk CreateSequenceDictionary -R data/genome/Tripsacum_dactyloides-southern_hifiasm-bionano_scaffolds_v1.0.fasta

