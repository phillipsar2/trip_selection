### Kinship matrix function for complete data
### Written By: Julianna Porter 

#### = added on Feb 8, 2023
# load required packages
library("dplyr", lib.loc = "~/R_Packages/R3.6.3")
library("data.table", lib.loc = "~/R_Packages/R3.6.3")
library("pheatmap", lib.loc = "~/R_Packages/R3.6.3")

# load all SNPs that have no missing data and a MAF of >= 0.05
####data <- read.table("data/af/indaf/ALL.42i.0.05MAF.noNA.alt.af.txt", row.names = 1, header = T)
data <- read.table("data/af/indaf/20k.42i.0.05MAF.noNA.alt.af.txt", row.names = 1, header = T)
colnames(data) <- sub("X", "", colnames(data))

#### remove MAF column b/c it won't be recalculated 
sample <-data[,1:42]

# list of genotypes for which we have GS data 
####hasGS <- c("12836_16", "12836_1", "12836_9", "25558_1", "25558_3", "25558_5", "25560_1", "25560_2", "25560_4", "25560_5", "25560_6", "25560_9", "25612_3", "25612_8", "25614_11", "25615_2", "25615_3", "25615_4", "25625_10", "25625_11", "25636_1", "25636_2", "25636_4", "25636_5")
####subset <- select(data, all_of(hasGS))

# recalculate MAF based on less individuals
####subset$MAF <- rowMeans(subset, na.rm=TRUE)
####subset <- subset[subset$MAF >= 0.05,]

# randomly select 20k SNPs
#####sample <- sample_n(subset, 20000)

# save these snps for future analyses
#####write.table(sample, file = "data/af/indaf/20k.24i.0.05MAF.noNA.alt.af.txt", sep="\t", row.names=T, col.names=T, quote=F)
#### already have these b/c of running in the past

# create table with same 20k snps but all 42 individuals, and save for future analyses
####snps <- row.names(sample)
####allind20k <- data[snps,]
####write.table(allind20k, file = "data/af/indaf/20k.42i.0.05MAF.noNA.alt.af.txt", sep="\t", row.names=T, col.names=T, quote=F)

# Create a kinship matrix using eqn 4.9 from Caballero (pg 74) -- Written by Jeffrey Ross-Ibarra
#og_data <- read.table("data/af/ref.20k.noNA.af.txt", header = T, row.names = 1)
#data <- read.table("data/af/indaf/20k.24i.0.05MAF.alt.af.txt", header = T, row.names = 1)
#colnames(data) <- sub("X", "", colnames(data))
### rows = loci
### col = ind

# remove indidivuals for which we don't have GS data
#####og_data <- data[c(1:5, 7:10, 12:15, 17, 19, 26:28, 36:39, 41, 42),]

# convert dataframe to matrix
mat <- as.matrix(sample)

# don't have to because af matrix was transposed when it was made
og_mat<-t(sample) 
#we want row = ind, col = snps

n=nrow(og_mat)

snp_means<-colMeans(og_mat, na.rm=TRUE)

ssq=sum(snp_means*(1-snp_means))
fmij<-function(matrix,ind_i,ind_j,means_vect){
  sum((og_mat[ind_i,]-snp_means)*(og_mat[ind_j,]-snp_means))/ssq
}

kin<-as.matrix(sapply(1:n, function(dude1) 
  sapply(1:n, function(dude2) fmij(og_mat,dude1,dude2,snp_means))))

fin_kin <- 2*kin/mean(diag(kin))

#### setting Diagonal to NA 
diag(fin_kin) <- NA

colnames(fin_kin)=rownames(og_mat)
rownames(fin_kin)=rownames(og_mat)

dim(og_mat)
rownames(og_mat)
dim(fin_kin)
rownames(fin_kin)

####pdf(file = "data/kinship/kinship.24.0.05MAF.heatmap.pdf", 
pdf(file = "data/kinship/kinship.42.0.05MAF.heatmap.pdf",
    width = 8,
    height = 8)

heatmap(fin_kin, na.rm = TRUE)
pheatmap(fin_kin, fontsize = 8)

dev.off()

####write.table(fin_kin, file = "data/kinship/kinship.20k.24i.0.05MAF.txt", sep = "\t", quote = F, row.names = T, col.names = T)
write.table(fin_kin, file = "data/kinship/kinship.20k.42i.0.05MAF.txt", sep = "\t", quote = F, row.names = T, col.names = T)
