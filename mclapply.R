source('loo.R')

library(parallel)

cores <- as.numeric(Sys.getenv('SLURM_CPUS_ON_NODE'))

preds <- mclapply(seq_len(n), looFit, Y, X, TRUE, mc.cores = cores)

