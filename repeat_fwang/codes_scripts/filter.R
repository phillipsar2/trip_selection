# load libraries
library(ggplot2)

# change to your path if different
setwd("/home/wang9418/Tripsacum/repeat")

# save and load r enviornments
load("/home/wang9418/Tripsacum/filter.RData")
save.image(file='/home/wang9418/Tripsacum/filter.RData')

# important path
# filtered data 
# /home/wang9418/Tripsacum/repeat_filtered
# filtering plots
# /home/wang9418/Tripsacum/plots/filter



# archived
# # load one dataset and check the structure etc
# # headers: chrom	start	stop	alignment_length	subject_length	query_length	q_start	q_end	e_value	strand
# n180knob <- read.table('180knob.unfiltered.bed')
# n180knob <- lapply('180knob.unfiltered.bed', read.table)
# str(n180knob)
# head(n180knob)
# tail(n180knob)



# load all dataset
unfiltered_bed_files <- list.files(pattern="..unfiltered.bed")
unfiltered_bed_list <- lapply(unfiltered_bed_files, read.table)
bed_file_names <- gsub(".unfiltered.bed", "", unfiltered_bed_files)
names(unfiltered_bed_list) <- bed_file_names
# [1] "17SrRNA"      "180knob"      "25SrRNA"      "5.8SrRNA"     "brepeat"     
# [6] "centromere"   "chloroplast"  "maizeTR1"     "mitochondria" "telomere" 
writeLines(bed_file_names, "/home/wang9418/Tripsacum/file_names.txt")


# check the dataset sizes
for (i in 1:length(unfiltered_bed_list)){
    print(nrow(unfiltered_bed_list[[i]]))
}
# [1] 270
# [1] 1011398
# [1] 254
# [1] 258
# [1] 58
# [1] 77207
# [1] 3127
# [1] 24393
# [1] 11346
# [1] 165444
for (i in 1:length(unfiltered_bed_list)){
    print(ncol(unfiltered_bed_list[[i]]))
}
# 10 for all of them



# combine the list into one dataframe
for (i in 1:length(unfiltered_bed_list)){
    unfiltered_bed_list[[i]]$name = names(unfiltered_bed_list)[i]
}
unfiltered_bed <- unfiltered_bed_list[[1]]
for (i in 2:length(unfiltered_bed_list)){
    unfiltered_bed = rbind(unfiltered_bed, unfiltered_bed_list[[i]])
}
dim(unfiltered_bed)
# [1] 1293755      11
names(unfiltered_bed)[1:10] <- c("chrom", "start", "stop", "alignment_length", "subject_length", 
                        "query_length", "q_start", "q_end", "e_value", "strand")
for (i in 1:length(unfiltered_bed_list)){
    names(unfiltered_bed_list[[i]])[1:10] = c("chrom", "start", "stop", "alignment_length", "subject_length", 
                        "query_length", "q_start", "q_end", "e_value", "strand")
}



# create a new column of alignment length divided by query length
unfiltered_bed$align_div_by_query <- unfiltered_bed$alignment_length / unfiltered_bed$query_length




# create a table of query length
unfiltered_bed_query_length <- data.frame(name=names(unfiltered_bed_list),
                                        query_length=rep(NA, length(unfiltered_bed_list)))
for (i in 1:length(unfiltered_bed_list)){
    unfiltered_bed_query_length$query_length[i] = unique(unfiltered_bed_list[[i]][, 6])
}
for (i in 1:length(unfiltered_bed_list)){
    unfiltered_bed_query_length$repeat_number[i] = nrow(unfiltered_bed_list[[i]])
}
unfiltered_bed_query_length
#            name query_length repeat_number
# 1       17SrRNA         2215           270
# 2       180knob          180       1011398
# 3       25SrRNA          970           254
# 4      5.8SrRNA          597           258
# 5       brepeat         1012            58
# 6    centromere          156         77207
# 7   chloroplast       141050          3127
# 8      maizeTR1          358         24393
# 9  mitochondria       704100         11346
# 10     telomere          140        165444



# how many passed >=80% alignment/query length criteria 
for (i in names(unfiltered_bed_list)){
    unfiltered_bed_query_length$repeat_number_filterby_length[unfiltered_bed_query_length$name == i] = 
        nrow(unfiltered_bed[unfiltered_bed$name == i & unfiltered_bed$align_div_by_query >= 0.8, ])
}
unfiltered_bed_query_length$percentage <- unfiltered_bed_query_length$repeat_number_filterby_length / 
                                        unfiltered_bed_query_length$repeat_number
#            name query_length repeat_number repeat_number_filterby_length
# 1       17SrRNA         2215           270                           230
# 2       180knob          180       1011398                       1006799
# 3       25SrRNA          970           254                           236
# 4      5.8SrRNA          597           258                           236
# 5       brepeat         1012            58                             0
# 6    centromere          156         77207                         76580
# 7   chloroplast      141,050          3127                             0
# 8      maizeTR1          358         24393                         23265
# 9  mitochondria      704,100         11346                             0
# 10     telomere          140        165444                         19674
#    percentage
# 1   0.8518519
# 2   0.9954528
# 3   0.9291339
# 4   0.9147287
# 5   0.0000000
# 6   0.9918790
# 7   0.0000000
# 8   0.9537572
# 9   0.0000000
# 10  0.1189164



# filter with e_value
filtered_bed_01 <- unfiltered_bed[unfiltered_bed$e_value <= 0.01,]
dim(unfiltered_bed)
# [1] 1293755      12
dim(filtered_bed_01)
# [1] 1194950      12

# filter all categories with >=80% alignment length divided by query length, except chloroplat, mitochondria, telomere or brepeats
filtered_bed_02 <- filtered_bed_01[(!(filtered_bed_01$name %in% c("chloroplast", "mitochondria", "telomere", "brepeats"))) &
                                (filtered_bed_01$align_div_by_query >= 0.8), ]
# filter chloroplast and mitochondria with >=10kb alignment length
filtered_bed_02 <- rbind(filtered_bed_02, 
                filtered_bed_01[(filtered_bed_01$name %in% c("chloroplast", "mitochondria")) & 
                                (filtered_bed_01$alignment_length >= 10000), ])
# filter brepeats with >=100 bp alignment length 
filtered_bed_02 <- rbind(filtered_bed_02, 
                filtered_bed_01[(filtered_bed_01$name == "brepeat") & 
                                (filtered_bed_01$alignment_length >= 100), ])
# filter telomere with >=90% alignment length divided by query length
filtered_bed_02 <- rbind(filtered_bed_02, 
                filtered_bed_01[(filtered_bed_01$name == "telomere") & 
                                (filtered_bed_01$align_div_by_query >= 0.9), ])
dim(filtered_bed_02)
# [1] 1124086      12

unfiltered_bed_query_length_02 <- unfiltered_bed_query_length
names(unfiltered_bed_query_length_02)[4] <- "filtered_repeat_number"
for (i in 1:10){
    unfiltered_bed_query_length_02$filtered_repeat_number[i] = 
        nrow(filtered_bed_02[filtered_bed_02$name == unfiltered_bed_query_length_02$name[i],])
}
unfiltered_bed_query_length_02$percentage <- unfiltered_bed_query_length_02$filtered_repeat_number / 
                                            unfiltered_bed_query_length_02$repeat_number
unfiltered_bed_query_length_02
#            name query_length repeat_number filtered_repeat_number  percentage
# 1       17SrRNA         2215           270                    230 0.851851852
# 2       180knob          180       1011398                1006799 0.995452829
# 3       25SrRNA          970           254                    236 0.929133858
# 4      5.8SrRNA          597           258                    236 0.914728682
# 5       brepeat         1012            58                     40 0.689655172
# 6    centromere          156         77207                  76580 0.991878975
# 7   chloroplast       141050          3127                      9 0.002878158
# 8      maizeTR1          358         24393                  23265 0.953757225
# 9  mitochondria       704100         11346                     88 0.007756037
# 10     telomere          140        165444                  16603 0.100354198

# save the filtered 
setwd("/home/wang9418/Tripsacum/repeat_filtered")
for (i in bed_file_names){
    write.table(filtered_bed_02[filtered_bed_02$name == i, 1:10], paste(i, ".filtered.bed", sep=""), 
                col.names=FALSE, row.names=FALSE, quote=F, sep="\t")
}

# check the filtered data
head(read.table('180knob.filtered.bed'))




# plotting
setwd("../plots/filter")

pdf("histogram of different repeats.pdf")
ggplot(data=unfiltered_bed, aes(x=name)) + geom_bar()
dev.off()

pdf("histogram of e-value.pdf")
ggplot(data=unfiltered_bed, aes(x=e_value)) + geom_histogram()
dev.off()

pdf("histogram of e-value by name.pdf")
ggplot(data=unfiltered_bed, aes(x=e_value)) + geom_histogram() + 
    facet_wrap(~name, scales="free") + 
    theme(axis.text.x = element_text(angle = 90), 
        plot.margin = margin(r=20))
dev.off()

pdf("histogram of align div by query length.pdf")
ggplot(data=unfiltered_bed, aes(x=align_div_by_query)) + geom_histogram()
dev.off()

pdf("histogram of align div by query length by name.pdf")
ggplot(data=unfiltered_bed, aes(x=align_div_by_query)) + geom_histogram() + 
    facet_wrap(~name, scales="free") + 
    theme(axis.text.x = element_text(angle = 90), 
        plot.margin = margin(r=20))
dev.off()
# brepeat, chloroplast, mitochondria



# unfiltered_bed[unfiltered_bed$name=="chloroplast", ]

pdf("histogram of align div by query length by chrom chloro.pdf", width=24, height=24)
ggplot(data=unfiltered_bed[unfiltered_bed$name=="chloroplast", ], aes(x=align_div_by_query)) + 
    geom_histogram() + 
    facet_wrap(~chrom, scales="free") + 
    theme(axis.text.x = element_text(angle = 90), 
        plot.margin = margin(r=20))
dev.off()

pdf("boxplot of align div by query length chloro.pdf")
ggplot(data=unfiltered_bed[unfiltered_bed$name=="chloroplast", ], aes(x=chrom, y=align_div_by_query)) + 
    geom_boxplot() + 
    theme(axis.text.x = element_text(angle = 90), 
        plot.margin = margin(r=20))
dev.off()

pdf("boxplot of align div by query length mi.pdf")
ggplot(data=unfiltered_bed[unfiltered_bed$name=="mitochondria", ], aes(x=chrom, y=align_div_by_query)) + 
    geom_boxplot() + 
    theme(axis.text.x = element_text(angle = 90), 
        plot.margin = margin(r=20))
dev.off()

pdf("boxplot of align div by query length brepeat.pdf")
ggplot(data=unfiltered_bed[unfiltered_bed$name=="brepeat", ], aes(x=chrom, y=align_div_by_query)) + 
    geom_boxplot() + 
    theme(axis.text.x = element_text(angle = 90), 
        plot.margin = margin(r=20))
dev.off()

pdf("boxplot of align div by query length telomere.pdf")
ggplot(data=unfiltered_bed[unfiltered_bed$name=="telomere", ], aes(x=chrom, y=align_div_by_query)) + 
    geom_boxplot() + 
    theme(axis.text.x = element_text(angle = 90), 
        plot.margin = margin(r=20))
dev.off()



# plotting of filtered_bed_01
pdf("histogram of e-value by name 01.pdf")
ggplot(data=filtered_bed_01, aes(x=e_value)) + geom_histogram() + 
    facet_wrap(~name, scales="free") + 
    theme(axis.text.x = element_text(angle = 90), 
        plot.margin = margin(r=20))
dev.off()

# plotting of filtered_bed_02
pdf("histogram of align div by query length by name 02.pdf")
ggplot(data=filtered_bed_02, aes(x=align_div_by_query)) + geom_histogram() + 
    facet_wrap(~name, scales="free") + 
    theme(axis.text.x = element_text(angle = 90), 
        plot.margin = margin(r=20))
dev.off()

pdf("histogram of alignment length by name 02.pdf")
ggplot(data=filtered_bed_02, aes(x=alignment_length)) + geom_histogram() + 
    facet_wrap(~name, scales="free") + 
    theme(axis.text.x = element_text(angle = 90), 
        plot.margin = margin(r=20))
dev.off()







# # archived
# # select repeats with at most 0.01 e-value
# unfiltered_bed_sub_by_e <- unfiltered_bed[unfiltered_bed$V9 <= 0.1,]

# # replot
# pdf("histogram of e-value sub e-value.01.pdf")
# ggplot(data=unfiltered_bed_sub_by_e, aes(x=V9)) + geom_histogram()
# dev.off()

# pdf("histogram of e-value sub e-value.01 by name.pdf")
# ggplot(data=unfiltered_bed_sub_by_e, aes(x=V9)) + 
#     geom_histogram() + 
#     facet_wrap(~name) 
# dev.off()

# pdf("histogram of e-value sub e-value.01 by name change ylim.pdf")
# ggplot(data=unfiltered_bed_sub_by_e, aes(x=V9)) + 
#     geom_histogram() + 
#     ylim(0, 150000) + 
#     facet_wrap(~name) 
# dev.off()

# pdf("histogram of e-value sub e-value.002.pdf")
# ggplot(data=unfiltered_bed_sub_by_e[unfiltered_bed_sub_by_e$V9 <= 0.002,], aes(x=V9)) + 
#     geom_histogram()
# dev.off()

# pdf("test.pdf")
# ggplot(data=unfiltered_bed_list[["180knob"]], 
#         aes(x=V9)) + 
#     geom_histogram()
# dev.off()