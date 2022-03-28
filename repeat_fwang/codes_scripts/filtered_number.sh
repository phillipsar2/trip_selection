cd Tripsacum

while read name
do 
    echo `echo ${name} 
        wc -l repeat/${name}.unfiltered.bed \
        repeat_filtered/${name}.filtered.bed \
        repeat_sorted/${name}.sorted.bed \
        repeat_intersect/${name}.intersect.bed \
        repeat_nonoverlap/${name}.nonoverlap.bed \
        repeat_merge/${name}.merged.bed` 
done < file_names.txt > steps.txt

wc -l steps.txt
cut -d " " -f1,2,4,6,8,10,12 steps.txt > steps_1.txt

sed -i '1 i file_name orginal_lines filtered sorted intersected non_overlapping merged' steps_1.txt

echo file_name orginal_lines 