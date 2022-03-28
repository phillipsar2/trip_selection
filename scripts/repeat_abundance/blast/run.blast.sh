#!/bin/bash
#SBATCH --job-name=blast
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p bigmemh
#SBATCH -t 07-00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=4

#blastn -query data/repeat_abundance/repeat_seq/180knob.fasta -db data/genome/v1/Td-KS_B6_1-Draft-PanAnd-1.0.noalternate.fasta \
#-outfmt '7 qseqid sseqid length qlen slen qstart qend sstart send evalue' \
#-out data/repeat_abundance/blast/180knob.txt -num_threads 4

#blastn -query data/repeat_abundance/repeat_seq/17SrRNA.fasta -db data/genome/v1/Td-KS_B6_1-Draft-PanAnd-1.0.noalternate.fasta \
#-outfmt '7 qseqid sseqid length qlen slen qstart qend sstart send evalue' \
#-out data/repeat_abundance/blast/17SrRNA.txt -num_threads 4

#blastn -query data/repeat_abundance/repeat_seq/25SrRNA.fasta -db data/genome/v1/Td-KS_B6_1-Draft-PanAnd-1.0.noalternate.fasta \
#-outfmt '7 qseqid sseqid length qlen slen qstart qend sstart send evalue' \
#-out data/repeat_abundance/blast/25SrRNA.txt -num_threads 4

#blastn -query data/repeat_abundance/repeat_seq/5.8SrRNA.fasta -db data/genome/v1/Td-KS_B6_1-Draft-PanAnd-1.0.noalternate.fasta \
#-outfmt '7 qseqid sseqid length qlen slen qstart qend sstart send evalue' \
#-out data/repeat_abundance/blast/5.8SrRNA.txt -num_threads 4

#blastn -query data/repeat_abundance/repeat_seq/brepeat.fasta -db data/genome/v1/Td-KS_B6_1-Draft-PanAnd-1.0.noalternate.fasta \
#-outfmt '7 qseqid sseqid length qlen slen qstart qend sstart send evalue' \
#-out data/repeat_abundance/blast/brepeat.txt -num_threads 4

#blastn -query data/repeat_abundance/repeat_seq/centromere.fasta -db data/genome/v1/Td-KS_B6_1-Draft-PanAnd-1.0.noalternate.fasta \
#-outfmt '7 qseqid sseqid length qlen slen qstart qend sstart send evalue' \
#-out data/repeat_abundance/blast/centromere.txt -num_threads 4

#blastn -query data/repeat_abundance/repeat_seq/chloroplast.fasta -db data/genome/v1/Td-KS_B6_1-Draft-PanAnd-1.0.noalternate.fasta \
#-outfmt '7 qseqid sseqid length qlen slen qstart qend sstart send evalue' \
#-out data/repeat_abundance/blast/chloroplast.txt -num_threads 4

blastn -query data/repeat_abundance/repeat_seq/maizeTR1.fasta -db data/genome/v1/Td-KS_B6_1-Draft-PanAnd-1.0.noalternate.fasta \
-outfmt '7 qseqid sseqid length qlen slen qstart qend sstart send evalue' \
-out data/repeat_abundance/blast/maizeTR1.txt -num_threads 4

blastn -query data/repeat_abundance/repeat_seq/mitochondria.fasta -db data/genome/v1/Td-KS_B6_1-Draft-PanAnd-1.0.noalternate.fasta \
-outfmt '7 qseqid sseqid length qlen slen qstart qend sstart send evalue' \
-out data/repeat_abundance/blast/mitochondria.txt -num_threads 4

# special blast settings for short sequences: https://www.biostars.org/p/47203/
#blastn -query data/repeat_abundance/repeat_seq/telomere.fasta -db data/genome/v1/Td-KS_B6_1-Draft-PanAnd-1.0.noalternate.fasta \
#-outfmt '7 qseqid sseqid length qlen slen qstart qend sstart send evalue' \
#-out data/repeat_abundance/blast/telomere.txt -num_threads 4 -task blastn-short -evalue 1000 -word_size 7 -dust 'no'
