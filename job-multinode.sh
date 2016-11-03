#!/bin/bash
# Job name:
#SBATCH --job-name=test
#
# Account:
#SBATCH --account=co_stat
#
# Partition:
#SBATCH --partition=savio2
#
# Number of MPI tasks needed for use case (example):
#SBATCH --ntasks=48
#
# Processors per task:
#SBATCH --cpus-per-task=1
#
# Wall clock limit (15 minutes here):
#SBATCH --time=00:15:00
#
## Command(s) to run:
module load gcc openmpi r 
module load Rmpi
mpirun R CMD BATCH --no-save foreach-multinode-doMPI.R foreach-multinode-doMPI.Rout

