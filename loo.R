library(SuperLearner)

looFit <- function(i, Y, X, loadLib = FALSE, family = gaussian()) {
    if(loadLib)
        library(SuperLearner)
    out <- SL.randomForest(Y[-i], X[-i, ], X[i, ], family)
    return(out$pred)
}

set.seed(23432)
## training set
n <- 500
p <- 50
X <- matrix(rnorm(n*p), nrow = n, ncol = p)
colnames(X) <- paste("X", 1:p, sep="")
X <- data.frame(X)
Y <- X[, 1] + sqrt(abs(X[, 2] * X[, 3])) + X[, 2] - X[, 3] + rnorm(n)

