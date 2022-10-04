## Plot ENTROPY results
## Author: Alyssa Phillips
## Modified by: Julianna Porter 

library(ggplot2)
library(stringr)
library(dplyr)
library(forcats)
library(ggthemes)
library(patchwork)

# Load admixture results
q <- read.csv("~/Andropogon/ENTROPY/qest.k14.c1.txt")
q$param <- as.factor(q$param)

temp <- str_split(q$param, pattern = "_", simplify = T, n = 4)
ind <- paste0(temp[,2], "_", temp[,3])

df <- data.frame(ind, temp[,4], q$mean)
colnames(df) <- c("ind", "assignment", "q.mean")

# Add meta data
names <- read.csv("~/Andropogon/ENTROPY/sample_names.txt", header = F)
meta <- read.csv("~/Andropogon/ENTROPY/sample_metadata.csv", header = T)

# add samples names to samples
temp <- data.frame(matrix(ncol = 2, nrow = 0), stringsAsFactors = T)
colnames(temp) <- c("pop", "ploidy")

for (i in 1:dim(df)[1]){
  temp[i, ] <- unlist( meta[ match(df$ind[i], meta$ind), 2:3], use.names = F)
}

all_df <- data.frame(df, temp)
all_df$pop <- as.factor(all_df$pop)
all_df$ploidy <- as.factor(all_df$ploidy)
all_df$ind <- as.factor(all_df$ind)
 
# Plot data ----
pdf("~/Andropogon/ENTROPY/k14.pop.pdf", width = 6, height = 3)

# library(magrittr)
# plotOrder <- all_df %>% filter(assignment == "pop_0") %>% arrange(q.mean) %>% extract2("ind") %>% as.vector()

# lvls <- names(sort(table(all_df[all_df$assignment == "pop_0", "q.mean"])))

lvls <- all_df[all_df$assignment == "pop_0", ] %>% arrange(desc(q.mean)) %>% extract2("ind")

all_df %>% 
  # arrange(assignment, desc(q.mean)) %>%
  arrange(pop) %>%
  ggplot(aes(y = q.mean, x = factor(ind, levels = lvls), fill = assignment)) +
  geom_bar(position = "fill", stat = "identity", width = 1) +
  # geom_point(aes(x = ploidy)) +
  theme_minimal() +
  facet_grid(~pop, scales = "free", space = "free", switch = "x") +
  scale_y_continuous(expand = c(0,0)) +
  scale_x_discrete(expand = expansion(add = 1)) +
  theme(
    panel.spacing.x = unit(0.1, "lines"),
    axis.text = element_blank(),
    # axis.text.x = element_text(angle = 90, size = 4),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    strip.text.x = element_text(angle = 90, size = 4),
    legend.position="none",
    plot.title = element_text(hjust = 0.5)
  ) +
  ggtitle("K=14")
 
  
# + scale_fill_gdocs(guide = FALSE)

dev.off()

# k2 + k3 + k4 + plot_layout(ncol=1)

# Plot DIC values ----
dic <- read.csv("~/Andropogon/ENTROPY/DIC.txt", sep = "\t", header = F)
names(dic) <- c("k", "dic")

k <- 2:14

plot(k, dic$dic)
