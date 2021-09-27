#!/bin/bash
#SBATCH --job-name=qualimap_57
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p bigmemm
#SBATCH -t 07-00:00
#SBATCH --mem=64G

module load R
module load qualimap
qualimap bamqc -bam data/raw_bams/AN20TSCR000057_CKDL200167244-1a-D708-AK1680_HMHFTDSXY_L4_srt_dedup.bam \
-outdir data/reports/bam_qualimaps/AN20TSCR000057_CKDL200167244-1a-D708-AK1680_HMHFTDSXY_L4_srt_stats \
-outformat PDF --java-mem-size 2400M
