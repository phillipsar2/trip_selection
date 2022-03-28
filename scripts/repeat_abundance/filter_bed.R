# Criteria for filtering:
#### Most repeats:
######## Keep hits whose alignment lengths are at least 80% of the query length AND 
######## have an E value of at most .01
#### Some repeats gave 0 entries when filtered with this criteria, so their critera has been adjusted:
#### For Mitochondria and Chloroplast:
######## Keep hits that have an alignment length that is at least 10 kb (same cut-off for E value)
#### For B repeat:
######## Keep hits that have an alignment length that is at least 100 bp (same cut-off for E value

# load unfilterted files
#### when analyses were initially run, the first line of the bed files were removed and replaced with a header to make
#### filtering easier. The header was then removed for use with bedtools so if you want to do that or avoid the header 
#### entirely it's up to you! 
#### this was the header that was inserted (tab deliminated): chrom	start	stop	alignment_length	subject_length	query_length	q_start	q_end	e_value	strand
n180knob <- read.csv('data/repeat_abundance/repeat/bed_files/180knob.unfiltered.bed', header=F, sep="\t")
n17SrRNA <- read.csv('data/repeat_abundance/repeat/bed_files/17SrRNA.unfiltered.bed', header=F, sep="\t")
n25SrRNA <- read.csv('data/repeat_abundance/repeat/bed_files/25SrRNA.unfiltered.bed', header=F, sep="\t")
n5.8SrRNA <- read.csv('data/repeat_abundance/repeat/bed_files/5.8SrRNA.unfiltered.bed', header=F, sep="\t")
centromere <- read.csv('data/repeat_abundance/repeat/bed_files/centromere.unfiltered.bed', header=F, sep="\t")
TR1 <- read.csv('data/repeat_abundance/repeat/bed_files/maizeTR1.unfiltered.bed', header=F, sep="\t")
telomere <- read.csv('data/repeat_abundance/repeat/bed_files/telomere.unfiltered.bed', header=F, sep="\t")
mitochondria <- read.csv('data/repeat_abundance/repeat/bed_files/mitochondria.unfiltered.bed', header=F, sep="\t")
chloroplast <- read.csv('data/repeat_abundance/repeat/bed_files/chloroplast.unfiltered.bed', header=F, sep="\t")
brepeat <- read.csv('data/repeat_abundance/repeat/bed_files/brepeat.unfiltered.bed', header=F, sep="\t")

# look at data and ensure that alignment _length and e_value column are numeric/integer 
# convert columns to numeric as needed
str(n180knob)
str(n17SrRNA)
str(n25SrRNA)
str(n5.8SrRNA)
str(centromere)
str(TR1)
str(telomere)
str(mitochondria)
str(chloroplast)
str(brepeat)

# query length (80% of query length will be used to filter): 
#### 180knob: 180 
#### 17S: 2215
#### 25S: 970
#### 5.8S: 597
#### centromere: 156
#### maizeTR1: 358
#### telomere:140 (20 copies of 7 bp repeat)

# filter data using subset()
sub.180knob <- subset(n180knob, e_value <= .01 & alignment_length >= .8*180, select=chrom:strand)
sub.17S <- subset(n17SrRNA, e_value <= .01 & alignment_length >= .8*2215, select=chrom:strand)
sub.25S <- subset(n25SrRNA, e_value <= .01 & alignment_length >= .8*970, select=chrom:strand)
sub.5.8S <- subset(n5.8SrRNA, e_value <= .01 & alignment_length >= .8*597, select=chrom:strand)
sub.centromere <- subset(centromere, e_value <= .01 & alignment_length >= .8*156, select=chrom:strand)
sub.TR1 <- subset(TR1, e_value <= .01 & alignment_length >= .8*358, select=chrom:strand)
sub.telomere <- subset(telomere, e_value <= .01 & alignment_length >= .8*140, select=chrom:strand)

sub.mitochondria <- subset(mitochondria, e_value <= .01 & alignment_length >= 10000, select=chrom:strand)
sub.chloroplast <- subset(chloroplast, e_value <= .01 & alignment_length >= 10000, select=chrom:strand) 

sub.b <- subset(brepeat.excl, e_value <= .01 & alignment_length >= 100, select=chrom:strand)

# create tab delimited .bed files from filtered data 
write.table(sub.180knob, file="data/repeat_abundance/bed_files/repeat/180knob.filtered.bed", append = FALSE, sep = "\t", row.names = FALSE, col.names = TRUE, quote = FALSE)
write.table(sub.17S, file="data/repeat_abundance/bed_files/repeat/17SrRNA.filtered.bed", append = FALSE, sep = "\t", row.names = FALSE, col.names = TRUE, quote = FALSE)
write.table(sub.25S, file="data/repeat_abundance/bed_files/repeat/25SrRNA.filtered.bed", append = FALSE, sep = "\t", row.names = FALSE, col.names = TRUE, quote = FALSE)
write.table(sub.5.8S, file="data/repeat_abundance/bed_files/repeat/5.8SrRNA.filtered.bed", append = FALSE, sep = "\t", row.names = FALSE, col.names = TRUE, quote = FALSE)
write.table(sub.centromere, file="data/repeat_abundance/bed_files/repeat/centromere.filtered.bed", append = FALSE, sep = "\t", row.names = FALSE, col.names = TRUE, quote = FALSE)
write.table(sub.TR1, file="data/repeat_abundance/bed_files/repeat/TR1.filtered.bed", append = FALSE, sep = "\t", row.names = FALSE, col.names = TRUE, quote = FALSE)
write.table(sub.telomere, file="data/repeat_abundance/bed_files/repeat/telomere.filtered.bed", append = FALSE, sep = "\t", row.names = FALSE, col.names = TRUE, quote = FALSE)
write.table(sub.b, file="data/repeat_abundance/bed_files/repeat/brepeat.filtered.bed", append = FALSE, sep = "\t", row.names = FALSE, col.names = TRUE, quote = FALSE)
write.table(sub.mitochondria, file="data/repeat_abundance/bed_files/repeat/mitochondria.filtered.bed", append = FALSE, sep = "\t", row.names = FALSE, col.names = TRUE, quote = FALSE)
write.table(sub.chloroplast, file="data/repeat_abundance/bed_files/repeat/chloroplast.filtered.bed", append = FALSE, sep = "\t", row.names = FALSE, col.names = TRUE, quote = FALSE)
