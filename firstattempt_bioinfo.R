# first attempt at bioinformatics
# sept 19, 2023

#install.packages("viridis")
library(viridis)
library(tidyverse)

setwd("/Users/lilydurkee/OneDrive - Colostate/Grad School/R-Projects-Grad/Colias")

# use read_lines to read the R1 fastq file line by line;
# then make a 4 column matrix, filling by rows
# then drop column 3, which corresponds to the "+" line

R1 <- read_lines("AL4_CKDL230002369-1A_HJJGFCCX2_L5_1.fq.gz") %>%
  matrix(ncol = 4, byrow = TRUE) %>%
  .[,-3]

# add colnames
colnames(R1) <- c("ID", "seq", "qual")

# now make a tibble out that.  We will assign
# it back to the variable R1, to note carry
# extra memory around
R1 <- as_tibble(R1)

# Look at it:
R1

# first we break on the space,
# then we break the ID on the colons, but keep the original "id" for later
R1 %>%
  separate(ID, into = c("id", "part2"), sep = " ") %>%
  separate(
    id, 
    into = c("machine", "run", "flow_cell", "lane", "tile", "x", "y"), 
    sep = ":",
    remove = FALSE
  )

R1_sep <- R1 %>%
  separate(ID, into = c("id", "part2"), sep = " ") %>%
  separate(
    id, 
    into = c("machine", "run", "flow_cell", "lane", "tile", "x", "y"), 
    sep = ":",
    remove = FALSE
  ) 

# when you are done with that, look at it
R1_sep
