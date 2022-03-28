# this is experimenting code, not important

cd Tripsacum/repeat_filtered/

cat 180knob.filtered.bed | head
bedtools sort -i 180knob.filtered.bed | head

bedtools sort -i 180knob.filtered.bed > ../repeat_sorted/180knob.sorted.bed
cat ../repeat_sorted/180knob.sorted.bed | head

cd ../repeat_sorted
# 1st
bedtools intersect -wa -wb \
    -a repeat_sorted/17SrRNA.sorted.bed \
    -b repeat_sorted/180knob.sorted.bed \
    -sorted > repeat_intersect/example.bed

bedtools intersect -wa -wb \
    -a repeat_sorted/17SrRNA.sorted.bed \
    -b repeat_sorted/180knob.sorted.bed \
    -sorted \
    -v > repeat_intersect/example.bed

# [1] "17SrRNA"      "180knob"      "25SrRNA"      "5.8SrRNA"     "brepeat"     
# [6] "centromere"   "chloroplast"  "maizeTR1"     "mitochondria" "telomere" 

bedtools intersect -wa -wb \
    -a repeat_sorted/180knob.sorted.bed \
    -b repeat_sorted/17SrRNA.sorted.bed repeat_sorted/telomere.sorted.bed \
    repeat_sorted/25SrRNA.sorted.bed repeat_sorted/5.8SrRNA.sorted.bed \
    repeat_sorted/brepeat.sorted.bed repeat_sorted/centromere.sorted.bed \
    repeat_sorted/chloroplast.sorted.bed repeat_sorted/maizeTR1.sorted.bed \
    repeat_sorted/mitochondria.sorted.bed \
    -sorted \
    -v > repeat_intersect/example1.bed

bedtools overlapp 
bedtools merge 

# check the intersected regions first 
# then check the ones not overlapping 

# then merge 

cat repeat_sorted/17SrRNA.sorted.bed > repeat_intersect/intersect.bed

bedtools intersect -wa -wb 

# record how much were lost every step 
# extract the depth at sites 
# bedtools coverage  
# bedfiles bam 
# where bam files are 

# intro of the bio
# my process 
# paul's study 

cd repeat_intersect
for file in `ls`; do
    wc $file -l
done