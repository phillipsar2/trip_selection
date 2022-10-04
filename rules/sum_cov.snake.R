# summarizing the per base coverage and the region length for the output of bedtools coverage 

# load packages
library("dplyr", lib.loc = "~/R_Packages/R3.6.3")
library("tidyverse", lib.loc = "~/R_Packages/R3.6.3")

# load data
bed <- fread(file = snakemake@input[[1]], header = F, sep = "\t")

# name columns 
colnames(bed) <- c("CHROM", "START", "STOP", "Merge_Count", "BP in region", "Coverage")

# group by region and sum coverage for entire region
sum_grp <- bed %>%
  group_by(CHROM, START, STOP) %>%
  summarise(Freq = sum(Coverage))

# create new column that is the length of the region by taking the difference of start and stop position
sum_grp$region_lg <- sum_grp$STOP - sum_grp$START

# sum both the coverage and the region length
sum_bp <- sum(sum_grp$region_lg)
sum_cov <- sum(sum_grp$Freq)

# combine the sum to a single matrix
out <- cbind(sum_bp, sum_cov)

#write the matrix to a file
write.table(out, file = snakemake@output[[1]], sep = "\t", row.names = F, col.names = T, quote = F)
