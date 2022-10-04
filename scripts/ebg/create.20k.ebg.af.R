### Generating EBG input AND Allele freq matrix for 20k SNPs that have NO NAs
### Written By: Julianna Porter

# load required packages
library("vcfR", lib.loc = "~/R_Packages/R3.6.3")
library("memuse", lib.loc = "~/R_Packages/R3.6.3")
library("tidyr", lib.loc = "~/R_Packages/R3.6.3")
library("dplyr", lib.loc = "~/R_Packages/R3.6.3")
library(stats)

# load filtered, unzipped vcf
vcf <- read.vcfR(file = "data/vcf/final/ALL.DP1_8.rename.vcf.gz")

# extract allele depth
ad <- extract.gt(vcf, element = 'AD', as.numeric = F)

# separate reference and alternative columns = ref and alt allele count matrix 
# row = snps
# col = ind
ref <- masplit(ad, delim = ",", sort = 0, record = 1)
alt <- masplit(ad, delim = ",", sort = 0, record = 2)

# create a total allele count matrix 
tot <- ref + alt 

# remove any loci that contain missing data (total allele count = 0)
ref[tot == 0] <- NA
alt[tot == 0] <- NA
tot[tot == 0] <- NA

noNAref <- ref[complete.cases(ref),]
noNAalt <- alt[complete.cases(alt),]
noNAtot <- tot[complete.cases(tot),]

# confirm removal
dim(ref)
dim(noNAref)
sum(is.na(ref))
sum(is.na(noNAref))

# select 20k random snps that have no missing data 
s <- sample(nrow(noNAref), size = 20000, replace = FALSE)
ref20k <- noNAref[s,]

sample_SNPs <- rownames(ref20k)

alt20k <- noNAalt[which(rownames(noNAalt) %in% sample_SNPs),]
tot20k <- noNAtot[which(rownames(noNAtot) %in% sample_SNPs),]

# order 20k selected SNPs
ord_alt20k <- alt20k[order(row.names(alt20k)),]
ord_ref20k <- ref20k[order(row.names(ref20k)),]
ord_tot20k <- tot20k[order(row.names(tot20k)),]

###### CREATE INDIVIDUAL ALLELE FREQUNECY MATRIX
alt_af <- ord_alt20k/ord_tot20k
ref_af <- ord_ref20k/ord_tot20k

# tranpose so that rows = ind and col = SNP (required for kinship matrix)
fin_ref_af <- t(ref_af)
fin_alt_af <- t(alt_af)

# write af matrices to file
write.table(fin_ref_af, file = "data/af/ref.20k.noNA.af.txt", quote = F, sep = "\t", row.names = T, col.names = T)
write.table(fin_alt_af, file = "data/af/alt.20k.noNA.af.txt", quote = F, sep = "\t", row.names = T, col.names = T)


##### CREATE EBG INPUT
###       1. total read count matrix (columns = loci, rows = indiv)
###       2. alternative read count matrix (columns = loci, rows = indiv)
###       3. vector of per locus error rate ( column = 1, rows = .01)
###       additional files = loci names and sample names (not in final matrix) 

# transpose so that row = ind and col = loci
t_alt <- t(ord_alt20k)
t_ref <- t(ord_ref20k)
t_tot <- t(ord_tot20k)

# can skip the step to replace missing data with -9, as there is no missing data

# create a vector for the per locus error (matrix with one column and one row per SNP)
dim <- dim(ord_alt20k)[1]
val <- .01
err <- matrix(data = val, nrow = dim, ncol = 1)

# write SNP names and ind names to files for reference 
loci <- colnames(t_alt)
samples <- rownames(t_alt)

# write objects to txt files
write.table(t_alt, file = "data/ebg/input/20k.noNA.alt.txt", sep = "\t", row.names = F, col.names = F)
write.table(t_tot, file = "data/ebg/input/20k.noNA.tot.txt", sep = "\t", row.names = F, col.names = F)
write.table(err, file = "data/ebg/input/20k.noNA.err.txt", sep = "\t", row.names = F, col.names = F)
write.table(samples, file = "data/ebg/input/20k.noNA.sample_names.txt", sep = "\t", row.names = F, col.names = F, quote = F)
write.table(loci, file = "data/ebg/input/20k.noNA.loci_positions.txt", sep = "\t", row.names = F, col.names = F, quote = F)


