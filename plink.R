# gatk

setwd("/Users/lilydurkee/OneDrive - Colostate/Grad School/R-Projects-Grad/Colias/Data")

# Load the data from the .eigenvec file
pca_data <- read.table("colias.4x.merged_gatk.rm.relate.SNP.filtered_gatkVQSR2.PASS.8miss.eigenvec", header = TRUE)
#pca_data <- pca_data[-1, ]

pca_gatk <- as.data.frame(pca_data)
pca_gatk$site <- substr(pca_gatk$FID, 1, 2)

sites <- read.csv("sites-all1.csv")
pca_gatk.all1 <- merge(pca_gatk, sites, by="site", all=T)
pca_gatk.all1$ID <- pca_gatk.all1$FID
sex <- read.csv("colias-sex.csv")
pca_gatk.all <- merge(pca_gatk.all1, sex, by="ID", all=F)
pca_gatk.all$divide <- ifelse(pca_gatk.all$pair == "WY", "E", 
                              ifelse(pca_gatk.all$site.x == "HM", "W", 
                                     substr(pca_gatk.all$pair, 1, 1)))

#write.csv(pca_gatk.all, "all-samples.csv")

library(ggplot2)
library(viridis)

#### plots - entsoc ####
ggplot(pca_gatk.all, aes(x = PC1, y = PC2, color = pair, shape=elevation, label=ID)) +
  geom_point(size=3) +
  #geom_text(hjust = 0, nudge_x = 0.02, size = 3) +  # Add labels
  xlab("PC1") +
  ylab("PC2") +
  scale_color_brewer(palette="Dark2")+
  scale_shape_manual(values=c(8,20)) +
  theme_classic()

# high vs low
ggplot(pca_gatk.all, aes(x = PC1, y = PC2, color = elevation, shape=elevation)) +
  geom_point(size=3) +
  #geom_text(hjust = 0, nudge_x = 0.02, size = 3) +  # Add labels
  xlab("PC1") +
  ylab("PC2") +
  scale_color_manual(values=c("royalblue", "red"))+
  scale_shape_manual(values=c(8,20)) +
  theme_classic()

ggsave("colias-hl-entsoc.svg", width=6, height=4)



#east vs west
ggplot(pca_gatk.all, aes(x = PC1, y = PC2, color = divide, shape = divide)) +
  geom_point(size=3, alpha=0.8) +
  #geom_text(hjust = 0, nudge_x = 0.02, size = 3) +  # Add labels
  xlab("PC1") +
  ylab("PC2") +
  scale_color_manual(values=c("forestgreen", "orange"))+
  scale_shape_manual(values=c(15, 17)) +
  theme_classic()

ggsave("colias-ew-entsoc.svg", width=6, height=4)


#### southern sites: east-west comparison ####
library(tidyverse)

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
e.df_ew$site <- substr(e.df_ew$ID, 1, 2)
e.df_ew <- e.df_ew %>% dplyr::select(c(V1, V2, ID, site))

pca_4.0x.ew <- merge(e.df_ew, sites, by="site", all=F)
#pca_4.0x.ew$divide <- substr(pca_4.0x.ew$pair, 1, 1)

plot4.0x.ew <- ggplot(data=pca_4.0x.ew, aes(x = V1, y = V2, shape=elevation,
                                            color=pair, label=ID)) +
  geom_point(size=3.5)+
  labs(x="PC1", y="PC2") +
  scale_shape_manual(values=c(8,20)) +
  scale_color_manual(values=c("#E7298A", "#A6761D"))+
 # geom_text(hjust = 0, nudge_x = 0.02, size = 3) +  # Add labels
  theme_classic()

plot4.0x.ew

ggsave("colias-ew-entsoc.svg", width=6, height=4)



#### plot attempt 1 ####
ggplot(pca_gatk.all, aes(x = PC1, y = PC2, color = pair, shape=sex, label=ID)) +
  geom_point(size=3) +
  #geom_text(hjust = 0, nudge_x = 0.02, size = 3) +  # Add labels
  xlab("PC1") +
  ylab("PC2") +
  scale_color_manual(values = c("aquamarine", "turquoise1", "turquoise3", "turquoise4",
                                            "hotpink", "violetred2","violetred4", "darkgreen")) +
  scale_shape_manual(values=c(8,20)) +
  theme_classic()
