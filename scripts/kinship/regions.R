### Create regions file (tab deliminated file with CHROM and POS col) that can be used to subset vcf to contain no missing data
### Writen by: Julianna Porter

# load required packages
library("tidyr", lib.loc = "~/R_Packages/R3.6.3")
library("stringr", lib.loc = "~/R_Packages/R3.6.3")

# load names of loci with no missing data, and that have been separated to remove loci too close together (not independent)
snps <- read.table("data/af/SNPnames.noNA.txt", header = F)

# separate by _ creating three columns
regions <- separate(snps, V1, c("SCAF", "CHROM", "POS"), sep = "_")

# recombine SCAF and CHROM columns
regions$CHROM <- str_c(regions$SCAF, sep = "_", regions$CHROM)

# remove SCAF column
final_names <- subset(regions, select = -SCAF)

# write names to regions file
write.table(final_names, file = "data/af/regions.noNA.ALL.txt", sep = "\t", col.names = T, row.names = F, quote = F)
