# running a PCA on allele frequencies for 20k loci 
# Written by: Mitra Menon
# Modified by: Julianna Porter

# load data - allele freq for 20k snps, col = snps, row = indiv
data <- read.table("ref.20k.noNA.af.txt", header = T, row.names = 1)
Indestimates <- t(data) # we want the colum means per indiv, not snp

# format data 
colM<-colMeans(Indestimates,na.rm=TRUE)
Nr=Indestimates-colM
Dn=sqrt(colM*(1-colM))
normalised=Nr/Dn

normalised[is.na(normalised)]<-0
normalised[is.nan(normalised)]<-0

#check NaNs in normalised

#some filtering to keep snps that are variable for pcs
keep=colSums(normalised)
keep=names(keep[keep>0])
normalised<-normalised[ ,colnames(normalised)%in%keep]
keep2=colVars(normalised)
keep2=names(keep2[keep2>0])
normalised<-normalised[ ,colnames(normalised)%in%keep2]

#run pc
method1<-prcomp(normalised,scale. = FALSE,center = FALSE)

