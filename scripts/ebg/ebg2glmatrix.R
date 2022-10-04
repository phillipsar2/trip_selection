### Title: Convert EBG output format to a GL matrix - one ploidy level
### Author: Alyssa Phillips
### Date: 5/10/22

library("stringr", lib.loc = "~/R_Packages/R3.6.3")
library(MASS)
library("dplyr", lib.loc = "~/R_Packages/R3.6.3")
library("argparser", lib.loc = "~/R_Packages/R3.6.3")

# > commandArgs ----
# give the arugment a name
ap <- arg_parser("convert EBG PL file to GL mat - two ploidy levels")

# add mandatory positional arguments (filename)
ap <- add_argument(ap, "pl", help = "PL file output from EBG for first ploidy level")

# additional arguments
ap <- add_argument(ap, "--tot", help = "total read depth file that is the input for EBG")
ap <- add_argument(ap, "--ploidy", help = "ploidy of sample file; single numeric value")
ap <- add_argument(ap, "--geno", help = "list of samples names output from vcf2ADmatrix.R script")
ap <- add_argument(ap, "--snps", help = "list of SNP positions output from vcf2ADmatrix.R script")

# parse arguments
argv <- parse_args(ap)

# load data as argument
pl_file <- as.character(argv$pl)
reads_file <- as.character(argv$tot)
p = as.numeric(argv$ploidy)

### don't know what this does, 
fname <- strsplit(pl_file, "-diseq-PL.txt")[[1]]

# metadata
gfile <- as.character(argv$geno)
genos <- read.csv(gfile, sep = "\t", header = F)
pfile <- as.character(argv$s)
pos <- read.csv(pfile, sep = "\t", header = F)
head(pos)

print("read in metadata")

# >  Read in first PL file line by line and split columns by tab separation ----
pl <- readLines(pl_file) %>% str_split(pattern = "\t", simplify = TRUE) 
pl <- apply(pl, 2, function(x) gsub("^$|^ $", NA, x)) # replace blanks with NA

print("read in pl")

# load EBG input -- the total read counts matrix
read_counts_file <- read.csv(reads_file, sep = "\t", header = F )
read_counts <- t(read_counts_file)

print("read in readcounts")

# > Edit first file ----
# If values in row != -9,  assign PL to those spots in the new array [R, C] = [loci, individuals] 
pl_mat <- matrix(data = NA,
                 nrow = dim(read_counts)[1],
                 ncol = dim(read_counts)[2] ) # make an empty matrix

l = dim(read_counts)[1]
for (i in 1:l){
  pl_mat[i,][which(read_counts[i,]!=-9)] <- as.vector(na.omit(pl[i,]))
}

print("formatted matrix")

# convert to dataframe
pl_mat_dat <- as.data.frame(pl_mat)

# Replace NAs w/ the appropriate amount of zeros 
#pl_mat_dat[is.na(pl_mat_dat)] <- paste(as.character( rep(x = 0, times = p2+1) ), sep="' '", collapse=",")

for(i in 1:ncol(pl_mat_dat)){
  levels(pl_mat_dat[,i]) <- c(levels(pl_mat_dat[,i]), paste(as.character( rep(x = 0, times = p+1) ), sep="' '", collapse=","))
} 
pl_mat_dat[is.na(pl_mat_dat)] <- paste(as.factor( rep(x = 0, times = p+1) ), sep="' '", collapse=",")

sum(is.na(pl_mat_dat))
print("replaced NAs w/ zeros")

# > Add genotype information ----
colnames(pl_mat_dat) <- unlist(genos$V1)

# > Add SNP position information ----
#rownames(pl_all) <- unlist(pos)
rownames(pl_mat_dat) <- unlist(pos)

# > Export matrix ----
#write.table(pl_all, file = paste0(fname, "-GL.txt"), quote = F)
write.table(pl_mat_dat, file=paste0(fname, "-GL.txt"), quote = F)
