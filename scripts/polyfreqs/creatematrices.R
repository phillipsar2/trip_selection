## generating matrices for total and reference read counts 

# load required packages
#install.packages("tidyr")
library("dplyr", lib.loc = "/home/julespor/R_Packages/R3.6.3")
library("tidyr", lib.loc = "/home/julespor/R_Packages/R3.6.3")
library("splitstackshape", lib.loc = "/home/julespor/R_Packages/R3.6.3")
library("data.table", lib.loc = "/home/julespor/R_Packages/R3.6.3")

# load allele depth table 
#TEST:data <- read.csv("data/reports/variantstotable/AD.100snp.test.table", header = T, sep = "\t")
data <- fread("data/reports/variantstotable/ALL.DP1_12.AD.cut.table", header = T, sep = "\t")
samples = 47

#split AD column by comma
colnum <- seq(1,samples)  
adcol <- data[colnum]
colnam <- colnames(adcol)
all_read_counts <- cSplit(data, colnam, sep = ',') %>% data.matrix()

# identify reference and alternative allele count columns in all_read_counts
# seq(from, to, by)
ref <- seq(1, 2*samples, 2)
alt <- seq(2, 2*samples, 2)

#create matrices 
reference <- subset(all_read_counts, select = ref)
alternative <- subset(all_read_counts, select = alt)

#rename columns and rows
#TEST: colnames(reference) <-  c('12836_1', '12836_10', '12836_16')
colnames(reference) <- c('12836_1', '12836_10', '12836_16', '12836_9', '25558_1', '25558_2', '25558_3', '25558_4', '25558_5', '25560_1', '25560_2', '25560_3', '25560_4', '25560_5', '25560_6', '25560_9', '25612_3', '25612_4', '25612_8', '25614_1', '25614_11', '25614_13', '25614_2', '25614_4', '25614_5', '25614_6', '25614_7', '25615_2', '25615_3', '25615_4', '25615_6', '25615_8', '25615_9', '25618_10', '25618_11', '25618_4', '25618_5', '25618_6', '25618_7',  '25618_9', '25625_10', '25625_11', '25636_1', '25636_2', '25636_3', '25636_4',  '25636_5')
#TEST: colnames(alternative)<-  c('12836_1', '12836_10', '12836_16')
colnames(alternative) <- c('12836_1', '12836_10', '12836_16', '12836_9', '25558_1', '25558_2', '25558_3', '25558_4', '25558_5', '25560_1', '25560_2', '25560_3', '25560_4', '25560_5', '25560_6', '25560_9', '25612_3', '25612_4', '25612_8', '25614_1', '25614_11', '25614_13', '25614_2', '25614_4', '25614_5', '25614_6', '25614_7', '25615_2', '25615_3', '25615_4', '25615_6', '25615_8', '25615_9', '25618_10', '25618_11', '25618_4', '25618_5', '25618_6', '25618_7',  '25618_9', '25625_10', '25625_11', '25636_1', '25636_2', '25636_3', '25636_4',  '25636_5')


suffix <- seq(1, nrow(reference))
prefix <- "loc"
loci_names <- paste(prefix, suffix, sep="")
rownames(reference) <- loci_names
rownames(alternative) <- loci_names

#rotate matrices
reference_reads <- t(reference)
alternative_reads <- t(alternative)

#make total read matrix 
total_reads <- reference_reads + alternative_reads

#write output table 
write.table(reference_reads, "data/polyfreqs/ref_read.txt", append = F, sep = "\t")
write.table(total_reads, "data/polyfreqs/tot_read.txt", append = F, sep = "\t")
