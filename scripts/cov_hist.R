### Creating a histrogram of per base coverage for 3 indidivuals 
### Written by: Julianna Porter
### 09/29/2022

# load required packages
library("data.table", lib.loc = "~/R_Packages/R3.6.3")

# load data
cov <- read.table(file = "data/repeat_abundance/coverage/allTE/12836_16.50ksnp.perbpcov.txt")
#X25612_8 <- fread(file = "data/repeat_abundance/coverage/allTE/25612_8.MCRGD009_CKDL200167244-1a-D702-AK1680_HMHFTDSXY_L4.MCRGD087_CKDL200167244-1a-D711-AK1545_HMHFTDSXY_L4.merged.allTE.coverage.bed", header = F)
#X25636_2 <- fread(file = "data/repeat_abundance/coverage/allTE/25636_2.MCRGD081_CKDL200167244-1a-D711-AK1680_HMHFTDSXY_L4.MCRGD082_CKDL200167244-1a-D711-AK1681_HMHFTDSXY_L4.merged.allTE.coverage.bed", header = F)
coverage <- data.frame(cov)

coverage$V1 <- as.numeric(coverage$V1)
range(cov)
# create histogram of per base coverage 
h16 <- hist(cov)
#h8 <- hist(X25612_8$V5)
#h2 <- hist(X25636_2$V5)

# plot histograms into a PDF
pdf(file="data/reports/allTE.coverage.histogram.pdf")

plot(h16, main = "Histogram of per base coverage for intersection between .bed files of 12836_16 and allTE", xlab = "12836_16.allTE.coverage.bed per base coverage")
#plot(h8, main = "Histogram of per base coverage for intersection between .bed files of 25612_8 and allTE", xlab = "25612_8.allTE.coverage.bed per base coverage")
#plot(h2, main = "Histogram of per base coverage for intersection between .bed files of 25636_2 and allTE", xlab = "25636_2.allTE.coverage.bed per base coverage")

dev.off()
