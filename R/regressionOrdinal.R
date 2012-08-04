
## @knitr unnamed-chunk-1
wants <- c("MASS", "ordinal", "rms", "VGAM")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])


## @knitr unnamed-chunk-2
set.seed(1.234)
N      <- 100
X1     <- rnorm(N, 175, 7)
X2     <- rnorm(N,  30, 8)
Ycont  <- 0.5*X1 - 0.3*X2 + 10 + rnorm(N, 0, 6)
Yord   <- cut(Ycont, breaks=quantile(Ycont), include.lowest=TRUE,
              labels=c("--", "-", "+", "++"), ordered=TRUE)
dfRegr <- data.frame(X1, X2, Yord)


## @knitr unnamed-chunk-3
library(rms)
(lrmFit <- lrm(Yord ~ X1 + X2, data=dfRegr))


## @knitr unnamed-chunk-4
library(VGAM)
vglmFit <- vglm(Yord ~ X1 + X2, family=propodds, data=dfRegr)
summary(vglmFit)


## @knitr unnamed-chunk-5
library(ordinal)
clmFit <- clm(Yord ~ X1 + X2, link="logit", data=dfRegr)
summary(clmFit)


## @knitr unnamed-chunk-6
library(MASS)
polrFit <- polr(Yord ~ X1 + X2, method="logistic", data=dfRegr)
summary(polrFit)


## @knitr unnamed-chunk-7
PhatCateg <- predict(lrmFit, type="fitted.ind")
head(PhatCateg)


## @knitr unnamed-chunk-8
predict(vglmFit, type="response")
predict(clmFit, subset(dfRegr, select=c("X1", "X2"), type="prob"))$fit
predict(polrFit, type="probs")


## @knitr unnamed-chunk-9
predict(clmFit, type="class")


## @knitr unnamed-chunk-10
(predCls <- predict(polrFit, type="class"))


## @knitr unnamed-chunk-11
categHat <- levels(dfRegr$Yord)[max.col(PhatCateg)]
all.equal(factor(categHat), predCls, check.attributes=FALSE)


## @knitr unnamed-chunk-12
try(detach(package:ordinal))
try(detach(package:ucminf))
try(detach(package:Matrix))
try(detach(package:lattice))
try(detach(package:MASS))
try(detach(package:rms))
try(detach(package:Hmisc))
try(detach(package:survival))
try(detach(package:VGAM))
try(detach(package:splines))
try(detach(package:stats4))


