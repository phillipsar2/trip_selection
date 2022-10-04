#!/bin/bash
#SBATCH --job-name=weirdTE
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/err_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/out_%j.txt
#SBATCH -p high2
#SBATCH -t 01-00:00
#SBATCH --mem=24G

# check 1: sum the length of each class of TE
#for TE in LTR TIR helitron allTE
#do
#  echo "$TE" >> data/edta/bpsum.allclasses.txt
#  awk -F '\t' '{sum += $5-$4} END {print sum}' data/edta/$TE.2.gff3 >> data/edta/bpsum.allclasses.txt
#done
## results:
### LTR: 2,575,043,288
### TIR: 483,529,692
### helitron: 231,879,937
### allTE: 2,704,544,416 --> Something isn't right
### LTR + helitron + TIR = 3,290,452,917 --> this number matches total length of EDTA file (w/out alt scaf)

# check 2: look for overlap between helitron, LTR, and TIR
module load bedtools

## first going to make bed files from raw gff3 files:
#### gff3 order: 1.seqid 2.source 3.sequence_ontology 4.start 5.end 6.score 7.strand 8.phase 9.attributes
#### bed order: chrom chromstart chromend name score strand
#for TE in helitron TIR LTR
#do
#  awk '{print $1 "\t" $4 "\t" $5 "\t" $3 "\t" $6 "\t" $7}' data/edta/$TE.2.gff3 > data/edta/$TE.raw.bed
#  cut -f 1,4,5,3,6,7 data/edta/$TE.2.gff3 > data/edta/$TE.raw.bed --> doesn't give desired order
#done

## helitron
#bedtools intersect -u -s \
#-a data/edta/helitron.raw.bed \
#-b data/edta/LTR.raw.bed data/edta/TIR.raw.bed \
#>> data/edta/helitron.intersect.strand.bed

## LTR
#bedtools intersect -u -s \
#-a data/edta/LTR.raw.bed \
#-b data/edta/helitron.raw.bed data/edta/TIR.raw.bed \
#>> data/edta/LTR.intersect.strand.bed

## TIR
#bedtools intersect -u -s \
#-a data/edta/TIR.raw.bed \
#-b data/edta/LTR.raw.bed data/edta/helitron.raw.bed \
#>> data/edta/TIR.intersect.strand.bed

# check 3: print unique lines (no overlap in A)

## helitron
#bedtools intersect -v -s \
#-a data/edta/helitron.raw.bed \
#-b data/edta/LTR.raw.bed data/edta/TIR.raw.bed \
#> data/edta/helitron.unique.strand.bed

## LTR
#bedtools intersect -v -s \
#-a data/edta/LTR.raw.bed \
#-b data/edta/helitron.raw.bed data/edta/TIR.raw.bed \
#> data/edta/LTR.unique.strand.bed

## TIR
#bedtools intersect -v -s \
#-a data/edta/TIR.raw.bed \
#-b data/edta/helitron.raw.bed data/edta/LTR.raw.bed \
#> data/edta/TIR.unique.strand.bed


# check 4: intersect noalt.edta.TE with itself: # rows greater than noalt.edta.te.gff3 will be how many regions of overlap their are??

##first must make noalt.edta.TE into a bed file
#awk '{print $1 "\t" $4 "\t" $5 "\t" $3 "\t" $6 "\t" $7}' data/edta/noalt.edta.TE.gff3 > data/edta/noalt.raw.bed

bedtools intersect -wa -wb -s \
-a data/edta/noalt.raw.bed \
-b data/edta/noalt.raw.bed \
> data/edta/noalt.intersect.w.self.strand.bed

