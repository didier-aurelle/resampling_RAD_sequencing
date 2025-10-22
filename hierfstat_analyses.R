# analyse vcf files with hierfstat
# from https://www2.unil.ch/popgen/teaching/WISG17/import.pdf 


##### used on IFB core cluster

##### estimates of genetic diversity and differentiation with the R package hierfstats

#Packages setup (first time only)

# install.packages("devtools", lib = "/shared/home/daurelle/R/library/", repos='https://pbil.univ-lyon1.fr/CRAN/')
# library(devtools)
# install_github("jgx65/hierfstat", lib = "/shared/home/daurelle/R/library/", repos='https://pbil.univ-lyon1.fr/CRAN/')
# install.packages("adegenet", lib = "/shared/home/daurelle/R/library/", repos='https://pbil.univ-lyon1.fr/CRAN/')
# install.packages("pegas", lib = "/shared/home/daurelle/R/library/", repos='https://pbil.univ-lyon1.fr/CRAN/')


library(adegenet, lib.loc = "/shared/home/daurelle/R/library/")
library(hierfstat, lib.loc = "/shared/home/daurelle/R/library/")
library(pegas, lib.loc = "/shared/home/daurelle/R/library/")



setwd("/shared/ifbstor1/projects/gfcm_redcoral2024_up/")

# import population file: this should include the list of population code for all individuals

popsAll <-  read.table("population_file_MGX2_filter_RitaCannas.csv", header = TRUE)
popsAll <- as.factor(popsAll$POP)

# read vcf file and import populations

data <- read.vcf("all_rp_FILTERED_RitaCannas.vcf", from = 1, to = 30000)
data_genind <- loci2genind(data)
data_genind$pop <- popsAll
write.csv(pop(data_genind), "liste_pops_All_filerRC.csv")
liste_pops <- unique(data_genind$pop)
data_hierfstat <- genind2hierfstat(data_genind)

# analysis on all samples, per POPULATION

bs_stats <- basic.stats(data_hierfstat, diploid = TRUE)
stats_global <- t(data.frame(bs_stats$overall))
write.csv(stats_global, "basic_stats_RAD_all_filterRC.csv")

Fst_pair <- pairwise.WCfst(data_hierfstat, diploid=TRUE)
Fst_pair[is.na(Fst_pair)] <- 0
write.csv(Fst_pair, "pairwise_Fst_all_populations_filterRC.csv")

Hobs <- bs_stats$Ho
Hexp <- bs_stats$Hs
Fis <- bs_stats$Fis
Hobs_mean <- as.data.frame(colMeans(Hobs,  na.rm = TRUE))
Hexp_mean <- as.data.frame(colMeans(Hexp,  na.rm = TRUE))
Fis_mean <- as.data.frame(colMeans(Fis, na.rm = TRUE))
Pop_stats <- data.frame(Hobs_mean, Hexp_mean[,1], Fis_mean[,1])
colnames(Pop_stats) <- c("Hobs_mean", "Hexp_mean", "Fis_mean")
write.csv(Pop_stats, "Diversity_stats_per_population_filterRC.csv")

betas <- betas(data_hierfstat, diploid = TRUE)
betas_stats <- t(data.frame(betas$betaiovl))
write.csv(betas_stats, "pop_specific_Fst_filterRC.csv")