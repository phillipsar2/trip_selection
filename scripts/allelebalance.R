### Calculating alllele balance using GT and DP vcf annotations
### Thank you to Alyssa Philips for help and code: https://github.com/phillipsar2/poa_genome/blob/master/scripts/allelebalance_filter.R 

# load required packages
library("dplyr", lib.loc = "/home/julespor/R_Packages/R3.6.3")
library("tidyr", lib.loc = "/home/julespor/R_Packages/R3.6.3")
library("splitstackshape", lib.loc = "/home/julespor/R_Packages/R3.6.3")
library("data.table", lib.loc = "/home/julespor/R_Packages/R3.6.3")
library("raster", lib.loc = "/home/julespor/R_Packages/R3.6.3")

# load allele depth table 
data <- fread("data/reports/variantstotable/AD.100000snp.cut.table", header = T, sep = "\t")
dim(data)
samples = 47

#split AD column by comma
colnum <- seq(1,samples)
adcol <- data[colnum]
colnam <- colnames(adcol)
all_read_counts <- cSplit(data, colnam, sep = ',') #%>% data.matrix()
dim(all_read_counts)

# identify reference and alternative allele count columns in all_read_counts
# seq(from, to, by)
ref <- seq(1, 2*samples, 2)
alt <- seq(2, 2*samples, 2)

#create matrices 
reference <- subset(all_read_counts, select = ref)
alternative <- subset(all_read_counts, select = alt)

#sum across loci
altsum <- rowSums(alternative)
alternative_sum <- as.matrix(altsum)
refsum <- rowSums(reference)
reference_sum <- as.matrix(refsum)

#make total read matrix 
total_sum <- reference_sum + alternative_sum

#make AB table 
AB <- alternative_sum / total_sum
colnames(AB) <- "AB"

#write AB table 
write.table(AB, "data/reports/allelebalance/AB.100000snp.txt", append = F, sep = "\t")

#graphing AB
#hist(AB)

#den <- density(AB)
#plot(den)

