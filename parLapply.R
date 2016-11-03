source('loo.R')

library(parallel)

cores <- as.numeric(Sys.getenv('SLURM_CPUS_ON_NODE'))
cl <- makeCluster(cores) 

preds <- parLapply(cl, seq_len(n), looFit, Y, X, TRUE)

stopCluster(cl)
