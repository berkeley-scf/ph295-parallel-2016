source('loo.R')
library(doParallel)

cores <- as.numeric(Sys.getenv('SLURM_CPUS_ON_NODE'))
registerDoParallel(cores)
preds <- foreach(i = seq_len(n)) %dopar% { 
      looFit(i, Y, X) 
}
