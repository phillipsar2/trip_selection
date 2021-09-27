#!/bin/bash
#SBATCH --job-name=sed
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p high2
#SBATCH -t 07-00:00
#SBATCH --mem=16G

sed 's/"//g' data/bed_files/brepeat.final.bed > data/bed_files/brepeat.FINAL.bed
sed 's/"//g' data/bed_files/centromere.final.bed > data/bed_files/centromere.FINAL.bed
sed 's/"//g' data/bed_files/chloroplast.final.bed > data/bed_files/chloroplast.FINAL.bed
sed 's/"//g' data/bed_files/mitochondria.final.bed > data/bed_files/mitochondria.FINAL.bed
sed 's/"//g' data/bed_files/TR1.final.bed > data/bed_files/TR1.FINAL.bed

cp data/bed_files/telomere.final.bed data/bed_files/telomere.FINAL.bed
cp data/bed_files/17SrRNA.final.bed data/bed_files/17SrRNA.FINAL.bed
cp data/bed_files/180knob.final.bed data/bed_files/180knob.FINAL.bed
cp data/bed_files/25SrRNA.final.bed data/bed_files/25SrRNA.FINAL.bed
cp data/bed_files/5.8SrRNA.final.bed data/bed_files/5.8SrRNA.FINAL.bed
cp data/bed_files/telomere.final.bed data/bed_files/telomere.FINAL.bed
