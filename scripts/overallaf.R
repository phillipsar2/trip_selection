### Calculating Overall allele frequencies per site assuming ONE population to use in Fst calculation ----
### Written by: Mitra Menon
### Modified by: Julianna Porter
### 09/22/2022

# step 0: load required packages
library("vcfR", lib.loc = "~/R_Packages/R3.6.3")
library(parallel)
library("stringr", lib.loc = "~/R_Packages/R3.6.3")
library("data.table", lib.loc = "~/R_Packages/R3.6.3")

# step 1: load data
setwd("/group/jrigrp10/tripsacum_dact/")
#getwd()

# 1.1: EBG PL output
#pl_file=list.files(path = "data/ebg/output/", pattern = "-diseq-PL.txt", full.names = T)
pl_file=("data/ebg/output/scaf_1-diseq-PL.txt")
ebgpl <- readLines(pl_file[[1]]) %>% str_split(pattern = "\t", simplify = TRUE)
print("pl is loaded")

# 1.2: SNP names for EBG output
#snps=list.files(path = "data/ebg/input/", pattern = "loci_positions.txt", full.names = T)
snps=("data/ebg/input/scaf_1.loci_positions.txt")
pos=read.table(snps[[1]])$V1

# 1.3: Individual names
mysamples=read.table("data/ebg/input/sample_names.txt")
samples=mysamples$V1

# step 2: write pop allele frequency function 
overall_af<-function(ebgPL,sampleIDs,SNP_names){

  ############This function takes 2inputs,
  #ebgPL= PL outputed from EBG (got it)
  #Group=dataframe with `Ind` IDs as the colnames of ebgPL and a column called `pop` (change to subspecies) containing pop designation (metadata)
  #sampleIDs = vector of Ind names that are in the same order as in your vcf or the input used for ebg (sample_names.txt)

  pl<-apply(ebgPL, c(1,2), function(x){as.numeric(unlist(strsplit(x,split=",")))}) #takes the three GLs and$

  gc()
  step1=apply(pl,c(1,2),function(x) unlist(x)/-10)
  a.GP=apply(step1,c(1,2),function(x) 10^unlist(x)/sum(10^unlist(x)))  #converts Phred-scale likelihood to $

  # for each cell only keep het and homo-non-ref -- drops homo-ref (only need 2/3 values when they all sum $
  p12=apply(a.GP, c(1,2),function(x) unlist(x)[2:5])
  dimnames(p12)[[3]]=sampleIDs
  dimnames(p12)[[2]]=SNP_names

  g12sum=rowSums(p12, dims = 2,na.rm = TRUE) #will return 2D array. first part is state (hets then homo), s$

  Nadj=4*rowSums(!is.na(p12[1, ,]))

  af=(g12sum[1,]+2*g12sum[2,]+3*g12sum[3,]+4*g12sum[4, ])/Nadj #assuming tetraploid


  return(af) #estimates p, allele freq using HWE for a tetraploid
}

# step 3: run function
results <- overall_af(ebgpl, samples, pos)
AF <- as.data.frame(results)
write.table(AF, file="data/af/popaf/scaf_1.overall.af.txt",sep="\t",row.names=T,quote=F)
