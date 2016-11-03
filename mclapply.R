source('loo.R')

library(parallel)

cores <- as.numeric(Sys.getenv('SLURM_CPUS_ON_NODE'))
cat("Using: ", cores, " cores.\n", sep = '')

# n is set to full size of dataset in loo.R, but:
# only do first 48 obs to reduce time in demo
n <- 48 
preds <- mclapply(seq_len(n), looFit, Y, X, TRUE, mc.cores = cores)

print(preds)
