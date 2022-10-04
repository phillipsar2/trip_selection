#!/bin/bash
#SBATCH -D /home/wang9418/Tripsacum/repeat_sorted/
#SBATCH --partition=med
#SBATCH --job-name=wang9418_intersect_job
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --mem=1G
#SBATCH --time=24:00:00
#SBATCH --output=../outfile_intersect.out
#SBATCH --error=../outfile_intersect.err

source ~/.bashrc
conda activate rotate3



while read name
do
    echo ${name}
    echo `bash ../loop_file.sh /home/wang9418/Tripsacum/repeat_sorted/ ${name}` > ../temp.txt
    bedtools intersect -wa -wb \
        -a ${name}.sorted.bed \
        -b `cat ../temp.txt` \
        -sorted -filenames > ../repeat_intersect/${name}.intersect.bed
done < ../file_names.txt



# setting up
# while read name
# do
#     echo ${name}
#     echo `bash ../loop_file.sh /home/wang9418/Tripsacum/repeat_sorted/ ${name}` > ../temp.txt
# done < ../file_names.txt