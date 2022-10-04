#!/bin/bash
#SBATCH --job-name=ebg
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p bigmemh
#SBATCH -t 00-11:00
#SBATCH --mem=10G

# get help for disequilibrium model
#polyploid-genotyping/ebg/ebg diseq -h

# test ebg on a single file
#polyploid-genotyping/ebg/ebg diseq -p 4 \
#-n 42 \
#-l 1480986 \
#-t data/ebg/input/scaf_1.tot_reads.txt \
#-a data/ebg/input/scaf_1.alt_reads.txt \
#-e data/ebg/input/scaf_1.err.txt \
#--prefix data/ebg/output/scaf_1.diseq \
#--iters 1000

# run ebg on 20k randomly chosen snps that contain no missing data
polyploid-genotyping/ebg/ebg diseq \
-p 4 \
-n 42 \
-l 20000 \
-t data/ebg/input/20k.noNA.tot.txt \
-a data/ebg/input/20k.noNA.alt.txt \
-e data/ebg/input/20k.noNA.err.txt \
--prefix data/ebg/output/20k.noNA \
--iters 1000

# overall convergence was reached typically between 50 and 100 iterations

