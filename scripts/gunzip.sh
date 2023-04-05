#!/bin/bash
#SBATCH --job-name=gunzip
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p bigmemh
#SBATCH -t 01-00:00
#SBATCH --mem=24G
##SBATCH --array=1-3

#for repeat in 17SrRNA 25SrRNA 5.8SrRNA brepeat chloroplast mitochondria telomere
#do
#  gunzip -d data/repeat_abundance/coverage/$repeat/*
#done
#for repeat in TIR LTR helitron
#do
#  gunzip -d data/repeat_abundance/coverage/$repeat/*
#done

#gunzip -d data/repeat_abundance/coverage/centromere/*

#gzip data/repeat_abundance/coverage/helitron/*

#gunzip -d data/vcf/final/ALL.DP1_8.rename.vcf.gz

gunzip -d data/repeat_abundance/coverage/allTE/12836_16.MCRGD014_CKDL200167244-1a-D702-AK1544_HMHFTDSXY_L4.MCRGD077_CKDL200167244-1a-D710-AK1543_HMHFTDSXY_L4.merged.allTE.coverage.bed.gz
gunzip -d data/repeat_abundance/coverage/allTE/25612_8.MCRGD009_CKDL200167244-1a-D702-AK1680_HMHFTDSXY_L4.MCRGD087_CKDL200167244-1a-D711-AK1545_HMHFTDSXY_L4.merged.allTE.coverage.bed.gz
gunzip -d data/repeat_abundance/coverage/allTE/25636_2.MCRGD081_CKDL200167244-1a-D711-AK1680_HMHFTDSXY_L4.MCRGD082_CKDL200167244-1a-D711-AK1681_HMHFTDSXY_L4.merged.allTE.coverage.bed.gz

