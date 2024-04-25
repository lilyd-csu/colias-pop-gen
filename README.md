## Project Description
#### Lily Durkee
#### BZ562, Spring 2024


I have data from 165 clouded sulfur butterflies (Colias philodice eriphyle) from paired high- and low-elevation sites, both east and west of the continental divide, around Colorado and southern Wyoming (15 sites total; see attached map). In the field, I took GPS points for every collected individual and collected weather data (temperature and wind speed). I sequenced the individuals using three lanes HiSeq, which yielded an average coverage of around 5x with a fair amount of variation, so I down sampled to 4X. I processed the data using both genotype likelihoods using ANGSD and called genotypes with GATK, which both yielded similar population structure using PCA. So, I will proceed with my filtered and merged VCF file for future analyses.

* Understanding my VCF file using bcftools
* Convert my VCF file to a beagle file for analyses in ANGSD 
* Isolation by distance analysis using Fst values generated between all site pairs (I may still use vcftools for the Fst values)
* Identify loci potentially under selection using outlier Fst values and the annotated reference genome of a congener (clouded yellow butterfly, Colias crocea)
* Attempt a redundancy analysis using Brenna's tutorial as a guide: https://popgen.nescent.org/2018-03-27_RDA_GEA.html. I will use my GPS coordinates of collection sites to find elevation and climate data relevant to each site, along with the weather data collected in the field, to use in the RDA.
