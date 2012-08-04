
## @knitr unnamed-chunk-1
wants <- c("coin", "mvtnorm", "polycor", "rms", "ROCR")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])


## @knitr unnamed-chunk-2
set.seed(1.234)
library(mvtnorm)
N     <- 100
Sigma <- matrix(c(4,2,-3, 2,16,-1, -3,-1,9), byrow=TRUE, ncol=3)
mu    <- c(-3, 2, 4)
Xdf   <- data.frame(rmvnorm(n=N, mean=mu, sigma=Sigma))


## @knitr unnamed-chunk-3
lOrd   <- lapply(Xdf, function(x) {
                 cut(x, breaks=quantile(x), include.lowest=TRUE,
                     ordered=TRUE, labels=LETTERS[1:4]) })
dfOrd  <- data.frame(lOrd)
matOrd <- data.matrix(dfOrd)


## @knitr unnamed-chunk-4
cTab <- xtabs(~ X1 + X3, data=dfOrd)
addmargins(cTab)
library(coin)
lbl_test(cTab, distribution=approximate(B=9999))


## @knitr unnamed-chunk-5
library(polycor)
polychor(dfOrd$X1, dfOrd$X2, ML=TRUE)


## @knitr unnamed-chunk-6
polychor(cTab, ML=TRUE)


## @knitr unnamed-chunk-7
library(polycor)
polyserial(Xdf$X2, dfOrd$X3)


## @knitr unnamed-chunk-8
library(polycor)
Xdf2   <- rmvnorm(n=N, mean=mu, sigma=Sigma)
dfBoth <- cbind(Xdf2, dfOrd)
hetcor(dfBoth, ML=TRUE)


## @knitr unnamed-chunk-9
N   <- 100
x   <- rnorm(N)
y   <- x + rnorm(N, 0, 2)
yDi <- ifelse(y <= median(y), 0, 1)


## @knitr unnamed-chunk-10
library(rms)
lrm(yDi ~ x)$stats


## @knitr unnamed-chunk-11
library(ROCR)
pred <- prediction(x, yDi)
(AUC <- performance(pred, measure="auc")@y.values[[1]])


## @knitr unnamed-chunk-12
perf <- performance(pred, measure="tpr", x.measure="fpr")
par(lend=2)
plot(perf, col=rainbow(10), lwd=3, main="ROC-Curve, AUC", asp=1,
     xlim=c(0,1), ylim=c(0,1))
abline(a=0, b=1)


## @knitr unnamed-chunk-13
try(detach(package:ROCR))
try(detach(package:gplots))
try(detach(package:gtools))
try(detach(package:gdata))
try(detach(package:caTools))
try(detach(package:bitops))
try(detach(package:grid))
try(detach(package:KernSmooth))
try(detach(package:rms))
try(detach(package:Hmisc))
try(detach(package:polycor))
try(detach(package:sfsmisc))
try(detach(package:MASS))
try(detach(package:coin))
try(detach(package:modeltools))
try(detach(package:survival))
try(detach(package:mvtnorm))
try(detach(package:splines))
try(detach(package:stats4))


