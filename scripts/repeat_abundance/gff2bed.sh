#!/bin/bash
#SBATCH --job-name=gff2bed
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p high2
#SBATCH -t 07-00:00
#SBATCH --mem=24G

# subset gff file by superfamily
#cat data/edta/Tripsacum-dactyloides-southern_v1.fasta.mod.EDTA.TEanno.gff3 | grep "LTR" > data/edta/LTR.gff3
#cat data/edta/Tripsacum-dactyloides-southern_v1.fasta.mod.EDTA.TEanno.gff3 | grep "TIR" > data/edta/TIR.gff3
#cat data/edta/Tripsacum-dactyloides-southern_v1.fasta.mod.EDTA.TEanno.gff3 | grep "helitron" > data/edta/helitron.gff3
cat data/edta/Tripsacum-dactyloides-southern_v1.fasta.mod.EDTA.TEanno.gff3 | grep "TE" | grep -v "^alt-" > data/edta/allTE.gff3

# remove unnecessary columns
#cut -f 1,4,5,6 data/edta/LTR.gff3 > data/repeat_abundance/bed_files/repeat/LTR.unfiltered.bed
#cut -f 1,4,5,6 data/edta/TIR.gff3 > data/repeat_abundance/bed_files/repeat/TIR.unfiltered.bed
#cut -f 1,4,5,6 data/edta/helitron.gff3 > data/repeat_abundance/bed_files/repeat/helitron.unfiltered.bed
cut -f 1,4,5,6 data/edta/allTE.gff3 > data/repeat_abundance/bed_files/repeat/allTE.unfiltered.bed
