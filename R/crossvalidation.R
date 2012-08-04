
## @knitr unnamed-chunk-1
wants <- c("boot")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])


## @knitr unnamed-chunk-2
set.seed(1.234)
N  <- 100
X1 <- rnorm(N, 175, 7)
X2 <- rnorm(N,  30, 8)
X3 <- abs(rnorm(N, 60, 30))
Y  <- 0.5*X1 - 0.3*X2 - 0.4*X3 + 10 + rnorm(N, 0, 3)
dfRegr <- data.frame(X1, X2, X3, Y)


## @knitr unnamed-chunk-3
glmFit <- glm(Y ~ X1 + X2 + X3, data=dfRegr,
              family=gaussian(link="identity"))


## @knitr unnamed-chunk-4
library(boot)
k    <- 3
kfCV <- cv.glm(data=dfRegr, glmfit=glmFit, K=k)
kfCV$delta


## @knitr unnamed-chunk-5
LOOCV <- cv.glm(data=dfRegr, glmfit=glmFit, K=N)


## @knitr unnamed-chunk-6
LOOCV$delta


## @knitr unnamed-chunk-7
try(detach(package:boot))


