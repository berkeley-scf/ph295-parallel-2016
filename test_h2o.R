library(h2o)
library(h2oEnsemble)  

# to enforce the number of threads based on SLURM information
nThreads = as.numeric(Sys.getenv('SLURM_CPUS_ON_NODE'))
localH2O = h2o.init(nthreads = nThreads)
# in general, can use `nthreads=-1` on Savio as you generally get the entire node for your use
# also in my testing `nthreads=1` did NOT seem to restrict to use of one thread, so not sure if there is a bug in h2o's R front-end

h2o.removeAll()

# preprocessing (from h2o-demo.Rmd in PH295)
data(BreastCancer, package = "mlbench")
y = "Class"
data = na.omit(BreastCancer)
data2 = data[, !names(data) %in% c("Id", y)]
data2 = data.frame(model.matrix( ~ . - 1, data = data2))
library(caret)
preproc = caret::preProcess(data2, method = c("zv", "nzv"))
data2 = predict(preproc, data2)
rm(preproc)
data2 = cbind(data[, y], data2)
colnames(data2)[1] = y
rm(data, BreastCancer)

# fitting (also from h2o-demo.Rmd)
data = as.h2o(data2)
splits = h2o.splitFrame(data, 0.7, seed = 1234)
train_frame = h2o.assign(splits[[1]], "train")
holdout_frame = h2o.assign(splits[[2]], "holdout")
features = setdiff(names(data), y)
learners = c("h2o.glm.wrapper", "h2o.randomForest.wrapper",
             "h2o.gbm.wrapper")

h2o.glm_nn = function(...) {
  h2o.glm.wrapper(..., non_negative = T, lambda = 0, intercept = F)
}

metalearner = "h2o.glm_nn"

print(system.time(
fit_ens <- h2o.ensemble(x = features, y = y,  training_frame = train_frame,
                    family = "AUTO",  learner = learners,
                    metalearner = metalearner, cvControl = list(V = 5))
))

print(fit_ens$metafit)


h2o.randomForest.1 = function(...) {
  h2o.randomForest.wrapper(..., ntrees = 200, nbins = 50, seed = 1)
}

new_library = learner <- c("h2o.glm.wrapper", "h2o.randomForest.wrapper",
             "h2o.randomForest.1", "h2o.gbm.wrapper")
print(system.time(fit <- h2o.ensemble(x = features, y = y, 
                    training_frame = train_frame,
                    family = "AUTO", 
                    learner = new_library, 
                    metalearner = metalearner,
                    cvControl = list(V = 5))))

