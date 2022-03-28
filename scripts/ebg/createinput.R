### Generating input files for software ebg 
### Input files made:
###       1. total read count matrix (columns = loci, rows = indiv)
###       2. alternative read count matrix (columns = loci, rows = indiv)
###       3. vector of per locus error rate ( column = 1, rows = .01)

# load required packages 
library("vcfR", lib.loc = "~/R_Packages/R3.6.3")
library("memuse", lib.loc = "~/R_Packages/R3.6.3")

# load filtered, unzipped VCF
vcf <- read.vcfR(file = "data/vcf/max_no_call/DP1_8/scaf_1.maxnocall.DP1_8.filtered.snps.vcf")

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

# create a vector for the per locus error (matrix with one column and a row per snp)
dim <- dim(alt)[1]
val <- .01
err <- matrix(data = val, nrow = dim, ncol = 1)

# file of individual names to reference for order of results
sample_name <- colnames(alt)

# write objects to txt files
write.table(tot, file = "data/ebg/scaf_1.tot_reads.txt", sep = "\t", row.names = F, col.names = F)
write.table(t_alt, file = "data/ebg/scaf_1.alt_reads.txt", sep = "\t", row.names = F, col.names = F)
write.table(err, file = "data/ebg/scaf_1.err.txt", sep = "\t", row.names = F, col.names = F)
write.table(sample_name, file = "data/ebg/scaf_1.sample_order.txt", sep = "\t", row.names = F, col.names = F)
