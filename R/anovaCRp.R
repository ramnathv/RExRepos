
## @knitr unnamed-chunk-1
wants <- c("car", "multcomp")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])


## @knitr unnamed-chunk-2
set.seed(1.234)
P     <- 4
Nj    <- c(41, 37, 42, 40)
muJ   <- rep(c(-1, 0, 1, 2), Nj)
dfCRp <- data.frame(IV=factor(rep(LETTERS[1:P], Nj)),
                    DV=rnorm(sum(Nj), muJ, 5))


## @knitr rerAnovaCRp01
plot.design(DV ~ IV, fun=mean, data=dfCRp, main="Group means")


## @knitr unnamed-chunk-3
oneway.test(DV ~ IV, data=dfCRp, var.equal=TRUE)


## @knitr unnamed-chunk-4
oneway.test(DV ~ IV, data=dfCRp, var.equal=FALSE)


## @knitr unnamed-chunk-5
aovCRp <- aov(DV ~ IV, data=dfCRp)
summary(aovCRp)
model.tables(aovCRp, type="means")


## @knitr unnamed-chunk-6
(anovaCRp <- anova(lm(DV ~ IV, data=dfCRp)))


## @knitr unnamed-chunk-7
anova(lm(DV ~ 1, data=dfCRp), lm(DV ~ IV, data=dfCRp))


## @knitr unnamed-chunk-8
anovaCRp["Residuals", "Sum Sq"]


## @knitr unnamed-chunk-9
dfSSb <- anovaCRp["IV",        "Df"]
SSb   <- anovaCRp["IV",        "Sum Sq"]
MSb   <- anovaCRp["IV",        "Mean Sq"]
SSw   <- anovaCRp["Residuals", "Sum Sq"]
MSw   <- anovaCRp["Residuals", "Mean Sq"]


## @knitr unnamed-chunk-10
(etaSq <- SSb / (SSb + SSw))
(omegaSq <- dfSSb * (MSb-MSw) / (SSb + SSw + MSw))
(f <- sqrt(etaSq / (1-etaSq)))


## @knitr unnamed-chunk-11
cntrMat <- rbind("A-D"          =c(  1,   0,   0,  -1),
                 "1/3*(A+B+C)-D"=c(1/3, 1/3, 1/3,  -1),
                 "B-C"          =c(  0,   1,  -1,   0))
library(multcomp)
summary(glht(aovCRp, linfct=mcp(IV=cntrMat), alternative="less"),
        test=adjusted("none"))


## @knitr unnamed-chunk-12
pairwise.t.test(dfCRp$DV, dfCRp$IV, p.adjust.method="bonferroni")


## @knitr unnamed-chunk-13
(tHSD <- TukeyHSD(aovCRp))


## @knitr rerAnovaCRp02
plot(tHSD)


## @knitr rerAnovaCRp03
Estud <- rstudent(aovCRp)
qqnorm(Estud, pch=20, cex=2)
qqline(Estud, col="gray60", lwd=2)


## @knitr unnamed-chunk-14
shapiro.test(Estud)


## @knitr rerAnovaCRp04
plot(Estud ~ dfCRp$IV, main="Residuals per group")


## @knitr unnamed-chunk-15
library(car)
leveneTest(aovCRp)


## @knitr unnamed-chunk-16
try(detach(package:car))
try(detach(package:nnet))
try(detach(package:MASS))
try(detach(package:multcomp))
try(detach(package:survival))
try(detach(package:mvtnorm))
try(detach(package:splines))


