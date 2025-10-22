#!/bin/bash

#### script to launch Slim simulations on Slurm cluster for a sampling size of N=30 individuals
### see associated Slim parameter file Slim_2_pops_panm_RAD.txt

################################ Slurm options #################################

### Job name
#SBATCH --job-name=slim30

### Limit run time "days-hours:minutes:seconds"
#SBATCH --time=120:00:00

### Requirements
#SBATCH --partition=long
#SBATCH --ntasks=30
#SBATCH --cpus-per-task=1
#SBATCH --mem=128GB
#SBATCH --account=speciation_temperate_gorgonians

### Email
#SBATCH --mail-user=didier.aurelle@univ-amu.fr
#SBATCH --mail-type=ALL

### Output
#SBATCH --output=/shared/home/daurelle/slim30-%j.out

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

module load slim/3.5

module load vcftools/0.1.16

# Slim simulations two populations, RAD sequencing


cd /shared/home/daurelle/projet_specation_temperate_gorgonians/Slim

###### sample sizes N30

mkdir N30_20000_locus_20000gen
cd N30_20000_locus_20000gen

for i in {1..30}
do
	seed=$RANDOM
	echo "starting Slim N30 with seed"$i  $seed$i	
	slim -d seed=$seed -d nbLocus=20000 -d Np1=30 -d Np2=30 -m ../Slim_2_pops_panm_RAD.txt > out_RAD_2pops_N30_$i.txt &
	pids[${i}]=$!
done

# wait for all pids
for pid in ${pids[*]}; do
    wait $pid
done


for i in {1..30}
do
	cp out_RAD_2pops_N30_$i.txt RAD_2pops_N30_$i.vcf
	sed -i '/[#|]/!d' RAD_2pops_N30_$i.vcf # enlève toutes les lignes sauf celles avec dièse et pipe
	sed -i -r '/OUT/d' RAD_2pops_N30_$i.vcf # enlève la ligne avec out
	vcftools --vcf RAD_2pops_N30_$i.vcf --thin 100 --recode --out RAD_2pops_N30_thin_$i
	mv RAD_2pops_N30_thin_$i.recode.vcf RAD_2pops_N30_thin_$i.vcf
done

echo "end replicates sample size 30"

cd ..



module purge

