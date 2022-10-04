# step 0: load required packages
library("dplyr", lib.loc = "~/R_Packages/R3.6.3")

# step 1: load data
alt_af <- read.table("data/af/indaf/alt_af.ALL.txt", row.names = 1, header = T)
colnames(alt_af) <- sub("X", "", colnames(alt_af))

## list of genotypes we have GS data for: used for kinship matrix but not for PCA
hasGS <- c("12836_16", "12836_1", "12836_9", "25558_1", "25558_3", "25558_5", "25560_1", "25560_2", "25560_4", "25560_5", "25560_6", "25560_9", "25612_3", "25612_8", "25614_11", "25615_2", "25615_3", "25615_4", "25625_10", "25625_11", "25636_1", "25636_2", "25636_4", "25636_5")

# step 2: calculate minor allele frequency (MAF)
alt_af$MAF <- rowMeans(alt_af, na.rm = TRUE)

# step 3: remove SNPs(rows) with MAF < 0.05
MAF <- alt_af[alt_af$MAF >= 0.05,]

# step 4: create table with only 24 indidivudals that have GS data (for kinship matrix)
MAF24 <- select(MAF, all_of(hasGS))

# step 5: recalculate MAF for only 24 indidivuals, and confirm same cutoff
MAF24$MAF <- rowMeans(MAF24, na.rm = TRUE)
MAF24 <- MAF24[MAF24$MAF >= 0.05,]

print("dimensions before filtering 24 indidividuals")
dim(MAF)
print("dimensions after filtering 24 indidividuals")
dim(MAF24)

# step 6: select 20k snps for use in kinship matrix (select from df with 24 individuals) 
n20k24i <- sample_n(MAF24, 20000)

# step 7: match the same 20k snps to MAF (select from df with 42 individuals) for use in PCA
snps <- row.names(n20k24i)
n20k42i <- MAF[snps,]

# step 8: remove MAF column and write to .txt files
kin <- n20k24i[,1:24]
pca <- n20k42i[,1:42]

write.table(kin, file="data/af/indaf/20k.24i.0.05MAF.alt.af.txt", sep="\t", row.names=T, col.names=T, quote=F)
write.table(pca, file="data/af/indaf/20k.42i.0.05MAF.alt.af.txt", sep="\t", row.names=T, col.names=T, quote=F)
write.table(MAF, file="data/af/indaf/ALL.42i.0.05MAF.alft.af.txt", sep="\t", row.names=T, col.names=T, quote=F)
