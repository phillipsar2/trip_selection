#!/bin/bash
#SBATCH --job-name=pull_stats
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p high
#SBATCH -t 07-00:00
#SBATCH --mem=32G

cd data/reports/bam_qualimaps/
for directoy in *_stats
do
    cd $directory
    cat genome_results.txt | grep "GC percentage" >> GC%.summary.txt
done
