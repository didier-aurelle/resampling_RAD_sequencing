# red_coral_analyses

This repository includes the scripts used to analyse the impact of samling sizes of estimates of genetic diversity with RAD sequencing data. All estimates of genetic diversity and genetic differentiation have been performed on vcf files with the R package hierfstat (https://github.com/jgx65/hierfstat).
See the R script hierfstat_analyses.R. 

For resampling the original dataset see the script IFB_RAD_red_coral_resampling.sh.
To use this script you need a vcf file and separate lists of individuals per population in text format.

For simulations we used the Slim 3 software (https://messerlab.org/slim/) on the IFB computing cluster (https://www.france-bioinformatique.fr/en/ifb-core-cluster/). See the corresponding bash script Slim_2_pops_panm_RAD.txt and the parameter file Slim_2pops_RAD_IFB_N30.sh. 


## Authors and acknowledgment
Thanks to Eugénie Kreckelbergh for her help. I acknowledge the staff of the "Cluster de calcul intensif HPC" Platform of the OSU Institut
Pythéas (Aix-Marseille Université, INSU-CNRS) for providing the computing facilities. I gratefully acknowledge J. Lecubin and C. Yohia from the Service Informatique de Pythéas (SIP) for
technical assistance

## License

 impact of sampling sizes on analyses of red coral genomics © 2025 by Didier Aurelle is licensed under CC BY-NC-SA 4.0 

