### Calculating Individual Allele Frequency at each locus for each indiviual using allele counts 

# load required packages 
library("vcfR", lib.loc = "~/R_Packages/R3.6.3")
library("memuse", lib.loc = "~/R_Packages/R3.6.3")
library("tidyr", lib.loc = "~/R_Packages/R3.6.3")

# load filtered, unzipped VCF
vcf <- read.vcfR(file = "data/vcf/final/ALL.DP1_8.rename.vcf.gz")
#meta <- read.table("data/entropy/metadata.txt")

# extract allele depth
ad <- extract.gt(vcf, element = 'AD', as.numeric = F)

# shorten individual names (will do once I see original results)
#colnames(ad) <- meta$V1

# separate reference and alternative columns
ref <- masplit(ad, delim = ",", sort = 0, record = 1)
alt <- masplit(ad, delim = ",", sort = 0, record = 2)

# create a total read count matrix via matrix addition
tot <- ref + alt

# create allele freq matrix
alt_af <- alt/tot
ref_af <- ref/tot

# write objects to txt files
write.table(alt_af, file = "data/af/alt_af.ALL.txt", sep = "\t", row.names = T, col.names = T, quote = F)
write.table(ref_af, file = "data/af/ref_af.ALL.txt", sep = "\t", row.names = T, col.names = T, quote = F)

