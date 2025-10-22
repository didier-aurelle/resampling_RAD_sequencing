#!/bin/bash

################################ Slurm options #################################

### Job name
#SBATCH --job-name=RAD_resampling

### Limit run time "days-hours:minutes:seconds"
#SBATCH --time=1:00:00

### Requirements
#SBATCH --partition=fast
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --mem-per-cpu=12GB
#SBATCH --account=gfcm_redcoral2024_up

### Email
#SBATCH --mail-user=didier.aurelle@univ-amu.fr
#SBATCH --mail-type=ALL

### Output
#SBATCH --output=/shared/home/daurelle/RAD_resampling-%j.out

################################################################################

echo '########################################'
echo 'Date:' $(date --iso-8601=seconds)
echo 'User:' $USER
echo 'Host:' $HOSTNAME
echo 'Job Name:' $SLURM_JOB_NAME
echo 'Job Id:' $SLURM_JOB_ID
echo 'Directory:' $(pwd)
echo '########################################'


# modules loading

module load vcftools/0.1.16
module load r/4.4.1


cd /shared/home/daurelle/GFCM_redcoral/RAD_resampling



# first creation of the file for resampling

vcftools --vcf MGX2_branch.0.75_0.75.0.01_3.HWE_woreplicates.recode.vcf --keep list_Corallium_resampling.txt --recode --out RAD_Corallium_resampling.vcf
mv RAD_Corallium_resampling.vcf.recode.vcf RAD_resampling/RAD_Corallium_resampling.vcf

# analysis of genetic diversity and structure with hierfstat in R, initial dataset


# Rscript hierfstat_IFB_initial.R

##########
# Resampling with different sample sizes, GFCM data set, from N = 20 to N = 5

# 30 random samples of a file; N = 20 per site
mkdir N20
cd N20
	for i in {1..30}
	
	do
	cp /shared/home/daurelle/GFCM_redcoral/RAD_resampling/list_*.txt ./
	shuf -n 20 list_Kablinac.txt > Kablinac_shuf20_$i
	shuf -n 20 list_NWAegean.txt > NWAegean_shuf20_$i
	shuf -n 20 list_Palamos.txt > Palamos_shuf20_$i
	shuf -n 20 list_CorsicaC.txt > CorsicaC_shuf20_$i
	shuf -n 20 list_StRaphael.txt > StRaphael_shuf20_$i
	
	vcftools --vcf /shared/home/daurelle/GFCM_redcoral/RAD_resampling/RAD_Corallium_resampling.vcf --keep Kablinac_shuf20_$i --keep NWAegean_shuf20_$i --keep Palamos_shuf20_$i --keep CorsicaC_shuf20_$i --keep StRaphael_shuf20_$i --recode --out total_resampling_shuf20_$i
	mv total_resampling_shuf20_$i.recode.vcf total_resampling_shuf20_$i.vcf
	vcftools --vcf /shared/home/daurelle/GFCM_redcoral/RAD_resampling/RAD_Corallium_resampling.vcf --weir-fst-pop Kablinac_shuf20_$i --weir-fst-pop NWAegean_shuf20_$i --weir-fst-pop Palamos_shuf20_$i --weir-fst-pop CorsicaC_shuf20_$i --weir-fst-pop StRaphael_shuf20_$i --out pairwise_Fst_shuf20_$i
	rm list_*.txt
	done

cd ..

## 30 random samples of a file; N = 15 per site

mkdir N15
cd N15
	for i in {1..30}
	
	do
	cp /shared/home/daurelle/GFCM_redcoral/RAD_resampling/list_*.txt ./
	shuf -n 15 list_Kablinac.txt > Kablinac_shuf15_$i
	shuf -n 15 list_NWAegean.txt > NWAegean_shuf15_$i
	shuf -n 15 list_Palamos.txt > Palamos_shuf15_$i
	shuf -n 15 list_CorsicaC.txt > CorsicaC_shuf15_$i
	shuf -n 15 list_StRaphael.txt > StRaphael_shuf15_$i
	
	vcftools --vcf /shared/home/daurelle/GFCM_redcoral/RAD_resampling/RAD_Corallium_resampling.vcf --keep Kablinac_shuf15_$i --keep NWAegean_shuf15_$i --keep Palamos_shuf15_$i --keep CorsicaC_shuf15_$i --keep StRaphael_shuf15_$i --recode --out total_resampling_shuf15_$i
	mv total_resampling_shuf15_$i.recode.vcf total_resampling_shuf15_$i.vcf
	vcftools --vcf /shared/home/daurelle/GFCM_redcoral/RAD_resampling/RAD_Corallium_resampling.vcf --weir-fst-pop Kablinac_shuf15_$i --weir-fst-pop NWAegean_shuf15_$i --weir-fst-pop Palamos_shuf15_$i --weir-fst-pop CorsicaC_shuf15_$i --weir-fst-pop StRaphael_shuf15_$i --out pairwise_Fst_shuf15_$i
	rm list_*.txt
	done

cd ..

## 30 random samples of a file; N = 10 per site

mkdir N10
cd N10
	for i in {1..30}
	
	do
	cp /shared/home/daurelle/GFCM_redcoral/RAD_resampling/list_*.txt ./
	shuf -n 10 list_Kablinac.txt > Kablinac_shuf10_$i
	shuf -n 10 list_NWAegean.txt > NWAegean_shuf10_$i
	shuf -n 10 list_Palamos.txt > Palamos_shuf10_$i
	shuf -n 10 list_CorsicaC.txt > CorsicaC_shuf10_$i
	shuf -n 10 list_StRaphael.txt > StRaphael_shuf10_$i
	
	vcftools --vcf /shared/home/daurelle/GFCM_redcoral/RAD_resampling/RAD_Corallium_resampling.vcf --keep Kablinac_shuf10_$i --keep NWAegean_shuf10_$i --keep Palamos_shuf10_$i --keep CorsicaC_shuf10_$i --keep StRaphael_shuf10_$i --recode --out total_resampling_shuf10_$i
	mv total_resampling_shuf10_$i.recode.vcf total_resampling_shuf10_$i.vcf
	vcftools --vcf /shared/home/daurelle/GFCM_redcoral/RAD_resampling/RAD_Corallium_resampling.vcf --weir-fst-pop Kablinac_shuf10_$i --weir-fst-pop NWAegean_shuf10_$i --weir-fst-pop Palamos_shuf10_$i --weir-fst-pop CorsicaC_shuf10_$i --weir-fst-pop StRaphael_shuf10_$i --out pairwise_Fst_shuf10_$i
	rm list_*.txt
	done

cd ..

## 30 random samples of a file; N = 5 per site

mkdir N5
cd N5
	for i in {1..30}
	
	do
	cp /shared/home/daurelle/GFCM_redcoral/RAD_resampling/list_*.txt ./
	shuf -n 5 list_Kablinac.txt > Kablinac_shuf5_$i
	shuf -n 5 list_NWAegean.txt > NWAegean_shuf5_$i
	shuf -n 5 list_Palamos.txt > Palamos_shuf5_$i
	shuf -n 5 list_CorsicaC.txt > CorsicaC_shuf5_$i
	shuf -n 5 list_StRaphael.txt > StRaphael_shuf5_$i
	
	vcftools --vcf /shared/home/daurelle/GFCM_redcoral/RAD_resampling/RAD_Corallium_resampling.vcf --keep Kablinac_shuf5_$i --keep NWAegean_shuf5_$i --keep Palamos_shuf5_$i --keep CorsicaC_shuf5_$i --keep StRaphael_shuf5_$i --recode --out total_resampling_shuf5_$i
	mv total_resampling_shuf5_$i.recode.vcf total_resampling_shuf5_$i.vcf
	vcftools --vcf /shared/home/daurelle/GFCM_redcoral/RAD_resampling/RAD_Corallium_resampling.vcf --weir-fst-pop Kablinac_shuf5_$i --weir-fst-pop NWAegean_shuf5_$i --weir-fst-pop Palamos_shuf5_$i --weir-fst-pop CorsicaC_shuf5_$i --weir-fst-pop StRaphael_shuf5_$i --out pairwise_Fst_shuf5_$i
	rm list_*.txt
	done

cd ..


module purge

echo '########################################'
echo 'Job RAD_resampling finished' $(date --iso-8601=seconds)
