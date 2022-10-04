#!/bin/bash
#SBATCH -D /home/wang9418/Tripsacum/repeat_nonoverlap/
#SBATCH --partition=med
#SBATCH --job-name=wang9418_merge_job
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --mem=1G
#SBATCH --time=24:00:00
#SBATCH --output=../outfile_merge.out
#SBATCH --error=../outfile_merge.err

source ~/.bashrc
conda activate rotate3

while read name
do 
    bedtools merge -i ${name}.nonoverlap.bed -c 1 -o count > ../repeat_merge/${name}.merged.bed
done < ../file_names.txt