# This script aggregates all end-motif frequencies generated, calculates f-profiles and then 
# aggregates into a single matrix
#
# Written by Sami Ul Haq, May 1, 2024

library(nnls)
setwd("C:/Users/Sami/OneDrive - UHN/cfMeDIP/data/MeDIP/End Motifs Fragmentomics Analysis/Sami's custom end motif analyzer code/")
source("fragmentomics.utilities.R")

all.files <- Sys.glob("../code output/*.txt")

# reference F table read (source: https://pubmed.ncbi.nlm.nih.gov/37075072/)
ref.ftable <- read.csv("ftableref.csv")
rownames(ref.ftable) <- ref.ftable[,1]
ref.ftable <- ref.ftable[ , -c(1) ]
ref.ftable <- as.matrix(ref.ftable)


kmer_length <- 4
all_4mers <- generate_kmer_permutations(kmer_length)


holder.df <- matrix(0, nrow=length(all_4mers))
rownames(holder.df) <- all_4mers


for(eacho in all.files) {
  temp.file <- read.table(eacho)
  tempo.data <- temp.file$V1[match(rownames(holder.df), temp.file$V2)]
  
  holder.df <- cbind(holder.df, tempo.data)
  
  rm(tempo.data)
  rm(temp.file)
}

holder.df <- holder.df[,-c(1)]
colnames(holder.df) <- all.files

# frequency of each motif is calculated
holder.df <- apply(holder.df, MARGIN=2, FUN=function(x){
  return(x / sum(x)) * 100
})

# Calculate F-profiles per sample
f_profiles_per_sample <- calculate_f_profiles_per_sample(holder.df, ref.ftable)
rownames(f_profiles_per_sample) <- paste0("F-profile ", c(1:6))

save(f_profiles_per_sample, file="fprofiles_per_sample.RData")

