#!/bin/bash
#SBATCH --job-name=blast
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p bigmemh
#SBATCH -t 07-00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=4

blastn -query data/repeatseq/25SrRNA.fasta -db data/genome/Tripsacum_db \
-outfmt '7 qseqid sseqid length qlen slen qstart qend sstart send evalue' -out data/blast/25SrRNA.txt \
-num_threads 4
