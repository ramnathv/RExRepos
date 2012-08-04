
## @knitr unnamed-chunk-1
wants <- c("coin", "psych")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])


## @knitr unnamed-chunk-2
x <- c(17, 30, 30, 25, 23, 21)
y <- c(1, 12, 8, 10, 5, 3)
cov(x, y)


## @knitr unnamed-chunk-3
(cmML <- cov.wt(cbind(x, y), method="ML")$cov)


## @knitr unnamed-chunk-4
cmML[upper.tri(cmML)]


## @knitr unnamed-chunk-5
(r <- cor(x, y))


## @knitr unnamed-chunk-6
library(psych)
(rZ <- fisherz(r))
fisherz2r(rZ)


## @knitr unnamed-chunk-7
set.seed(1.234)
N  <- 100
z1 <- runif(N)
z2 <- runif(N)
x  <- -0.3*z1 + 0.2*z2 + rnorm(N, 0, 0.3)
y  <-  0.3*z1 - 0.4*z2 + rnorm(N, 0, 0.3)
cor(x, y)


## @knitr unnamed-chunk-8
x.z1 <- residuals(lm(x ~ z1))
y.z1 <- residuals(lm(y ~ z1))
cor(x.z1, y.z1)


## @knitr unnamed-chunk-9
x.z12 <- residuals(lm(x ~ z1 + z2))
y.z12 <- residuals(lm(y ~ z1 + z2))
cor(x.z12, y.z12)


## @knitr unnamed-chunk-10
cor(x.z1, y)


## @knitr unnamed-chunk-11
X1 <- c(19, 19, 31, 19, 24)
X2 <- c(95, 76, 94, 76, 76)
X3 <- c(197, 178, 189, 184, 173)
(X <- cbind(X1, X2, X3))


## @knitr unnamed-chunk-12
(covX <- cov(X))
(cML <- cov.wt(X, method="ML"))
cML$cov


## @knitr unnamed-chunk-13
cor(X)


## @knitr unnamed-chunk-14
cov2cor(covX)


## @knitr unnamed-chunk-15
vec <- rnorm(nrow(X))
cor(vec, X)


## @knitr unnamed-chunk-16
DV1   <- c(97, 76, 56, 99, 50, 62, 36, 69, 55,  17)
DV2   <- c(42, 74, 22, 99, 73, 44, 10, 68, 19, -34)
DV3   <- c(61, 88, 21, 29, 56, 37, 21, 70, 46,  88)
DV4   <- c(58, 65, 38, 19, 55, 23, 26, 60, 50,  91)
DVmat <- cbind(DV1, DV2, DV3, DV4)


## @knitr unnamed-chunk-17
cor(DV1, DV2, method="spearman")
cor(DVmat, method="spearman")


## @knitr unnamed-chunk-18
cor(DV1, DV2, method="kendall")
cor(DVmat, method="kendall")


## @knitr unnamed-chunk-19
cor.test(DV1, DV2)


## @knitr unnamed-chunk-20
library(psych)
corr.test(DVmat, adjust="bonferroni")


## @knitr unnamed-chunk-21
cor.test(DV1, DV2, method="spearman")
library(coin)
spearman_test(DV1 ~ DV2, distribution=approximate(B=5000))


## @knitr unnamed-chunk-22
library(psych)
corr.test(DVmat, method="spearman", adjust="bonferroni")


## @knitr unnamed-chunk-23
cor.test(DV1, DV2, method="kendall")


## @knitr unnamed-chunk-24
library(psych)
corr.test(DVmat, method="kendall", adjust="bonferroni")


## @knitr unnamed-chunk-25
N <- length(DV1)
library(psych)
r.test(n=N, n2=N, r12=cor(DV1, DV2), r34=cor(DV3, DV4))


## @knitr unnamed-chunk-26
try(detach(package:psych))
try(detach(package:coin))
try(detach(package:modeltools))
try(detach(package:stats4))
try(detach(package:mvtnorm))
try(detach(package:survival))
try(detach(package:splines))


