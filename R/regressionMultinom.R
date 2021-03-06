
## @knitr unnamed-chunk-1
opts_knit$set(self.contained=FALSE)
opts_chunk$set(tidy=FALSE, message=FALSE, warning=FALSE, comment="")


## @knitr unnamed-chunk-2
wants <- c("lmtest", "mlogit", "nnet", "VGAM")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])


## @knitr unnamed-chunk-3
set.seed(1.234)
N      <- 100
X1     <- rnorm(N, 175, 7)
X2     <- rnorm(N,  30, 8)
Ycont  <- 0.5*X1 - 0.3*X2 + 10 + rnorm(N, 0, 6)
Ycateg <- cut(Ycont, breaks=quantile(Ycont), include.lowest=TRUE,
              labels=c("--", "-", "+", "++"))
dfRegr <- data.frame(X1, X2, Ycateg)


## @knitr unnamed-chunk-4
library(nnet)
mnFit <- multinom(Ycateg ~ X1 + X2, data=dfRegr)
summary(mnFit)


## @knitr unnamed-chunk-5
library(lmtest)
lrtest(mnFit)


## @knitr unnamed-chunk-6
library(VGAM)
vglmFitMN <- vglm(Ycateg ~ X1 + X2, family=multinomial(refLevel=1), data=dfRegr)
summary(vglmFitMN)


## @knitr unnamed-chunk-7
library(mlogit)
dfRegrL   <- mlogit.data(dfRegr, choice="Ycateg", shape="wide", varying=NULL)
mlogitFit <- mlogit(Ycateg ~ 0 | X1 + X2, reflevel="--", data=dfRegrL)
summary(mlogitFit)


## @knitr unnamed-chunk-8
library(lmtest)
coeftest(mlogitFit)


## @knitr unnamed-chunk-9
PhatCateg <- predict(mnFit, type="probs")
head(PhatCateg)


## @knitr unnamed-chunk-10
predict(vglmFitMN, type="response")
fitted(mlogitFit, outcome=FALSE)
# not run


## @knitr unnamed-chunk-11
(predCls <- predict(mnFit, type="class"))


## @knitr unnamed-chunk-12
categHat <- levels(dfRegr$Ycateg)[max.col(PhatCateg)]
all.equal(factor(categHat), predCls, check.attributes=FALSE)


## @knitr unnamed-chunk-13
Nnew  <- 4
dfNew <- data.frame(X1=rnorm(Nnew, 175, 7),
                    X2=rnorm(Nnew,  30, 8),
                    Ycateg=factor(sample(c("--", "-", "+", "++"), Nnew, TRUE),
                                  levels=c("--", "-", "+", "++")))
dfNewL <- mlogit.data(dfNew, choice="Ycateg", shape="wide", varying=NULL)


## @knitr unnamed-chunk-14
predict(mnFit, dfNew, type="probs")


## @knitr unnamed-chunk-15
predict(vglmFitMN, dfNew, type="response")
predict(mlogitFit, dfNewL)
# not shown


## @knitr unnamed-chunk-16
try(detach(package:mlogit))
try(detach(package:MASS))
try(detach(package:Formula))
try(detach(package:statmod))
try(detach(package:lmtest))
try(detach(package:zoo))
try(detach(package:maxLik))
try(detach(package:miscTools))
try(detach(package:nnet))
try(detach(package:VGAM))
try(detach(package:splines))
try(detach(package:stats4))


