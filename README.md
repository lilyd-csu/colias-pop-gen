# Examining local adaptation in the clouded sulfur butterfly

Lead author: Lily Durkee

Co-authors: Christen Bossu, Kristen Ruegg, and Ruth Hufbauer



## Background
The loss of biodiversity due to climate change and human activity is a central issue in conservation (Harvey et al., 2023). Insect populations in particular have declined sharply in recent years, and this so-called “insect apocalypse” poses threats to ecosystem function, for example declines in pollination services and nutrient cycling (Wagner et al., 2021). Habitat fragmentation, pesticide use, and warming temperatures pose severe threats to insect populations globally, and the question arises of whether or not insect species can adapt to these rapidly changing conditions (Webster et al., 2023). 

Spatial and geographic gradients can serve as a way to study adaptation to different habitats at a single point in time (Reusch & Wood, 2007). Latitudinal gradients can be used to assess adaptation to varying environmental conditions, for example during range expansions (Clark et al., 2022), and elevation gradients provide a way to study a species across a range of environmental conditions within relatively small spatial scales, as temperature tends to decrease as elevation increases (Branch et al., 2017; Keller et al., 2013). Population differences have also been observed due to dispersal barriers (Manel & Holderegger, 2013), for example on either side of mountain ranges or among fragmented habitat patches. 

Adaptation to the local habitat that results in reduced fitness in other habitats (i.e., local adaptation) may occur in response to the unique selection pressures present at different geographic locations (Kawecki & Ebert, 2004). To contrast, if habitat connectivity is high, gene flow can slow or prevent the evolution of local adaptation while also maintaining high genetic diversity (Kardos et al., 2021). When the interaction of local adaptation and gene flow result in allele frequencies that differ among populations (i.e., populations that are genetically distinct), this can be described as population genetic structure (Holsinger & Weir, 2009). With the increased affordability of next-generation sequencing techniques, population genetic methods can now be applied to non-model organisms (Lou et al., 2021). Here, we will use genomics to investigate the population genetic structure of a montane butterfly species. 

Butterflies, like other insect taxa, are declining worldwide (Warren et al., 2021). Butterflies provide pollination services (Ezzeddine & Matter, 2008) and are an important source of food for higher trophic levels (Warren et al., 2021; Webster et al., 2023). Our study focuses on the Rocky Mountain subspecies of the clouded sulfur (Colias philodice eriphyle Edwards) (Lepidoptera: Pieridae). Clouded sulfurs feeds on legumes (Fabaceae) such as clover (*Trifolium spp*.) and vetch (*Vicia spp.*) as larvae, and populations can be found on alfalfa (*Medicago sativa*) (Tabashnik, 1983). The species occupies a wide range of elevations, from alfalfa fields and grasslands in the Colorado foothills to subalpine meadows up to 3000m in elevation (Tabashnik, 1980). In addition, its maximum flight distances are around 500m (Watt et al., 1979). Thus, this species is suitable for examining adaptation to local environments present among different elevations (Buckley & Kingsolver, 2019) and geographic position within a small geographic range. Past studies have examined phenotypic differences between high- and low-elevation populations, which include increased dorsal melanization (black scales) at high elevations, which may slow heat loss during flight and increase heat (Ellers & Boggs, 2002, 2004), and populations in alfalfa fields have been observed to disperse less than those in natural environments (Tabashnik, 1980). Here, I investigate local adaptation pof *C. p. eriphyle* to elevation and associated bioclimatic variables using whole genome sequencing.




## Methods

*Field collection*

In June through August 2022, we collected *C. p. eriphyle* butterflies from seven low and seven high elevation sites on both sides of the continental divide in Colorado and southern Wyoming (Figure 1). Low elevation sites will hereafter refer to those less than 2000m in elevation, and high elevation sites are those greater than 2000m in elevation. Sites were paired geographically, with one high and one low site identified that were geographically closer together than they were to other sites. All high-low site pairs had a difference in elevation of at least 1000m. Up to 20 individuals were collected per site with mesh butterfly nets. We assessed the abundance of *Colias* species at each site using Pollard walks and measured temperature and wind speed. If Colias abundance was zero, the temperature was too low (less than 20C), or the wind speeds were too high (consistent gusts of > 20kph), collection did not occur at the site that day. Successful field excursions resulted in at least five individuals netted and then placed in a glassine envelope. All collected individuals were transported to Colorado State University and were frozen alive or within 48hr of death in -80°C. Permission to collect individuals was obtained from the relevant agency (US National Park Service permit no. ROMO-00257, US Forest Service, City of Fort Collins, or private landowners) prior to the field season. 

![Colias-map-project-final](https://github.com/lilyd-csu/colias-pop-gen/assets/112984536/5ac5af10-4f63-457a-b65b-3e9e3ec0981b)
**Figure 1.** A map of the individuals collected at the 14 collection sites throughout Colorado. 

\
*Sample preparation and sequencing*

We extracted DNA from the thorax of up to 20 individuals per site using Qiagen DNeasy Blood and Tissue Kits. We assessed DNA yield using qbit assays and determined the quality of each sample using agarose gels. Library prep was completed following Schweizer & DeSaix (2023) on up to 12 of the highest quality samples per site. We sequenced 179 individuals total on three lanes of Novogene HiSeq 4000. 

*Bioinformatics*

All samples were trimmed using TRIMMOMATIC and downsampled to 4x coverage (Lou & Therkildsen, 2022). Related individuals were identified using NGSRelate and removed from the dataset. We then mapped each individual to the clouded yellow butterfly (*Colias crocea*) reference genome (Ebdon et al., 2022). We used a standard GATK workflow with imputation using `beagle` to create a VCF file. To look for associations between loci and environment, we used a redundancy analysis to identify single nucleotide polymorphisms (SNPs) associated with elevation and associated bioclimatic variables (Forester et al., 2018). The one site in Wyoming was removed because it did not have individual GPS coordinates.




## Results

*VCF file exploration*

The *C. p. eriphyle* genome consists of 31 scaffolds, and 1.4 million SNPs. A summary of the scaffolds and the number of variants associated with each is below.

| Scaffold   | No. Variants |
|------------|--------------|
| NC_059537.1| 72292        |
| NC_059540.1| 70942        |
| NC_059539.1| 69371        |
| NC_059538.1| 65905        |
| NC_059542.1| 64651        |
| NC_059544.1| 62968        |
| NC_059543.1| 62584        |
| NC_059541.1| 61237        |
| NC_059549.1| 58357        |
| NC_059546.1| 56426        |
| NC_059547.1| 55839        |
| NC_059548.1| 55125        |
| NC_059545.1| 54383        |
| NC_059554.1| 53273        |
| NC_059550.1| 51810        |
| NC_059551.1| 50650        |
| NC_059553.1| 50387        |
| NC_059568.1| 49619        |
| NC_059552.1| 49409        |
| NC_059556.1| 44004        |
| NC_059555.1| 42853        |
| NC_059557.1| 40060        |
| NC_059558.1| 32275        |
| NC_059562.1| 30572        |
| NC_059560.1| 29078        |
| NC_059561.1| 27468        |
| NC_059563.1| 23532        |
| NC_059559.1| 21640        |
| NC_059564.1| 19603        |
| NC_059565.1| 14213        |
| NC_059566.1| 14098        |


[Click here](VCF-file-exploration.txt) to view the full exploration of my VCF file.

\
*Redundancy Analysis*

I extracted variables from raster files from WorldClim 2 (data from 1970-2000) using the GPS coordinates of where each individual was collected during the collection season, June-August. I extracted values for each variable for each month, and then averaged over those three values. I used four bioclim variables:

* Maximum temperature (`tmax`)
* Precipitation (`precip`)
* Wind speed (`wind`)
* Solar radiation (`srad`)

I then extracted an elevation value for each butterfly using the package `elevatr`. This package uses data from the Amazon Web Services Terrain Tiles and the USGS Elevation Point Query Service. I examined the correlation between these five variables using the `psych` package (Figure 2). 

![colias_bioclim corr_all](https://github.com/lilyd-csu/colias-pop-gen/assets/112984536/5cdba729-a7a9-4703-be1b-010f8547e5aa)

**Figure 2.** The correlations and distributions of each of the five bioclimatic variables. 

\
Because `wind` was highly correlated (r > |0.8|) with `srad` and `precip`, I removed `wind`. I also removed `tmax` which was highly correlated with `elevation`. I proceeded with the analysis using the following variables: `elevation`, `precip`, and `srad`. The plot below illustrates the strength of the correlation with each population (color coded by site) with the bioclimatic variables (blue arrows). The clustering of the points indicates the population structure driven by differences in the environment. 

![Colias_RDA_attempt1-axis1 2](https://github.com/lilyd-csu/colias-pop-gen/assets/112984536/c0f59360-2878-4446-9b82-15241361d323)
**Figure 3.** Preliminary redundancy analysis. The gray cloud in the center represent the 100k SNPs used in this analysis, and the blue arrows represent the axes corresponding with each environmental variable. 

\
To see the code that generated this plot and an investigation of the SNPs correlated with environmental variables, please see the [file here](RDA-project.pdf).
*(Note: the RDA figures do not look great on the Rmd file.)*

## Discussion & Future Directions

Here, I present preliminary evidence that populations of the clouded sulfur butterly may be locally adapted to micro-climatic differences in Colorado, which is influenced by topography. Additionally, principal component analyses have shown that there is some population structure present, likely driven by the presence of the continental divide (see below).

![PCA-east-west](https://github.com/lilyd-csu/colias-pop-gen/assets/112984536/8b143d58-7a46-48e7-9b30-7a8b96e55c22)

With this in mind, two high elevation sites west of the divide, Babbit Gulch (darker blue) and Kepler Pass (pink), both seem highly correlated with elevation, while two sites east of the divide, High Trails Ranch (brown) and moreso Fountain Valley (red), are associated with both higher solar radiation and precipitation. Lastly, the three sites Soapstone Prairie, Spring Canyon Park, and Loukonen Farm are all low-elevation populations located east of the divide, and appear to be associated with lower solar radiation. 

Moving forward, I would like to identify a greater number of SNPs associated with these environmental variables. To do this, I could lower the threshold for the frequency of SNPs, and also run the RDA on the full SNP dataset. 


## References

Branch, C. L., Jahner, J. P., Kozlovsky, D. Y., Parchman, T. L., & Pravosudov, V. v. (2017). Absence of population structure across elevational gradients despite large phenotypic variation in mountain chickadees (Poecile gambeli). Royal Society Open Science, 4(3). https://doi.org/10.1098/rsos.170057

Buckley, L. B., & Kingsolver, J. G. (2019). Environmental variability shapes evolution, plasticity and biogeographic responses to climate change. Global Ecology and Biogeography, 28(10), 1456–1468. https://doi.org/10.1111/geb.12953

Cho, S., Epstein, S. W., Mitter, K., Hamilton, C. A., Plotkin, D., Mitter, C., & Kawahara, A. Y. (2016). Preserving and vouchering butterflies and moths for large-scale museum-based molecular research. PeerJ, 2016(6), 1–11. https://doi.org/10.7717/peerj.2160

Clark, E. I., Bitume, E. V., Bean, D. W., Stahlke, A. R., Hohenlohe, P. A., & Hufbauer, R. A. (2022). Evolution of reproductive life-history and dispersal traits during the range expansion of a biological control agent. Evolutionary Applications, 15(12), 2089–2099. https://doi.org/10.1111/eva.13502

Ebdon, S., Mackintosh, A., Hayward, A., & Wotton, K. (2022). The genome sequence of the clouded yellow, Colias crocea (Geoffroy, 1785). Open Research, 1–12.

Ellers, J., & Boggs, C. L. (2002). The evolution of wing color in Colias butterflies: Heritability, sex linkage, and population divergence. Evolution, 56(4), 836–840. https://doi.org/10.1111/j.0014-3820.2002.tb01394.x

Ellers, J., & Boggs, C. L. (2004). Evolutionary genetics of dorsal wing colour in Colias butterflies. Journal of Evolutionary Biology, 17(4), 752–758. https://doi.org/10.1111/j.1420-9101.2004.00736.x 

Ezzeddine, M., & Matter, S. F. (2008). Nectar flower use and electivity by butterflies in sub-alpine meadows. Journal of the Lepidopterists’ Society, 62(3), 138–142.

Gompert, Z., Lucas, L. K., Buerkle, C. A., Forister, M. L., Fordyce, J. A., & Nice, C. C. (2014). Admixture and the organization of genetic diversity in a butterfly species complex revealed through common and rare genetic variants. Molecular Ecology, 23(18), 4555–4573. https://doi.org/10.1111/mec.12811

Harvey, J. A., Tougeron, K., Gols, R., Heinen, R., Abarca, M., Abram, P. K., Basset, Y., Berg, M., Boggs, C., Brodeur, J., Cardoso, P., de Boer, J. G., De Snoo, G. R., Deacon, C., Dell, J. E., Desneux, N., Dillon, M. E., Duffy, G. A., Dyer, L. A., … Chown, S. L. (2023). Scientists’ warning on climate change and insects. Ecological Monographs, 93(1), 1–37. https://doi.org/10.1002/ecm.1553

Holsinger, K. E., & Weir, B. S. (2009). Genetics in geographically structured populations: Defining, estimating and interpreting FST. Nature Reviews Genetics, 10(9), 639–650. https://doi.org/10.1038/nrg2611

Kardos, M., Armstrong, E., Fitzpatrick, S., Hauser, S., Hedrick, P., Miller, J., Tallmon, D. A., & Funk, W. C. (2021). The crucial role of genome-wide genetic variation in conservation. BioRxiv, 118(48), 2021.07.05.451163. https://doi.org/10.1073/pnas.2104642118/-/DCSupplemental.Published

Kawecki, T. J., & Ebert, D. (2004). Conceptual issues in local adaptation. Ecology Letters, 7(12), 1225–1241. https://doi.org/10.1111/j.1461-0248.2004.00684.x

Keller, I., Alexander, J. M., Holderegger, R., & Edwards, P. J. (2013). Widespread phenotypic and genetic divergence along altitudinal gradients in animals. Journal of Evolutionary Biology, 26(12), 2527–2543. https://doi.org/10.1111/jeb.12255

Lou, R. N., Jacobs, A., Wilder, A. P., & Therkildsen, N. O. (2021). A beginner’s guide to low-coverage whole genome sequencing for population genomics. Molecular Ecology, 30(23), 5966–5993. https://doi.org/10.1111/mec.16077

Lou, R. N., & Therkildsen, N. O. (2022). Batch effects in population genomic studies with low-coverage whole genome sequencing data: Causes, detection and mitigation. Molecular Ecology Resources, 22(5), 1678–1692. https://doi.org/10.1111/1755-0998.13559

Manel, S., & Holderegger, R. (2013). Ten years of landscape genetics. Trends in Ecology and Evolution, 28(10), 614–621. https://doi.org/10.1016/j.tree.2013.05.012

Mikheyev, A. S., McBride, C. S., Mueller, U. G., Parmesan, C., Smee, M. R., Stefanescu, C., Wee, B., & Singer, M. C. (2013). Host-associated genomic differentiation in congeneric butterflies: Now you see it, now you do not. Molecular Ecology, 22(18), 4753–4766. https://doi.org/10.1111/mec.12423

Reusch, T. B. H., & Wood, T. E. (2007). Molecular ecology of global change. Molecular Ecology, 16(19), 3973–3992. https://doi.org/10.1111/j.1365-294X.2007.03454.x

Ruegg, K. C., Bay, R. A., Anderson, E. C., Saracco, J. F., Harrigan, R. J., Whitfield, M., Paxton, E. H., & Smith, T. B. (2018). Ecological genomics predicts climate vulnerability in an endangered southwestern songbird. Ecology Letters, 21(7), 1085–1096. https://doi.org/10.1111/ele.12977

Schweizer, T. M., & DeSaix, M. G. (2023). Cost-effective library preparation for whole genome sequencing with feather DNA. Conservation Genetics Resources, 15(1–2), 21–28. https://doi.org/10.1007/s12686-023-01299-2

Sorojsrisom, E. S., Krumm, J. L., & Trillo, P. A. (2022). Measuring size and area of digitized specimens using ImageJ. QUBES Educational Resources. https://doi.org/0.25334/P8QG-AB71

Tabashnik, B. E. (1980). Population Structure of Pierid Butterflies. III. Pest Populations of Colias philodice eriphyle. Oecologia, 47(2), 175–183.

Tabashnik, B. E. (1983). Host range evolution. The shift from native legume hosts to alfalfa by the butterfly, Colias philodice eriphyle (Medicago sativa). Evolution, 37(1), 150–162. 
https://doi.org/10.1111/j.1558-5646.1983.tb05523.x

Trense, D., Schmidt, T. L., Yang, Q., Chung, J., Hoffmann, A. A., & Fischer, K. (2021). Anthropogenic and natural barriers affect genetic connectivity in an Alpine butterfly. Molecular Ecology, 30(1), 114–130. https://doi.org/10.1111/mec.15707

Wagner, D. L., Grames, E. M., Forister, M. L., Berenbaum, M. R., & Stopak, D. (2021). Insect decline in the Anthropocene: Death by a thousand cuts. Proceedings of the National Academy of Sciences of the United States of America, 118(2), 1–10. https://doi.org/10.1073/PNAS.2023989118

Warren, M. S., Maes, D., van Swaay, C. A. M., Goffart, P., van Dyck, H., Bourn, N. A. D., Wynhoff, I., Hoare, D., & Ellis, S. (2021). The decline of butterflies in Europe: Problems, significance, and possible solutions. Proceedings of the National Academy of Sciences of the United States of America, 118(2), 1–10. https://doi.org/10.1073/PNAS.2002551117

Watt, W. B., Han, D., & Tabashnik, B. E. (1979). A “Native” population of Colias philodice eriphyle in Colorado. Oecologia, 44(1), 44–52. https://doi.org/10.1007/BF00346396

Webster, M. T., Beaurepaire, A., Neumann, P., & Stolle, E. (2023). Population Genomics for Insect Conservation. Annual Review of Animal Biosciences, 11, 115–140. https://doi.org/10.1146/annurev-animal-122221-075025



