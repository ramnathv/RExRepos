
## @knitr unnamed-chunk-1
wants <- c("mediation", "multilevel", "QuantPsyc")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])


## @knitr unnamed-chunk-2
set.seed(1.234)
N <- 100
X <- rnorm(N, 175, 7)
M <- rnorm(N,  30, 8)
Y <- 0.5*X - 0.3*M + 10 + rnorm(N, 0, 3)
dfRegr <- data.frame(X, M, Y)


## @knitr unnamed-chunk-3
Xc <- c(scale(dfRegr$X, center=TRUE, scale=FALSE))
Mc <- c(scale(dfRegr$M, center=TRUE, scale=FALSE))
fitMod <- lm(Y ~ Xc + Mc + Xc:Mc, data=dfRegr)
summary(fitMod)


## @knitr unnamed-chunk-4
library(QuantPsyc)
sim.slopes(fitMod, Mc)


## @knitr unnamed-chunk-5
N <- 100
X <- rnorm(N, 175, 7)
M <- 0.7*X + rnorm(N, 0, 5)
Y <- 0.4*M + rnorm(N, 0, 5)
dfMed <- data.frame(X, M, Y)


## @knitr unnamed-chunk-6
fit <- lm(Y ~ X + M, data=dfMed)
summary(fit)


## @knitr unnamed-chunk-7
library(multilevel)
sobel(dfMed$X, dfMed$M, dfMed$Y)


## @knitr unnamed-chunk-8
fitM <- lm(M ~ X,     data=dfMed)
fitY <- lm(Y ~ X + M, data=dfMed)

library(mediation)
fitMed <- mediate(fitM, fitY, sims=999, treat="X", mediator="M")
summary(fitMed)


## @knitr rerRegressionModMed01
plot(fitMed)


## @knitr unnamed-chunk-9
fitMedBoot <- mediate(fitM, fitY, boot=TRUE, sims=999, treat="X", mediator="M")
summary(fitMedBoot)


## @knitr unnamed-chunk-10
try(detach(package:QuantPsyc))
try(detach(package:boot))
try(detach(package:mediation))
try(detach(package:Matrix))
try(detach(package:lpSolve))
try(detach(package:lattice))
try(detach(package:multilevel))
try(detach(package:MASS))
try(detach(package:nlme))


