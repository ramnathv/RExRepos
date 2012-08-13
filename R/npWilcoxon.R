
## @knitr unnamed-chunk-1
wants <- c("coin")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])


## @knitr unnamed-chunk-2
set.seed(1.234)
medH0 <- 30
DV    <- sample(0:100, 20, replace=TRUE)
DV    <- DV[DV != medH0]
N     <- length(DV)
(obs  <- sum(DV > medH0))


## @knitr unnamed-chunk-3
(pGreater <- 1-pbinom(obs-1, N, 0.5))
(pTwoSided <- 2 * pGreater)


## @knitr unnamed-chunk-4
IQ    <- c(99, 131, 118, 112, 128, 136, 120, 107, 134, 122)
medH0 <- 110


## @knitr unnamed-chunk-5
wilcox.test(IQ, alternative="greater", mu=medH0, conf.int=TRUE)


## @knitr unnamed-chunk-6
Nj  <- c(20, 30)
DVa <- rnorm(Nj[1], mean= 95, sd=15)
DVb <- rnorm(Nj[2], mean=100, sd=15)
wIndDf <- data.frame(DV=c(DVa, DVb),
                     IV=factor(rep(1:2, Nj), labels=LETTERS[1:2]))


## @knitr unnamed-chunk-7
library(coin)
median_test(DV ~ IV, distribution="exact", data=wIndDf)


## @knitr unnamed-chunk-8
wilcox.test(DV ~ IV, alternative="less", conf.int=TRUE, data=wIndDf)


## @knitr unnamed-chunk-9
library(coin)
wilcox_test(DV ~ IV, alternative="less", conf.int=TRUE,
            distribution="exact", data=wIndDf)


## @knitr unnamed-chunk-10
N      <- 20
DVpre  <- rnorm(N, mean= 95, sd=15)
DVpost <- rnorm(N, mean=100, sd=15)
wDepDf <- data.frame(id=factor(rep(1:N, times=2)),
                     DV=c(DVpre, DVpost),
                     IV=factor(rep(0:1, each=N), labels=c("pre", "post")))


## @knitr unnamed-chunk-11
medH0  <- 0
DVdiff <- aggregate(DV ~ id, FUN=diff, data=wDepDf)
(obs   <- sum(DVdiff$DV < medH0))


## @knitr unnamed-chunk-12
(pLess <- pbinom(obs, N, 0.5))


## @knitr unnamed-chunk-13
wilcoxsign_test(DV ~ IV | id, alternative="greater",
                distribution="exact", data=wDepDf)


## @knitr unnamed-chunk-14
try(detach(package:coin))
try(detach(package:modeltools))
try(detach(package:survival))
try(detach(package:mvtnorm))
try(detach(package:splines))
try(detach(package:stats4))


