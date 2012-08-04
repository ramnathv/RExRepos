
## @knitr unnamed-chunk-1
wants <- c("coin", "epitools", "vcd")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])


## @knitr unnamed-chunk-2
disease <- factor(rep(c("no", "yes"),   c(10, 5)))
diagN   <- rep(c("isHealthy", "isIll"), c( 8, 2))
diagY   <- rep(c("isHealthy", "isIll"), c( 1, 4))
diagT   <- factor(c(diagN, diagY))
contT1  <- table(disease, diagT)
addmargins(contT1)


## @knitr unnamed-chunk-3
fisher.test(contT1, alternative="greater")


## @knitr unnamed-chunk-4
TN <- c11 <- contT1[1, 1]                # true negative
TP <- c22 <- contT1[2, 2]                # true positive / hit
FP <- c12 <- contT1[1, 2]                # false positive
FN <- c21 <- contT1[2, 1]                # false negative / miss


## @knitr unnamed-chunk-5
(prevalence <- sum(contT1[2, ]) / sum(contT1))


## @knitr unnamed-chunk-6
(sensitivity <- recall <- TP / (TP+FN))


## @knitr unnamed-chunk-7
(specificity <- TN / (TN+FP))


## @knitr unnamed-chunk-8
(relevance <- precision <- TP / (TP+FP))


## @knitr unnamed-chunk-9
(CCR <- sum(diag(contT1)) / sum(contT1))


## @knitr unnamed-chunk-10
(Fval <- 1 / mean(1 / c(precision, recall)))


## @knitr unnamed-chunk-11
library(vcd)                                # fuer oddsratio()
(OR <- oddsratio(contT1, log=FALSE))        # odds ratio
(ORln <- oddsratio(contT1))                 # logarithmierte odds ratio


## @knitr unnamed-chunk-12
summary(ORln)               # Signifikanztest logarithmierte OR


## @knitr unnamed-chunk-13
(CIln <- confint(ORln))     # Konfidenzintervall logarithmierte OR
exp(CIln)                   # Konfidenzintervall nicht log. OR


## @knitr unnamed-chunk-14
(Q <- (c11*c22 - c12*c21) / (c11*c22 + c12*c21))     # Yules Q
(OR-1) / (OR+1)                              # alternativ


## @knitr unnamed-chunk-15
library(epitools)
riskratio(contT1, method="small")


## @knitr unnamed-chunk-16
set.seed(1.234)
N        <- 50
smokes   <- factor(sample(c("no", "yes"), N, replace=TRUE))
siblings <- factor(round(abs(rnorm(N, 1, 0.5))))
cTab     <- table(smokes, siblings)
addmargins(cTab)


## @knitr unnamed-chunk-17
chisq.test(cTab)


## @knitr unnamed-chunk-18
DV1  <- cut(c(100, 76, 56, 99, 50, 62, 36, 69, 55,  17), breaks=3,
            labels=LETTERS[1:3])
DV2  <- cut(c(42,  74, 22, 99, 73, 44, 10, 68, 19, -34), breaks=3,
            labels=LETTERS[1:3])
cTab <- table(DV1, DV2)
addmargins(cTab)


## @knitr unnamed-chunk-19
library(vcd)
assocstats(cTab)


## @knitr unnamed-chunk-20
N    <- 10
myDf <- data.frame(work =factor(sample(c("home", "office"), N, replace=TRUE)),
                   sex  =factor(sample(c("f", "m"),         N, replace=TRUE)),
                   group=factor(sample(c("A", "B"), 10, replace=TRUE)))
tab3 <- xtabs(~ work + sex + group, data=myDf)


## @knitr unnamed-chunk-21
library(coin)
cmh_test(tab3, distribution=approximate(B=9999))


## @knitr unnamed-chunk-22
try(detach(package:vcd))
try(detach(package:colorspace))
try(detach(package:MASS))
try(detach(package:grid))
try(detach(package:coin))
try(detach(package:modeltools))
try(detach(package:survival))
try(detach(package:mvtnorm))
try(detach(package:splines))
try(detach(package:stats4))


