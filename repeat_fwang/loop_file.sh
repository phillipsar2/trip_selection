#!/bin/bash
# how to use this script
# bash ./loop_file.sh /absolute/path/of/the/sorted/files/ name_of_file_you_dont_want_in_loop (no .bed extension)
# bash ./loop_file.sh /home/wang9418/Tripsacum/repeat_sorted/ name_of_file_you_dont_want_in_loop

sorted_directory=$1
input_file=$2

for file in `ls $sorted_directory`; do 
    if [[ $file != ${input_file}.sorted.bed ]]; then
        echo $file
    fi
done


# trying if function
# a=20
# b=20
# if [ $a == $b ]
# then
#     echo "a is equal to b"
# fi