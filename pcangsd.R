# pcangsd

setwd("/Users/lilydurkee/OneDrive - Colostate/Grad School/R-Projects-Grad/Colias")

#### 4.0x by coverage ####

#upload covariance matrix
cov<-as.matrix(read.table("colias-full-down4.0x.cov"))
names<-read_delim("colias-full-down4.0x-bam-list.ind", delim = " ", col_names=F)

#eigenvalues
e<-eigen(cov)

#make dataframe
e.df <- as.data.frame(e$vectors)
e.df$ID <- names$X1

e.df$name <- substr(e.df$ID, 1, 2)

e.df <- e.df %>% dplyr::select(c(V1, V2, ID, name))

#upload all info about sites
sites <- read.csv("sites-all1.csv")

pca_4.0x <- merge(e.df, sites, by="name", all=T)
pca_4.0x.data <- merge(pca_4.0x, all.depth, by="ID")
pca_4.0x.data$cov <- ifelse(pca_4.0x.data$coverage>4, 4, pca_4.0x.data$coverage)

pca_4.0x.data$category1 <- ifelse(pca_4.0x.data$name=="Eu", "C. eurytheme", 
                            ifelse(pca_4.0x.data$name=="AL", "C. alexandra", pca_4.0x.data$elevation))

#simple PCA
plot(e$vectors[,1:2], xlim=c(-.1, .1))

#with ggplot
#library(ggplot2)
plot4.0x <- ggplot(data=pca_4.0x.data, aes(x = V1, y = V2, 
                           shape=category1, 
                           color=cov)) +
  geom_point(size=2)+
  labs(x="PC1", y="PC2") +
  xlim(-.025, .025) +
  ylim(-.05, .075) #+
  #geom_text(aes(label=ID), color="black", size=2.5, vjust=.5, hjust=.5)

plot4.0x

## Notes: FV14 clumps with C. euretheme individuals
## use: filter(pca_4.0x.data, name != "Eu")

#amount that can be explained by each variable
e$values/sum(e$values)

#read in full bamlist, IDs only
names<-read.table("colias-full-down4.0x-bam-list.ind")


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


### all ###
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
