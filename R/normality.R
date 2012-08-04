
## @knitr unnamed-chunk-1
wants <- c("energy", "ICS", "mvtnorm", "nortest", "QuantPsyc")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])


## @knitr unnamed-chunk-2
set.seed(1.234)
DV <- rnorm(20, mean=1.5, sd=3)
qqnorm(DV, pch=20, cex=2)
qqline(DV, col="gray60", lwd=2)


## @knitr unnamed-chunk-3
shapiro.test(DV)


## @knitr unnamed-chunk-4
library(nortest)
ad.test(DV)


## @knitr unnamed-chunk-5
library(nortest)
cvm.test(DV)


## @knitr unnamed-chunk-6
library(nortest)
sf.test(DV)


## @knitr unnamed-chunk-7
library(tseries)
jarque.bera.test(DV)


## @knitr unnamed-chunk-8
ks.test(DV, "pnorm", mean=1, sd=2, alternative="two.sided")


## @knitr unnamed-chunk-9
library(nortest)
lillie.test(DV)


## @knitr unnamed-chunk-10
library(nortest)
pearson.test(DV, n.classes=6, adjust=TRUE)


## @knitr unnamed-chunk-11
mu    <- c(2, 4, 5)
Sigma <- matrix(c(4,2,-3, 2,16,-1, -3,-1,9), byrow=TRUE, ncol=3)
library(mvtnorm)
X <- rmvnorm(100, mu, Sigma)


## @knitr unnamed-chunk-12
library(energy)                    # for mvnorm.etest()
mvnorm.etest(X)


## @knitr unnamed-chunk-13
library(QuantPsyc)                    # for mult.norm()
mn <- mult.norm(X, chicrit=0.001)
mn$mult.test


## @knitr unnamed-chunk-14
library(ICS)
mvnorm.kur.test(X)


## @knitr unnamed-chunk-15
library(ICS)
X <- rmvnorm(100, c(2, 4, 5))
mvnorm.skew.test(X)


## @knitr unnamed-chunk-16
try(detach(package:nortest))
try(detach(package:QuantPsyc))
try(detach(package:tseries))
try(detach(package:quadprog))
try(detach(package:zoo))
try(detach(package:energy))
try(detach(package:boot))
try(detach(package:MASS))
try(detach(package:ICS))
try(detach(package:mvtnorm))
try(detach(package:survey))


