# load necessary libraries 
library("data.table", lib.loc = "/home/julespor/R_Packages/R3.6.3")

# append tables laterally 
alt1 <- fread("data/polyfreqs/alternative_reads.scaf100_102.txt", header = F, sep = "\t") 
alt2 <- fread("data/polyfreqs/alternative_reads.scaf103_105.txt", header = F, sep = "\t")

merge_alt <- cbind(alt1, alt2)
dim(alt1)
dim(alt2)
dim(merge_alt)

write.table(merge_alt, "data/polyfreqs/merged_alternative_reads.100_105.table", append = FALSE, sep = "\t", quote = FALSE)

tot1 <- fread("data/polyfreqs/total_reads.scaf100_102.txt", header = F, sep = "\t")
tot2 <- fread("data/polyfreqs/total_reads.scaf103_105.txt", header = F, sep = "\t")

merge_tot <- cbind(tot1,tot2)
dim(merge_tot)

write.table(merge_tot, "data/polyfreqs/merged_total_reads.100_105.table", append = FALSE, sep = "\t", quote = FALSE)
