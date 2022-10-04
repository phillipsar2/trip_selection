### Kinship matrix function for complete data
### Written By: Julianna Porter 

# load required packages
library("dplyr", lib.loc = "~/R_Packages/R3.6.3")
library("data.table", lib.loc = "~/R_Packages/R3.6.3")
library("pheatmap", lib.loc = "~/R_Packages/R3.6.3")

# Create a kinship matrix using eqn 4.9 from Caballero (pg 74) -- Written by Jeffrey Ross-Ibarra

#og_data <- read.table("data/af/ref.20k.noNA.af.txt", header = T, row.names = 1)
data <- read.table("data/af/ref.20k.noNA.af.txt", header = T, row.names = 1)
#og_data <- t(data)
### rows = ind
### col = loci

# remove indidivuals for which we don't have GS data
og_data <- data[c(1:5, 7:10, 12:15, 17, 19, 26:28, 36:39, 41, 42),]

# convert dataframe to matrix
og_mat <- as.matrix(og_data)

# don't have to because af matrix was transposed when it was made
#og_t<-t(og_mat) 
#we want row = ind, col = snps

n=nrow(og_mat)

snp_means<-colMeans(og_mat)

ssq=sum(snp_means*(1-snp_means))
fmij<-function(matrix,ind_i,ind_j,means_vect){
  sum((og_mat[ind_i,]-snp_means)*(og_mat[ind_j,]-snp_means))/ssq
}

kin<-as.matrix(sapply(1:n, function(dude1) 
  sapply(1:n, function(dude2) fmij(og_mat,dude1,dude2,snp_means))))

fin_kin <- 2*kin/mean(diag(kin))

colnames(fin_kin)=rownames(og_mat)
rownames(fin_kin)=rownames(og_mat)

dim(og_mat)
rownames(og_mat)
dim(fin_kin)
rownames(fin_kin)

pdf(file = "data/kinship/kinship.24.heatmap.pdf", 
    width = 8,
    height = 8)

heatmap(fin_kin)
#pheatmap(fin_kin, fontsize = 8)

dev.off()

write.table(fin_kin, file = "data/kinship/kinship.24.20k.noNA.txt", sep = "\t", quote = F, row.names = T, col.names = T)

