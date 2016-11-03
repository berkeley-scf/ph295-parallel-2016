source('loo.R')

library(parallel)

cores <- as.numeric(Sys.getenv('SLURM_CPUS_ON_NODE'))
cl <- makeCluster(cores) 
print(clusterSize(cl))

# n is set to full size of dataset in loo.R, but:
# only do first 48 obs to reduce time in demo
n <- 48 
preds <- parLapply(cl, seq_len(n), looFit, Y, X, TRUE)

cat(preds)

stopCluster(cl)
