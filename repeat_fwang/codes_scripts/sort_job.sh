#!/bin/bash
#SBATCH -D /home/wang9418/Tripsacum/repeat_filtered
#SBATCH --partition=med
#SBATCH --job-name=wang9418_sort_job
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --mem=1G
#SBATCH --time=24:00:00
#SBATCH --output=outfile.out
#SBATCH --error=outfile.err

source ~/.bashrc
conda activate rotate3



while read name
do 
    bedtools sort -i ${name}.filtered.bed > ../repeat_sorted/${name}.sorted.bed
done < ../file_names.txt
