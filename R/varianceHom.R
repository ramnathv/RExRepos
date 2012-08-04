
## @knitr unnamed-chunk-1
wants <- c("car", "coin")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])


## @knitr unnamed-chunk-2
set.seed(1.234)
P     <- 2
Nj    <- c(50, 40)
DV1   <- rnorm(Nj[1], mean=100, sd=15)
DV2   <- rnorm(Nj[2], mean=100, sd=13)
varDf <- data.frame(DV=c(DV1, DV2),
                    IV=factor(rep(1:P, Nj)))


## @knitr unnamed-chunk-3
boxplot(DV ~ IV, data=varDf)
stripchart(DV ~ IV, data=varDf, pch=16, vert=TRUE, add=TRUE)


## @knitr unnamed-chunk-4
var.test(DV1, DV2)


## @knitr unnamed-chunk-5
var.test(DV ~ IV, data=varDf)


## @knitr unnamed-chunk-6
mood.test(DV ~ IV, alternative="greater", data=varDf)


## @knitr unnamed-chunk-7
ansari.test(DV ~ IV, alternative="greater", exact=FALSE, data=varDf)


## @knitr unnamed-chunk-8
library(coin)
ansari_test(DV ~ IV, alternative="greater", distribution="exact", data=varDf)


## @knitr unnamed-chunk-9
Nj    <- c(22, 18, 20)
N     <- sum(Nj)
P     <- length(Nj)
levDf <- data.frame(DV=sample(0:100, N, replace=TRUE),
                    IV=factor(rep(1:P, Nj)))


## @knitr unnamed-chunk-10
boxplot(DV ~ IV, data=levDf)
stripchart(DV ~ IV, data=levDf, pch=20, vert=TRUE, add=TRUE)


## @knitr unnamed-chunk-11
library(car)
leveneTest(DV ~ IV, center=median, data=levDf)
leveneTest(DV ~ IV, center=mean, data=levDf)


## @knitr unnamed-chunk-12
fligner.test(DV ~ IV, data=levDf)


## @knitr unnamed-chunk-13
library(coin)
fligner_test(DV ~ IV, distribution=approximate(B=9999), data=levDf)


## @knitr unnamed-chunk-14
try(detach(package:car))
try(detach(package:nnet))
try(detach(package:MASS))
try(detach(package:coin))
try(detach(package:modeltools))
try(detach(package:survival))
try(detach(package:mvtnorm))
try(detach(package:splines))
try(detach(package:stats4))


