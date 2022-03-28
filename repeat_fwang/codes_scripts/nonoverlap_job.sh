#!/bin/bash
#SBATCH -D /home/wang9418/Tripsacum/repeat_sorted/
#SBATCH --partition=med
#SBATCH --job-name=wang9418_nonoverlap_job
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --mem=1G
#SBATCH --time=24:00:00
#SBATCH --output=../outfile_nonoverlap.out
#SBATCH --error=../outfile_nonoverlap.err

source ~/.bashrc
conda activate rotate3



while read name
do
    echo ${name}
    echo `bash ../loop_file.sh /home/wang9418/Tripsacum/repeat_sorted/ ${name}`
    echo `bash ../loop_file.sh /home/wang9418/Tripsacum/repeat_sorted/ ${name}` > ../temp_nonoverlap.txt
    bedtools intersect -wa -wb \
        -a ${name}.sorted.bed \
        -b `cat ../temp_nonoverlap.txt` \
        -sorted -v > ../repeat_nonoverlap/${name}.nonoverlap.bed
done < ../file_names.txt

