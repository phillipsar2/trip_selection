library("ggplot2", lib.loc = "~/R_Packages/R3.6.3")

gl_tab <- read.table("data/ebg/output/scaf_8-GL.txt")

ind1 <- gl_tab$25636_5.MCRGD035_CKDL200167244-1a-D705-AK1682_HMHFTDSXY_L4.MCRGD072_CKDL200167244-1a-D709-AK1546_HMHFTDSXY_L4.merged %>% str_split(",", simplify = T) %>% as.data.frame()
names(ind1) <- c("g0", "g1", "g2")
ind1$site <- row.names(gl_tab)

ind1_long<-gather(ind1,genotype,like,g0,g1,g2)
ind1_long$genotype=as.factor(ind1_long$genotype)
ind1_long$site=as.factor(ind1_long$site)
ind1_long$like=as.numeric(ind1_long$like)
summary(ind1_long)
in12<-ind1_long[order(ind1_long$site),]
head(in12,300) %>% 
  ggplot(aes(x=genotype,y=like,group=site))+
  geom_line(aes(color=site))+
  theme(legend.position = "none")  
gl_plot <- head(in12,300) %>%
  ggplot(aes(x=genotype,y=like,group=site))+
  geom_line(aes(color=site))+
  theme(legend.position = "none") 

write.table(gl_plot, file = "data/ebg/output/scaf_8_GL_table.
