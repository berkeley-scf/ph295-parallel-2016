library(doMPI)

cl = startMPIcluster()  # by default will start one fewer slave than available cores
print(clusterSize(cl))

registerDoMPI(cl)

n <- 48 # do subset so demo runs faster

preds <- foreach(i = seq_len(n), .packages = 'SuperLearner') %dopar% { 
      looFit(i, Y, X) 
}
print(preds[1:10])

closeCluster(cl)
mpi.quit()
