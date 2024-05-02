# This script visualizes f-profils
#
# Written by Sami Ul Haq, May 2, 2024

library(ggplot2)
library(reshape2)

setwd("C:/Users/Sami/OneDrive - UHN/cfMeDIP/data/MeDIP/End Motifs Fragmentomics Analysis/Sami's custom end motif analyzer code/")
source("fragmentomics.utilities.R")

load("fprofiles_per_sample.RData")

f.df <- as.data.frame(f_profiles_per_sample)
f.df$profiles <- rownames(f.df)

booya <- melt(f.df, value.name = "contribution")

ggplot(booya, aes(fill=profiles, y=contribution, x=variable)) + 
  geom_bar(position="fill", stat="identity") +
  theme_bw() +
  theme(
    axis.text.x = element_blank()
  ) +
  xlab("Patient Sample")
