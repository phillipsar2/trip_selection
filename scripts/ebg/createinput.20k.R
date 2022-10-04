### Generating input files for software ebg 
### Input files made:
###       1. total read count matrix (columns = loci, rows = indiv)
###       2. alternative read count matrix (columns = loci, rows = indiv)
###       3. vector of per locus error rate ( column = 1, rows = .01)

# load required packages 
library("vcfR", lib.loc = "~/R_Packages/R3.6.3")
library("memuse", lib.loc = "~/R_Packages/R3.6.3")
library("tidyr", lib.loc = "~/R_Packages/R3.6.3")

# load filtered, unzipped VCF
vcf <- read.vcfR(file = "data/vcf/final/20k.DP1_8.filtered.vcf.gz")

# extract allele depth
ad <- extract.gt(vcf, element = 'AD', as.numeric = F)

# separate reference and alternative columns
ref <- masplit(ad, delim = ",", sort = 0, record = 1)
alt <- masplit(ad, delim = ",", sort = 0, record = 2)

# rearrange matrices so that indiv = rows and loci = columns 
t_ref <- t(ref)
t_alt <- t(alt)

# create a total read count matrix via matrix addition
tot <- t_ref + t_alt

# set missing data to -9 
t_alt[tot == 0] <- NA
tot[tot == 0] <- NA

fin_tot <- replace_na(tot, -9)
fin_alt <- replace_na(t_alt, -9)

# create a vector for the per locus error (matrix with one column and a row per snp)
dim <- dim(alt)[1]
val <- .01
err <- matrix(data = val, nrow = dim, ncol = 1)

# file of individual names to reference for order of results
sample_name <- colnames(alt)
loci_position <- rownames(alt)

# write objects to txt files
write.table(fin_alt, file = "data/ebg/input/20k.alt.txt", sep = "\t", row.names = F, col.names = F)
write.table(fin_tot, file = "data/ebg/input/20k.tot.txt", sep = "\t", row.names = F, col.names = F)
write.table(err, file = "data/ebg/input/20k.err.txt", sep = "\t", row.names = F, col.names = F)
write.table(sample_name, file = "data/ebg/input/20k.sample_names.txt", sep = "\t", row.names = F, col.names = F, quote = F)
write.table(loci_position, file = "data/ebg/input/20k.loci_positions.txt", sep = "\t", row.names = F, col.names = F, quote = F)
