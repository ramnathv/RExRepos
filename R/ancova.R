
## @knitr unnamed-chunk-1
wants <- c("car", "effects", "multcomp")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])


## @knitr unnamed-chunk-2
SSRIpre  <- c(18, 16, 16, 15, 14, 20, 14, 21, 25, 11)
SSRIpost <- c(12,  0, 10,  9,  0, 11,  2,  4, 15, 10)
PlacPre  <- c(18, 16, 15, 14, 20, 25, 11, 25, 11, 22)
PlacPost <- c(11,  4, 19, 15,  3, 14, 10, 16, 10, 20)
WLpre    <- c(15, 19, 10, 29, 24, 15,  9, 18, 22, 13)
WLpost   <- c(17, 25, 10, 22, 23, 10,  2, 10, 14,  7)


## @knitr unnamed-chunk-3
P     <- 3
Nj    <- rep(length(SSRIpre), times=P)
dfAnc <- data.frame(IV=factor(rep(1:P, Nj), labels=c("SSRI", "Placebo", "WL")),
                    DVpre=c(SSRIpre,   PlacPre,  WLpre),
                    DVpost=c(SSRIpost, PlacPost, WLpost))


## @knitr rerAncova01
plot(DVpre  ~ IV, data=dfAnc, main="Pre-scores per group")
plot(DVpost ~ IV, data=dfAnc, main="Post-Scores per group")


## @knitr unnamed-chunk-4
fitFull <- lm(DVpost ~ IV + DVpre, data=dfAnc)
fitGrp  <- lm(DVpost ~ IV,         data=dfAnc)
fitRegr <- lm(DVpost ~      DVpre, data=dfAnc)


## @knitr unnamed-chunk-5
anova(fitFull)


## @knitr unnamed-chunk-6
library(car)
fitFiii <- lm(DVpost ~ IV + DVpre,
              contrasts=list(IV=contr.sum), data=dfAnc)
Anova(fitFiii, type="III")


## @knitr unnamed-chunk-7
anova(fitRegr, fitFull)
anova(fitGrp, fitFull)


## @knitr unnamed-chunk-8
(sumRes <- summary(fitFull))
confint(fitFull)


## @knitr unnamed-chunk-9
coeffs    <- coef(sumRes)
iCeptSSRI <- coeffs[1, 1]
iCeptPlac <- coeffs[2, 1] + iCeptSSRI
iCeptWL   <- coeffs[3, 1] + iCeptSSRI
slopeAll  <- coeffs[4, 1]


## @knitr rerAncova02
xLims <- c(0, max(dfAnc$DVpre))
yLims <- c(min(iCeptSSRI, iCeptPlac, iCeptWL), max(dfAnc$DVpost))

plot(DVpost ~ DVpre, data=dfAnc, xlim=xLims, ylim=yLims,
     pch=rep(c(3, 17, 19), Nj), col=rep(c("red", "green", "blue"), Nj),
     main="Rohdaten und Regressionsgerade pro Gruppe")
legend(x="topleft", legend=levels(dfAnc$IV), pch=c(3, 17, 19),
       col=c("red", "green", "blue"))
abline(iCeptSSRI, slopeAll, col="red")
abline(iCeptPlac, slopeAll, col="green")
abline(iCeptWL,   slopeAll, col="blue")


## @knitr unnamed-chunk-10
anRes <- anova(fitRegr, fitFull)
dfGrp <- anRes[2, "Df"]
dfE   <- anRes[2, "Res.Df"]
MSgrp <- anRes[2, "Sum of Sq"] / dfGrp
MSE   <- anRes[2, "RSS"] / dfE
SST   <- sum(anova(fitFull)[ , "Sum Sq"])

(omegaSqHat <- dfGrp*(MSgrp - MSE) / (SST + MSE))


## @knitr unnamed-chunk-11
aovAncova <- aov(DVpost ~ IV + DVpre, data=dfAnc)
library(effects)
effect("IV", aovAncova)


## @knitr unnamed-chunk-12
cMat <- rbind("SSRI-Placebo"  = c(-1,  1, 0),
              "SSRI-WL"       = c(-1,  0, 1),
              "SSRI-0.5(P+WL)"= c(-2,  1, 1))


## @knitr unnamed-chunk-13
library(multcomp)
aovAncova <- aov(DVpost ~ IV + DVpre, data=dfAnc)
summary(glht(aovAncova, linfct=mcp(IV=cMat), alternative="greater"),
        test=adjusted("none"))


## @knitr unnamed-chunk-14
try(detach(package:effects))
try(detach(package:colorspace))
try(detach(package:lattice))
try(detach(package:grid))
try(detach(package:car))
try(detach(package:nnet))
try(detach(package:MASS))
try(detach(package:multcomp))
try(detach(package:survival))
try(detach(package:mvtnorm))
try(detach(package:splines))


