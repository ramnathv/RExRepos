
## @knitr unnamed-chunk-1
wants <- c("car", "multcomp")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])


## @knitr unnamed-chunk-2
set.seed(1.234)
Njk  <- 8
P    <- 2
Q    <- 3
muJK <- c(rep(c(1, -1), Njk), rep(c(2, 1), Njk), rep(c(3, 3), Njk))
dfCRFpq <- data.frame(IV1=factor(rep(1:P, times=Njk*Q)),
                      IV2=factor(rep(1:Q,  each=Njk*P)),
                      DV =rnorm(Njk*P*Q, muJK, 2))


## @knitr unnamed-chunk-3
dfCRFpq$IVcomb <- interaction(dfCRFpq$IV1, dfCRFpq$IV2)


## @knitr unnamed-chunk-4
summary(aov(DV ~ IV1*IV2, data=dfCRFpq))


## @knitr unnamed-chunk-5
fitIII <- lm(DV ~ IV1 + IV2 + IV1:IV2, data=dfCRFpq,
             contrasts=list(IV1=contr.sum, IV2=contr.sum))
library(car)
Anova(fitIII, type="III")


## @knitr rerAnovaCRFpq01
plot.design(DV ~ IV1*IV2, data=dfCRFpq, main="Marginal means")
interaction.plot(dfCRFpq$IV1, dfCRFpq$IV2, dfCRFpq$DV,
                 main="Cell means", col=c("red", "blue", "green"), lwd=2)


## @knitr unnamed-chunk-6
anRes <- anova(lm(DV ~ IV1*IV2, data=dfCRFpq))
SS1   <- anRes["IV1",       "Sum Sq"]
SS2   <- anRes["IV2",       "Sum Sq"]
SSI   <- anRes["IV1:IV2",   "Sum Sq"]
SSE   <- anRes["Residuals", "Sum Sq"]


## @knitr unnamed-chunk-7
(pEtaSq1 <- SS1 / (SS1 + SSE))
(pEtaSq2 <- SS2 / (SS2 + SSE))
(pEtaSqI <- SSI / (SSI + SSE))


## @knitr unnamed-chunk-8
CRFp1 <- anova(lm(DV ~ IV1, data=dfCRFpq, subset=(IV2==1)))
CRFp2 <- anova(lm(DV ~ IV1, data=dfCRFpq, subset=(IV2==2)))
CRFp3 <- anova(lm(DV ~ IV1, data=dfCRFpq, subset=(IV2==3)))


## @knitr unnamed-chunk-9
SSp1 <- CRFp1["IV1", "Sum Sq"]
SSp2 <- CRFp2["IV1", "Sum Sq"]
SSp3 <- CRFp3["IV1", "Sum Sq"]


## @knitr unnamed-chunk-10
CRFpq <- anova(lm(DV ~ IV1*IV2, data=dfCRFpq))
SSA   <- CRFpq["IV1",       "Sum Sq"]
SSI   <- CRFpq["IV1:IV2",   "Sum Sq"]
SSE   <- CRFpq["Residuals", "Sum Sq"]
dfSSA <- CRFpq["IV1",       "Df"]
dfSSE <- CRFpq["Residuals", "Df"]


## @knitr unnamed-chunk-11
all.equal(SSp1 + SSp2 + SSp3, SSA + SSI)


## @knitr unnamed-chunk-12
Fp1 <- (SSp1/dfSSA) / (SSE/dfSSE)
Fp2 <- (SSp2/dfSSA) / (SSE/dfSSE)
Fp3 <- (SSp3/dfSSA) / (SSE/dfSSE)


## @knitr unnamed-chunk-13
(pP1 <- 1-pf(Fp1, dfSSA, dfSSE))
(pP2 <- 1-pf(Fp2, dfSSA, dfSSE))
(pP3 <- 1-pf(Fp3, dfSSA, dfSSE))


## @knitr unnamed-chunk-14
aovCRFpq <- aov(DV ~ IV1*IV2, data=dfCRFpq)
cMat     <- rbind("c1"=c( 1/2, 1/2, -1),
                  "c2"=c(  -1,   0,  1))

library(multcomp)
summary(glht(aovCRFpq, linfct=mcp(IV2=cMat), alternative="two.sided"),
        test=adjusted("bonferroni"))


## @knitr unnamed-chunk-15
TukeyHSD(aovCRFpq, which="IV2")


## @knitr unnamed-chunk-16
(aovCRFpqA <- aov(DV ~ IVcomb, data=dfCRFpq))
cntrMat <- rbind("c1"=c(-1/2,  1/4, -1/2, 1/4, 1/4, 1/4),
                 "c2"=c(   0,    0,   -1,   0,   1,   0),
                 "c3"=c(-1/2, -1/2,  1/4, 1/4, 1/4, 1/4))


## @knitr unnamed-chunk-17
library(multcomp)
summary(glht(aovCRFpqA, linfct=mcp(IVcomb=cntrMat), alternative="greater"),
        test=adjusted("none"))


## @knitr rerAnovaCRFpq02
Estud <- rstudent(aovCRFpq)
qqnorm(Estud, pch=20, cex=2)
qqline(Estud, col="gray60", lwd=2)


## @knitr unnamed-chunk-18
shapiro.test(Estud)


## @knitr rerAnovaCRFpq03
plot(Estud ~ dfCRFpq$IVcomb, main="Residuals per group")


## @knitr unnamed-chunk-19
library(car)
leveneTest(aovCRFpq)


## @knitr unnamed-chunk-20
try(detach(package:car))
try(detach(package:nnet))
try(detach(package:MASS))
try(detach(package:multcomp))
try(detach(package:survival))
try(detach(package:mvtnorm))
try(detach(package:splines))


