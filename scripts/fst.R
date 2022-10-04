### Calculating Fst between subspecies of Tripsacum using population minor allele frequencies ###
# Written By: Julianna Porter
# 09/26/2022

# step 0: load required packages

# step 1: load data
q=read.table("data/af/popaf/minor_pop_af.txt", header = T, row.names=1) # table where rows = subsp and col = loci
#row 1 = hispidum
#row 2 = mexicanum
p=q-1

# step 2: calculate Hs - observed heterozygosity within populations 
# question: is this suppossed to be a single value?? it looks like there will b
ph=p[1,]
qh=q[1,]

pm=p[2,]
qm=q[2,]

homo=((ph*ph + qh*qh) + (pm*pm + qm*qm))/2
Hs = 1 - homo

# step 3: calculate Ht - expected heterozygosity
Q=read.table(data/af/popaf/minor_overall_af.txt", row.names=1) # vector with 1 row per loci 
P=Q-1

Ht=1-((P*P)+(Q*Q))

# step 4: calculate Fst for each site
Fst=(Ht-Hs)/Ht

write.table(Fst, file="data/af/popaf/Fst.txt", sep="\t", row.names=T, quote=F)

