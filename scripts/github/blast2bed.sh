#!/bin/bash
#SBATCH --job-name=blast2bed
#SBATCH -D /group/jrigrp10/tripsacum_dact
#SBATCH -e /group/jrigrp10/tripsacum_dact/slurm_log/sterror_%j.txt
#SBATCH -o /group/jrigrp10/tripsacum_dact/slurm_log/stdoutput_%j.txt
#SBATCH -p bigmemh
#SBATCH -t 07-00:00
#SBATCH --mem=24G

module load perl
INPUT="data/blast/25SrRNA.txt"

#check if input file is provided
if [ -f "$INPUT" ];
then
    OUTPUT=$(echo $INPUT | sed -e s/.txt$//)'.unfiltered.bed'
else
    echo "ERROR: No input file provided or file does not exist.
Usage: ./blast2bed <blastoutput.bls>
The blast file should be in blast outfmt 6 or 7.
See Readme.org for more details."
    exit 1
fi

#converting blast to bed
echo "converting $INPUT in $OUTPUT"

echo "#This file was generated from $INPUT using blast2bed" > $OUTPUT
#grep -v '^#' "$INPUT" | awk '{print $2,"\t",$9-1,"\t",$10,"\t",$1}' | sort >> $OUTPUT
#grep -v '^#' "$INPUT" | perl -ane 'if($F[8]<=$F[9]){print join("\t",$F[2],$F[8]-1,$F[9],$F[3],$F[5],$F[4],$F[6],$F[7],$F[10],"+"),"\n";}else{print join("\t",$F[2],$F[9]-1,$F[8],$F[3],$F[5],$F[4],$F[6],$F[7],$F[10],"-"),"\n";}' | sort >> $OUTPUT
grep -v '^#' "$INPUT" | perl -ane 'if($F[7]<=$F[8]){print join("\t",$F[1],$F[7],$F[8],$F[2],$F[4],$F[3],$F[5],$F[6],$F[9],"+"),"\n";}else{print join("\t",$F[1],$F[8],$F[7],$F[2],$F[4],$F[3],$F[5],$F[6],$F[9],"-"),"\n";}' | sort >> $OUTPUT


echo "done"
