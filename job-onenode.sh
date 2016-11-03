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
# Number of nodes:
#SBATCH --nodes=1
#
# Wall clock limit (15 minutes here):
#SBATCH --time=00:15:00
#
## Command(s) to run:
module load r
R CMD BATCH --no-save mclapply.R mclapply.Rout
