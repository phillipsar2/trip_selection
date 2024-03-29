### Removing SNPs with missing data from allele frequency matrix
### Written by: Julianna Porter

# load required packages
library("dplyr", lib.loc = "~/R_Packages/R3.6.3")
library("data.table", lib.loc = "~/R_Packages/R3.6.3")

# load data (indiv = columns, rows = loci)
#ref_af <- read.table("data/af/ref_af.ALL.txt", row.names = 1)
alt_af <- read.table("data/af/indaf/ALL.42i.0.05MAF.alft.af.txt", row.names = 1)
colnames(alt_af) <- sub("X", "", colnames(alt_af))

# remove loci that contain NA and save as new matrix 
#noNAref <- ref_af[ rowSums(is.na(ref_af)) == 0, ]
noNAalt <- alt_af[ rowSums(is.na(alt_af)) == 0, ]
#write.table(noNAref, file = "data/af/ref_af.noNA.txt", sep = "\t", row.names = T, col.names = T, quote = F)
write.table(noNAalt, file = "data/af/indaf/ALL.42i.0.05MAF.noNA.alt.af.txt", sep = "\t", row.names = T, col.names = T, quote = F)

# names of loci with NO missing data
#snps <- rownames(noNAref) 
#writeLines(snps, "data/af/SNPnames.noNA.txt") 

# determine number of sites removed
stat <- data.frame(X1=c("Number of SNPs before NAs were removed", "Number of SNPs that have no NAs"), X2=c(nrow(alt_af), nrow(noNAalt)))
write.table(stat, "data/af/indaf/SNPcount.0.05MAF.txt", quote = FALSE, sep = "\t")
