#!/bin/bash
#SBATCH --job-name=filter_MQ
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/err_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/out_%j.txt
#SBATCH -p high2
#SBATCH -t 07-00:00
#SBATCH --mem=16G


module load samtools

samtools view -F 2048 \
 -bo data/repeat_abundance/tmp/25636_5.primary.align.bam \
 data/interm/rg_bam/25636_5.MCRGD035_CKDL200167244-1a-D705-AK1682_HMHFTDSXY_L4.MCRGD072_CKDL200167244-1a-D709-AK1546_HMHFTDSXY_L4.merged.dedup.add_rg.bam

samtools view -q 40 \
 -o data/repeat_abundance/tmp/25636_5.MQ40.bam \
 data/repeat_abundance/tmp/25636_5.primary.align.bam

samtools view -q 1 \
 -U data/repeat_abundance/tmp/25636_5.MQ0.bam \
 data/repeat_abundance/tmp/25636_5.primary.align.bam

module load bedtools
for MQ in MQ0 MQ40
do
 bedtools bamtobed -i data/repeat_abundance/tmp/25636_5.$MQ.bam \
 > data/repeat_abundance/tmp/25636_5.$MQ.bed
 sort -k1,1 -k2,2n -k3,2n data/repeat_abundance/tmp/25636_5.$MQ.bed \
 > data/repeat_abundance/tmp/25636_5.$MQ.sorted.bed
 rm data/repeat_abundance/tmp/25636_5.$MQ.bed
 cat data/repeat_abundance/tmp/25636_5.$MQ.sorted.bed | sort -k 4,4 -u \
 > data/repeat_abundance/tmp/25636_5.$MQ.sorted.uniq.bed
done


#samtools view -q 1 -p \
# -o data/test.bam \
# data/interm/rg_bam/25636_5.MCRGD035_CKDL200167244-1a-D705-AK1682_HMHFTDSXY_L4.MCRGD072_CKDL200167244-1a-D709-AK1546_HMHFTDSXY_L4.merged.dedup.add_rg.bam

#samtools view -q 40 \
# -o data/repeat_abundance/MQ40/25636_5.MCRGD035_CKDL200167244-1a-D705-AK1682_HMHFTDSXY_L4.MCRGD072_CKDL200167244-1a-D709-AK1546_HMHFTDSXY_L4.merged.MQ40.bam \
# data/interm/rg_bam/25636_5.MCRGD035_CKDL200167244-1a-D705-AK1682_HMHFTDSXY_L4.MCRGD072_CKDL200167244-1a-D709-AK1546_HMHFTDSXY_L4.merged.dedup.add_rg.bam
