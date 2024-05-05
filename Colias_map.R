# first attempt at map

setwd("/Users/lilydurkee/OneDrive - Colostate/Grad School/R-Projects-Grad/Colias")


library(raster)  # important to load before tidyverse, otherwise it masks select()
library(tidyverse)
library(sf)
library(ggspatial)
library(RColorBrewer)

#### raster file #####
domain <- c(
  xmin = -120,
  xmax = -100,
  ymin = 30,
  ymax = 50
)

#creates new directory
# dir.create("ne_rasters", showWarnings = FALSE)
# 
# tmpfile <- tempfile()
# 
# options(timeout=200)
# 
# downloader::download(
#   url = "https://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/raster/HYP_HR_SR_OB_DR.zip",
#   dest = tmpfile
# )

# unzip(zipfile = tmpfile, exdir = "ne_rasters")

# cropping the file
hypso <- brick("/Users/lilydurkee/OneDrive - Colostate/Grad School/R-Projects-Grad/Colias/Data/ne_rasters/HYP_HR_SR_OB_DR.tif")
hypso_cropped <- crop(hypso, extent(domain)) 

######## maps #########
state <- map_data("state")
#co_wy1 <- subset(state, region=="colorado" | region=="wyoming")
counties <- map_data("county")
#co_wy2 <- subset(counties, region=="colorado" | region=="wyoming")

sites1 <- read.csv("Data/sites-all1.csv")
#sites$pair <- ifelse(sites$name=="SC", "E2", ifelse(
#                     sites$name=="WY", "WY", sites$pair))

CDT <- read.csv("CDT.csv")

#### high vs low - for BZ562 project ####
sites <- read.csv("colias_bioclim.csv")
#sites$site <- substr(sites$ID, 1, 2)
#sites <- merge(sites, sites1, by="site", all=F)

ggplot() +
  ggspatial::layer_spatial(hypso_cropped, alpha=.8) +
  geom_polygon(data=state, mapping=aes(x=long, y=lat, group=group), 
               color="black", fill="white", alpha=0) + # state
  # geom_point(data=CDT, aes(x=long, y=lat, group=NULL), color="gray60", size=.01)+
  # geom_line(data = sites, mapping = aes(x=x, y=y, group=pair), linewidth=.7)+
  geom_point(data = sites, 
             mapping = aes(x = x, y = y, fill=site), 
             size = 6, shape=21)+
  scale_fill_manual(values=c("#1f77b4", "#ff7f0e", "#2ca02c", "#d62728", "#9467bd",
                              "#8c564b", "#e377c2", "#7f7f7f", "#bcbd22", "#17becf",
                              "#aec7e8", "#ffbb78", "#98df4a", "#ff9896"))+
 # scale_shape_manual(values = c(21, 24))+
  theme_minimal() +
  coord_sf(xlim = c(-110, -102), ylim = c(37, 42)) 

ggsave("Colias-map-project-bigger.png")

#### fancy map with raster - entsoc ####
map_raster <- ggplot() +
  ggspatial::layer_spatial(hypso_cropped, alpha=.5) +
  geom_polygon(data=state, mapping=aes(x=long, y=lat, group=group), 
               color="black", fill="white", alpha=0) + #might input state here
  geom_point(data=CDT, aes(x=long, y=lat, group=NULL), color="darkred", size=.01, alpha=.01)+
  geom_line(data = sites, mapping = aes(x=x, y=y, color=pair, group=pair), linewidth=1)+
  geom_point(data = sites, 
             mapping = aes(x = x, y = y, color=pair, shape=elevation), 
             size = 5)+
  scale_color_brewer(palette="Dark2")+
  scale_shape_manual(values = c(8, 20))+
  theme_minimal() +
  coord_sf(xlim = c(-110, -102), ylim = c(37, 42)) 

map_raster

#### CDT only - entsoc ####

map_no.raster <- ggplot() +
  #ggspatial::layer_spatial(hypso_cropped, alpha=.8) +
  geom_polygon(data=state, mapping=aes(x=long, y=lat, group=group), 
               color="black", fill="white", alpha=0) + #might input state here
  geom_point(data=CDT, aes(x=long, y=lat, group=NULL), color="gray60", size=.01)+
  geom_line(data = sites, mapping = aes(x=x, y=y, color=pair, group=pair), linewidth=.7)+
  geom_point(data = sites, 
             mapping = aes(x = x, y = y, color=pair, shape=elevation), 
             size = 5)+

  scale_color_brewer(palette="Dark2")+
  scale_shape_manual(values = c(8, 20))+
  theme_minimal() +
  coord_sf(xlim = c(-110, -102), ylim = c(37, 42)) 

map_no.raster


#### high vs low for CURC ####
ggplot() +
  ggspatial::layer_spatial(hypso_cropped, alpha=.8) +
  geom_polygon(data=state, mapping=aes(x=long, y=lat, group=group), 
               color="black", fill="white", alpha=0) + #might input state here
  geom_point(data=CDT, aes(x=long, y=lat, group=NULL), color="gray60", size=.01)+
 # geom_line(data = sites, mapping = aes(x=x, y=y, group=pair), linewidth=.7)+
  geom_point(data = sites, 
             mapping = aes(x = x, y = y, color=elevation, shape=elevation), 
             size = 5)+
  scale_color_manual(values=c("royalblue", "red"))+
  scale_shape_manual(values = c(8, 20))+
  theme_minimal() +
  coord_sf(xlim = c(-110, -102), ylim = c(37, 42)) 

ggsave("Colias-map.tiff")

sites$divide <- ifelse(sites$pair=="WY", "E", 
                       ifelse(sites$site == "HM", "W", substr(sites$pair, 1, 1)))

ggplot() +
  #ggspatial::layer_spatial(hypso_cropped, alpha=.8) +
  geom_polygon(data=state, mapping=aes(x=long, y=lat, group=group), 
               color="black", fill="white", alpha=0) + #might input state here
  geom_point(data=CDT, aes(x=long, y=lat, group=NULL), color="gray60", size=.01)+
#  geom_line(data = sites, mapping = aes(x=x, y=y, group=pair), linewidth=.7)+
  geom_point(data = sites, 
             mapping = aes(x = x, y = y, color=divide, shape=divide), 
             size = 3)+
  scale_color_manual(values=c("forestgreen", "orange"))+
  scale_shape_manual(values = c(15, 17))+
  theme_minimal() +
  coord_sf(xlim = c(-110, -102), ylim = c(37, 42)) 


#### fancy map with raster - attempt 1 ####
map_raster <- ggplot() +
  ggspatial::layer_spatial(hypso_cropped, alpha=.8) +
  geom_polygon(data=state, mapping=aes(x=long, y=lat, group=group), 
               color="black", fill="white", alpha=0) + #might input state here
  geom_point(data=CDT, aes(x=long, y=lat, group=NULL), color="gray60", size=.01)+
  geom_line(data = sites, mapping = aes(x=x, y=y, color=pair, group=pair), linewidth=.7)+
  geom_point(data = sites, 
                     mapping = aes(x = x, y = y, color=pair, shape=elevation), 
                     size = 5)+
   scale_color_manual(values = c("aquamarine", "turquoise1", "turquoise3", "turquoise4",
                               "hotpink", "violetred2","violetred4", "darkgreen")) +
  scale_shape_manual(values = c(18, 20))+
  theme_minimal() +
  coord_sf(xlim = c(-110, -102), ylim = c(37, 42)) 

map_raster

#### CDT only - attempt 1 ####

map_no.raster <- ggplot() +
  #ggspatial::layer_spatial(hypso_cropped, alpha=.8) +
  geom_polygon(data=state, mapping=aes(x=long, y=lat, group=group), 
               color="black", fill="white", alpha=0) + #might input state here
  geom_point(data=CDT, aes(x=long, y=lat, group=NULL), color="gray60", size=.01)+
  geom_line(data = sites, mapping = aes(x=x, y=y, color=pair, group=pair), linewidth=.7)+
  geom_point(data = sites, 
             mapping = aes(x = x, y = y, color=pair, shape=elevation), 
             size = 5)+
  scale_color_manual(values = c("aquamarine", "turquoise1", "turquoise3", "turquoise4",
                                "hotpink", "violetred2","violetred4", "darkgreen")) +
  scale_shape_manual(values = c(8, 20))+
  theme_minimal() +
  coord_sf(xlim = c(-110, -102), ylim = c(37, 42)) 

map_no.raster


#### site pairs only ####
co_map1 <- ggplot(data=state, mapping=aes(x=long, y=lat, group=group)) + 
#  geom_raster(data = dem.raster, aes(lon, lat, fill = alt), alpha = .45)+
#  coord_fixed(1.3) + 
#  geom_sf(fill="gray90") +  #requires shapefile
  geom_polygon(color="gray", fill="white") + 
  #geom_polygon(data=counties, fill=NA, color="lightgray") + 
  theme_bw()+
  labs(x="long", y="lat")+
  #theme(axis.text.x=element_blank(), axis.ticks.x=element_blank(),
   #    axis.text.y=element_blank(), axis.ticks.y=element_blank())+
  # annotation_north_arrow(location = "bl", which_north = "true", 
  #                        pad_x = unit(0.75, "in"), pad_y = unit(0.5, "in"),
  #                       style = north_arrow_fancy_orienteering)+
  geom_point(data=CDT, aes(x=long, y=lat, group=NULL), color="gray60", size=.01, alpha=.1)+
  geom_point(data=sites, aes(x=x, y=y, group=pair, color=pair, shape=elevation), size=2.7, alpha=.9) +
  geom_text(hjust=-.3, vjust=.5, data=sites, aes(x=x, y=y, label=name, group=elevation), size=3) +
  scale_color_manual(values=c("royalblue1", "royalblue2", "royalblue3", "royalblue4", "salmon 1", "salmon 2", "salmon3", "steelblue"))+
  coord_sf(xlim = c(-110, -102), ylim = c(37, 42))+
  annotate("text", x=-103.5, y=37.5, size=5, label= "Colorado")+
  scale_shape_manual(values=c(17, 15))

co_map1

#### sites grouped by elevation ####

co_map2 <- ggplot(data=state, mapping=aes(x=long, y=lat, group=group)) + 
  #  geom_raster(data = dem.raster, aes(lon, lat, fill = alt), alpha = .45)+
  #  coord_fixed(1.3) + 
  #  geom_sf(fill="gray90") +  #requires shapefile
  geom_polygon(color="gray", fill="white") + 
  #geom_polygon(data=counties, fill=NA, color="lightgray") + 
  theme_bw()+
  labs(x="long", y="lat")+
  #theme(axis.text.x=element_blank(), axis.ticks.x=element_blank(),
  #    axis.text.y=element_blank(), axis.ticks.y=element_blank())+
  #annotation_north_arrow(location = "bl", which_north = "true", 
  #    pad_x = unit(0.75, "in"), pad_y = unit(0.5, "in"),
  #  style = north_arrow_fancy_orienteering)
  geom_point(data=CDT, aes(x=long, y=lat, group=NULL), color="gray60", size=.01, alpha=.1)+
  geom_point(data=sites, aes(x=x, y=y, group=elevation, color=elevation), shape=17, size=2.7, alpha=.9) +
  geom_text(hjust=-.3, vjust=.5, data=sites, aes(x=x, y=y, label=name, group=elevation), size=3) +
  scale_color_manual(values=c("dodgerblue", "goldenrod"))+
  coord_sf(xlim = c(-110, -102), ylim = c(37, 42))+
  annotate("text", x=-103.5, y=37.5, size=5, label= "Colorado")

co_map2


 #### all individuals ####

waypts <- read.csv("waypoints-all.csv")

# all individuals
co_map3 <- ggplot(data=waypts, mapping=aes(x=long, y=lat, group=group)) + 
  coord_fixed(1.3) + 
  geom_polygon(color="black", fill="gray80") + 
  geom_polygon(data=co_county, fill=NA, color="white") + 
  geom_polygon(color="gray60", fill=NA) + 
  theme_minimal()+
  labs(x="long", y="lat")+
  geom_point(data=CDT, aes(x=long, y=lat, group=NULL), color="indianred", size=.00001)+
  geom_point(data=waypts, aes(x=x, y=y, group=elevation, color=elevation), shape=17, size=2) +
  geom_text(hjust=-.5, vjust=.5, data=waypts, aes(x=x, y=y, label=name, group=elevation), size=1.5) +
  scale_color_manual(values=c("dodgerblue", "goldenrod"))+
  ylim(36.8, 41.2)+
  xlim(-109.2, -101.4)#+
  #annotate("text", x=-106.2, y=37.8, size=2.5, label= "Continental Divide")

co_map3



######## expected results figures #########
sites.fig <- read.csv("sites.csv")

exp1 <- ggplot(data=sites.fig, mapping=aes(x=exp.x1, y=exp.y1, group=elevation)) + 
  geom_point(aes(color=pair), shape=17, size=4) +
  geom_text(hjust=-.5, vjust=.5, data=sites.fig, aes(label=name), size=3) +
  #scale_color_manual(values=c("dodgerblue", "goldenrod"))+
  theme_minimal() +
  theme(axis.text.x=element_blank(), axis.ticks.x=element_blank(),
         axis.text.y=element_blank(), axis.ticks.y=element_blank())+
  ylim(0,70)+
  xlim(0,70)+
  labs(x="PC1", y="PC2")

exp1 

sites.fig <- read.csv("sites.csv")

exp2 <- ggplot(data=sites.fig, mapping=aes(x=exp.x2, y=exp.y2, group=elevation)) + 
  geom_point(aes(color=elevation), shape=17, size=4) +
  geom_text(hjust=-.5, vjust=.5, data=sites.fig, aes(label=name), size=3) +
  scale_color_manual(values=c("dodgerblue", "goldenrod"))+
  theme_minimal()+
  theme(axis.text.x=element_blank(), axis.ticks.x=element_blank(),
        axis.text.y=element_blank(), axis.ticks.y=element_blank())+
  xlim(0, 30)+
  ylim(20, 60)+
  labs(x="PC1", y="PC2")

exp2

exp3 <- ggplot(data=sites.fig, mapping=aes(x=exp.x3, y=exp.y3, group=include)) + 
  geom_point(aes(color=include), shape=17, size=4) +
  geom_text(hjust=-.5, vjust=.5, data=sites.fig, aes(label=name), size=3) +
  scale_color_manual(values="gray")+
  theme_minimal()+
  theme(axis.text.x=element_blank(), axis.ticks.x=element_blank(),
        axis.text.y=element_blank(), axis.ticks.y=element_blank())+
  xlim(0, 100)+
  ylim(0, 100)+
  labs(x="PC1", y="PC2")

exp3

IBD <- read.csv("IBD.csv")
exp4 <- ggplot(data=IBD, mapping=aes(x=dist, y=Fst)) + 
  geom_point(shape=21, size=3, fill="red") +
  geom_smooth(se=FALSE, color="black", method="lm")+
 # scale_fill_manual(values=c("red", "orange", "yellow"))+
  theme_minimal()+
  theme(axis.text.x=element_blank(), axis.ticks.x=element_blank(),
        axis.text.y=element_blank(), axis.ticks.y=element_blank())+
  labs(x="elevation or distance", y="genetic distance")

exp4

ggarrange(exp1, exp2, exp4, nrow=3)


######### Pollard walk figure #########

setwd("/Users/lilydurkee/OneDrive - Colostate/Grad School/R-Projects-Grad/Colias")
field_data1 <- read.csv("Colias-field-data-summer22.csv")
field_data <- field_data1 %>% filter(scudderi == 0 & alexandra == 0) %>%
  group_by(site_ID, elevation) %>%
  summarize(colias_num = mean(colias_num))

field1 <- lm(colias_num ~ elevation, data=field_data)
summary(field1)

model1_data <- data.frame(summary(emmeans(field1, ~ elevation)))
emmeans(field1, pairwise ~ elevation)

ggplot() + 
  geom_jitter(data=field_data, mapping=aes(x=elevation, y=colias_num, color=elevation), 
              width=.1, size=3, alpha=.5) +
  geom_pointrange(data=model1_data, aes(x=elevation, y=emmean, ymin=lower.CL, ymax=upper.CL, color=elevation),
                  size=1)+
  labs(x="elevation", y="Colias count")+
  theme_classic()+
  #scale_fill_manual(values=c("blue", "yellow"))+
  scale_color_manual(values=c("dodgerblue", "goldenrod"))



