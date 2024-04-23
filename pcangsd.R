# pcangsd

setwd("/Users/lilydurkee/OneDrive - Colostate/Grad School/R-Projects-Grad/Colias/Data")
library(tidyverse)

#### 4.0x - data processing - related individuals removed ####

# coverage data - individual sample depths
all.depth <- read_delim("covSummary.bedtools.txt", delim = " ")
colnames(all.depth) <- c("full_ID", "ID", "site", "coverage")

#library(stringr)

all.depth$ID <- str_extract(all.depth$full_ID, "(?<=/).*?(?=_)")

lane <- str_match(all.depth$full_ID, "_(.*?)_(.*?)")
all.depth$lane <- lane[,2]

all.depth$site <- substr(all.depth$ID, 1, 2)

all.depth$bam <- sub(".*/([^_]+_[^_]+_[^_]+)_.*", "\\1", all.depth$full_ID)

# all samples
all.samples <- read.csv("all_samples.csv")

all.depth <- merge(all.depth, all.samples, by="ID", all=T)


#upload covariance matrix
cov<-as.matrix(read.table("colias-full-down4.0x-rm.relate-species.cov"))


names<-read_delim("colias-full-down4.0x-bam-list.ind", delim = " ", col_names=F)

# remove related individuals
names.filt <- names %>% filter(X1 != "BG10" & X1 != "HT10" & X1 != "LF01" & X1 != "KP13" &
                                 X1 != "FV15" &
                                 substr(X1, 1, 2) != "Eu" & substr(X1, 1, 2) != "AL")

#eigenvalues
e<-eigen(cov)

#make dataframe
e.df <- as.data.frame(e$vectors)
e.df$ID <- names.filt$X1

e.df$site <- substr(e.df$ID, 1, 2)

e.df <- e.df %>% dplyr::select(c(V1, V2, ID, site))

#upload all info about sites
sites <- read.csv("sites-all1.csv")
sex <- read.csv("colias-sex.csv")

pca_4.0x <- merge(e.df, sites, by="site", all=T)
pca_4.0x.cov <- merge(pca_4.0x, all.depth, by="ID")
pca_4.0x.data <- merge(pca_4.0x, sex, by="ID", all=F)

pca_4.0x.data$cov <- ifelse(pca_4.0x.data$coverage>4, 4, pca_4.0x.data$coverage)

#pca_4.0x.data$category1 <- ifelse(pca_4.0x.data$name=="Eu", "C. eurytheme", 
#                            ifelse(pca_4.0x.data$name=="AL", "C. alexandra", pca_4.0x.data$elevation))

#pca_4.0x.data$pair <- ifelse(pca_4.0x.data$name=="WY", "WY", 
 #                      ifelse(pca_4.0x.data$name=="SC", "E2", pca_4.0x.data$pair))


#simple PCA
#plot(e$vectors[,1:2], xlim=c(-.1, .1))

#### plot 1: by coverage or by lane ####
#library(ggplot2)
plot4.0x.cov <- ggplot(data=pca_4.0x.data, aes(x = V1, y = V2, 
                                          # shape=category1, 
                                           color=lane)) +
  geom_point(size=2)+
  labs(x="PC1", y="PC2") #+
  #xlim(-.025, .025) +
  #ylim(-.05, .06) #+
  #scale_colour_gradient(low="red", high="blue")#+
#geom_text(aes(label=ID), color="black", size=2.5, vjust=.5, hjust=.5)

plot4.0x.cov

#### plot 2: by site pair ####
#library(ggplot2)
plot4.0x.pair <- ggplot(data=pca_4.0x.data, aes(x = V1, y = V2, 
                           shape=elevation, 
                           color=pair,
                           label=ID)) +
  #geom_text(hjust = 0, nudge_x = 0.02, size = 3) +  # Add labels
  geom_point(size=3)+
  labs(x="PC1", y="PC2") +
  #xlim(-.012, .025) +
  #ylim(-.05, .1) +
  scale_shape_manual(values=c(8,20)) +
  scale_color_manual(values = c("aquamarine", "turquoise1", "turquoise3", "turquoise4",
                                "hotpink", "violetred2","violetred4", "darkgreen")) +
  theme_classic()

plot4.0x.pair


#### east-west and high-low comparisons with all points ####
pca_4.0x.data$divide <- ifelse(pca_4.0x.data$name=="WY", "E", substr(pca_4.0x.data$pair, 1, 1))

plot4.0x.simple1 <- ggplot(data=filter(pca_4.0x.data, name != "AL" & name != "Eu"), aes(x = V1, y = V2, 
                                                                                     #shape=elevation, 
                                                                                     color=divide)) +
  geom_point(size=2.5)+
  labs(x="PC1", y="PC2") +
  xlim(-.012, .025) +
  ylim(-.05, .1) +
 # scale_shape_manual(values=c(18, 20)) +
  scale_color_manual(values = c("turquoise3", "violetred2")) +
  theme_classic()+
  theme(legend.position="top")

plot4.0x.simple1


plot4.0x.simple2 <- ggplot(data=filter(pca_4.0x.data, name != "AL" & name != "Eu"), aes(x = V1, y = V2, 
                                                                                       # color=elevation,
                                                                                        shape=elevation)) +
  geom_point(size=2.5)+
  labs(x="PC1", y="PC2") +
  xlim(-.012, .025) +
  ylim(-.05, .1) +
  scale_shape_manual(values=c(1, 5)) +
  #scale_color_manual(values = c("dodgerblue", "goldenrod")) +
  theme_classic()+
  theme(legend.position="top")

plot4.0x.simple2


#### all points ####
library(ggplot2)
pca_4.0x.data$species <- ifelse(pca_4.0x.data$name=="Eu", "C. eurytheme", 
                             ifelse(pca_4.0x.data$name=="AL", "C. alexandra", "C. p. eriphyle"))

ggplot(data=pca_4.0x.data, aes(x = V1, y = V2, 
                           color=species, shape=species)) +
  geom_point(size=2.5)+
  labs(x="PC1", y="PC2")+
  theme_classic()+
  scale_color_manual(values=c("lightgoldenrod", "orange", "yellow" ))+
  scale_shape_manual(values=c(15, 18, 17)) #+
  #geom_text(hjust = 0, nudge_x = 0.02, size = 3) 
  

## Notes: FV15 clumps with C. eurytheme individuals
## use: filter(pca_4.0x.data, name != "Eu")

#amount that can be explained by each variable
e$values/sum(e$values)*100

#read in full bamlist, IDs only
names<-read.table("colias-full-down4.0x-bam-list.ind")

#### 4.0x subset 1: high-low comparison ####
library(tidyverse)

#upload covariance matrix
cov_hl<-as.matrix(read.table("colias-full-down4.0x-subset1-highlow-no_e.cov"))
names<-read_delim("colias-full-down4.0x-bam-list.ind", delim = " ", col_names=F)

names_hl <- names.filt %>% filter(substr(names.filt$X1, 1, 1)=="L" |
                           substr(names.filt$X1, 1, 1)=="S" |
                           substr(names.filt$X1, 1, 2)=="NF" |
                           substr(names.filt$X1, 1, 2)=="HM" )

#eigenvalues
e_hl<-eigen(cov_hl)
plot(e_hl$vectors[,1:2])

#make dataframe
e.df_hl <- as.data.frame(e_hl$vectors)


e.df_hl$ID <- names_hl$X1
e.df_hl$name <- substr(e.df_hl$ID, 1, 2)
e.df_hl <- e.df_hl %>% dplyr::select(c(V1, V2, ID, name))

pca_4.0x.hl <- merge(e.df_hl, sites, by="name", all=F)
pca_4.0x.hl$pair <- ifelse(pca_4.0x.hl$name=="SC", "E2", pca_4.0x.hl$pair)

plot4.0x.hl <- ggplot(data=pca_4.0x.hl, aes(x = V1, y = V2, shape=elevation,
                                            color=pair)) +
  geom_point(size=2)+
  labs(x="PC1", y="PC2") +
 # xlim(-.012, .025) +
 # ylim(-.05, .1) +
  scale_shape_manual(values=c(8,19)) +
  theme_classic()

plot4.0x.hl


#### 4.0x subset 2: east-west comparison - NOW GATK ####

cov_ew<-as.matrix(read.table("colias-full-down4.0x-subset2-eastwest.cov"))
#names<-read_delim("colias-full-down4.0x-bam-list.ind", delim = " ", col_names=F)

names.filt <- names %>% filter(X1 != "BG10" & X1 != "HT10" & X1 != "LF01" & X1 != "KP13" &
                  
                                 substr(X1, 1, 2) != "Eu" & substr(X1, 1, 2) != "AL")

names_ew <- names.filt %>% filter(substr(names.filt$X1, 1, 2)=="FV" |
                                    substr(names.filt$X1, 1, 2)=="HT" |
                                    substr(names.filt$X1, 1, 2)=="KP" |
                                    substr(names.filt$X1, 1, 2)=="MS" )

#eigenvalues
e_ew<-eigen(cov_ew)
e_ew$values/sum(e_ew$values)*100

plot(e_ew$vectors[,1:2])

#make dataframe
e.df_ew <- as.data.frame(e_ew$vectors)


e.df_ew$ID <- names_ew$X1
e.df_ew$name <- substr(e.df_ew$ID, 1, 2)
e.df_ew <- e.df_ew %>% dplyr::select(c(V1, V2, ID, name))

pca_4.0x.ew <- merge(e.df_ew, sites, by="name", all=F)
pca_4.0x.ew$divide <- substr(pca_4.0x.ew$pair, 1, 1)

plot4.0x.ew <- ggplot(data=pca_4.0x.ew, aes(x = V1, y = V2, shape=elevation,
                                            color=pair, label=ID)) +
  geom_point(size=3.5)+
  labs(x="PC1", y="PC2") +
  scale_shape_manual(values=c(8,20)) +
  scale_color_manual(values=c("#E7298A", "#A6761D"))+
  #geom_text(hjust = 0, nudge_x = 0.02, size = 3) +  # Add labels
  theme_classic()

plot4.0x.ew

ggsave("colias-ew-update.svg", width=5, height=4)

#### 3.5x ####

#upload covariance matrix
cov<-as.matrix(read.table("colias-full-down3.5x.cov"))

#eigenvalues
e<-eigen(cov)

#make dataframe
e.df <- as.data.frame(e$vectors)
e.df$ID <- names$V1
e.df$name <- substr(e.df$ID, 1, 2)

e.df <- e.df %>% dplyr::select(c(V1, V2, ID, name))

#upload all info about sites
sites <- read.csv("sites-all1.csv")

pca_3.5x.data <- merge(e.df, sites, by="name", all=T)
pca_3.5x.data$cov <- "3.5x"

#simple PCA
plot(e$vectors[,1:2], xlim=c(-.1, .1))

#with ggplot
plot3.5x <- ggplot(data=pca_3.5x.data, aes(x = V1, y = V2, 
                           #color=name, 
                           color=elevation)) +
  geom_point()+
  labs(x="PC1", y="PC2") +
  xlim(-.125, .025) +
  ylim(-.1, .35) +
  geom_text(aes(label=ID), color="black", size=2.5, vjust=.5, hjust=.5)

plot3.5x

#### 3.0x ####

#upload covariance matrix
cov<-as.matrix(read.table("colias-full-down3.0x.cov"))

#eigenvalues
e<-eigen(cov)

#make dataframe
e.df <- as.data.frame(e$vectors)
e.df$ID <- names$V1
e.df$name <- substr(e.df$ID, 1, 2)

e.df <- e.df %>% dplyr::select(c(V1, V2, ID, name))

#upload all info about sites
sites <- read.csv("sites-all1.csv")

pca_3.0x.data <- merge(e.df, sites, by="name", all=T)
pca_3.0x.data$cov <- "3.0x"

#simple PCA
plot(e$vectors[,1:2], xlim=c(-.1, .1))

#with ggplot
plot3.0x <- ggplot(data=pca_3.5x.data, aes(x = V1, y = V2, 
                                           #shape=elevation, 
                                           color=elevation)) +
  geom_point(size=2)+
  labs(x="PC1", y="PC2") +
  xlim(-.125, .025) +
  ylim(-.1, .35) +
  geom_text(aes(label=ID), color="black", size=2.5, vjust=.5, hjust=.5)

plot3.0x


#### all coverage ####
pca_all <- rbind(pca_3.0x.data, pca_3.5x.data, pca_4.0x.data)

pca_all$category1 <- ifelse(pca_all$name=="Eu", "C. eurytheme", 
                           ifelse(pca_all$name=="AL", "C. alexandra", pca_all$elevation))

pca_all$category2 <- ifelse(pca_all$name=="Eu", "C. eurytheme", 
                            ifelse(pca_all$name=="AL", "C. alexandra", 
                                   ifelse(pca_all$name=="WY", "WY", 
                                          ifelse(pca_all$name=="SC", "E2", pca_all$pair))))



pca_all$ID2 <- ifelse(pca_all$ID == "FV15", "FV15", NA)


plot_all1 <- ggplot(data=pca_all, aes(x = V1, y = V2, 
                                           color=category1)) +
  facet_wrap(~ cov) +
  geom_point(size=2)+
  labs(x="PC1", y="PC2") +
  #xlim(-.125, .025) +
  #ylim(-.1, .35) +
  xlim(-.025, .025) +
  ylim(-.07, .07)+
  geom_text(aes(label=ID2), color="black", size=2.5, vjust=.5, hjust=.5)
  

plot_all2 <- ggplot(data=pca_all, aes(x = V1, y = V2, 
                                      color=category2)) +
  facet_wrap(~ cov) +
  geom_point(size=2)+
  labs(x="PC1", y="PC2") +
  #xlim(-.125, .025) +
  #ylim(-.1, .35) +
  xlim(-.025, .025) +
  ylim(-.07, .07)+
  geom_text(aes(label=ID2), color="black", size=2.5, vjust=.5, hjust=.5)


plot_all2

#library(ggpubr)
ggarrange(plot_all1, plot_all2, nrow=2)

plot_all3 <- ggplot(data=filter(pca_all, name != "Eu" & name != "AL"), aes(x = V1, y = V2, 
                                      color=category2,
                                      shape=elevation)) +
  facet_wrap(~ cov) +
  geom_point(size=2)+
  labs(x="PC1", y="PC2") +
  #xlim(-.125, .025) +
  #ylim(-.1, .35) +
  xlim(-.025, .025) +
  ylim(-.07, .07)+
  geom_text(aes(label=ID2), color="black", size=2.5, vjust=.5, hjust=.5)+
  scale_color_manual(values=c("red", "orange", "yellow", "green", 
                              "salmon 1", "salmon 2", "salmon3", "steelblue"))+
  scale_shape_manual(values=c(17, 15))
  
plot_all3
