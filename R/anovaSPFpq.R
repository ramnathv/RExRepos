
## @knitr unnamed-chunk-1
wants <- c("car", "multcomp")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])


## @knitr unnamed-chunk-2
set.seed(1.234)
Nj   <- 10
P    <- 3
Q    <- 3
muJK <- c(rep(c(1,-1,-2), Nj), rep(c(2,1,-1), Nj), rep(c(3,3,0), Nj))
dfSPFpqL <- data.frame(id=factor(rep(1:(P*Nj), times=Q)),
                       IVbtw=factor(rep(LETTERS[1:P], times=Q*Nj)),
                       IVwth=factor(rep(1:Q, each=P*Nj)),
                       DV=rnorm(Nj*P*Q, muJK, 3))


## @knitr unnamed-chunk-3
summary(aov(DV ~ IVbtw*IVwth + Error(id/IVwth), data=dfSPFpqL))


## @knitr unnamed-chunk-4
dfSPFpqW <- reshape(dfSPFpqL, v.names="DV", timevar="IVwth",
                    idvar=c("id", "IVbtw"), direction="wide")


## @knitr unnamed-chunk-5
library(car)
fitSPFpq   <- lm(cbind(DV.1, DV.2, DV.3) ~ IVbtw, data=dfSPFpqW)
inSPFpq    <- data.frame(IVwth=gl(Q, 1))
AnovaSPFpq <- Anova(fitSPFpq, idata=inSPFpq, idesign=~IVwth)
summary(AnovaSPFpq, multivariate=FALSE, univariate=TRUE)


## @knitr unnamed-chunk-6
anova(fitSPFpq, M=~1, X=~0, idata=inSPFpq, test="Spherical")
anova(fitSPFpq, M=~IVwth, X=~1, idata=inSPFpq, test="Spherical")


## @knitr unnamed-chunk-7
mauchly.test(fitSPFpq, M=~IVwth, X=~1, idata=inSPFpq)


## @knitr unnamed-chunk-8
(anRes <- anova(lm(DV ~ IVbtw*IVwth*id, data=dfSPFpqL)))


## @knitr unnamed-chunk-9
SSEtot <- anRes["id", "Sum Sq"] + anRes["IVwth:id", "Sum Sq"]
SSbtw  <- anRes["IVbtw", "Sum Sq"]
SSwth  <- anRes["IVwth", "Sum Sq"]
SSI    <- anRes["IVbtw:IVwth", "Sum Sq"]


## @knitr unnamed-chunk-10
(gEtaSqB <- SSbtw / (SSbtw + SSEtot))
(gEtaSqW <- SSwth / (SSwth + SSEtot))
(gEtaSqI <- SSI   / (SSI   + SSEtot))


## @knitr unnamed-chunk-11
summary(aov(DV ~ IVbtw, data=dfSPFpqL, subset=(IVwth==1)))
summary(aov(DV ~ IVbtw, data=dfSPFpqL, subset=(IVwth==2)))
summary(aov(DV ~ IVbtw, data=dfSPFpqL, subset=(IVwth==3)))


## @knitr unnamed-chunk-12
summary(aov(DV ~ IVwth + Error(id/IVwth), data=dfSPFpqL,
        subset=(IVbtw=="A")))
summary(aov(DV ~ IVwth + Error(id/IVwth), data=dfSPFpqL,
        subset=(IVbtw=="B")))
summary(aov(DV ~ IVwth + Error(id/IVwth), data=dfSPFpqL,
        subset=(IVbtw=="C")))


## @knitr unnamed-chunk-13
mDf    <- aggregate(DV ~ id + IVbtw, data=dfSPFpqL, FUN=mean)
aovRes <- aov(DV ~ IVbtw, data=mDf)


## @knitr unnamed-chunk-14
cMat <- rbind("-0.5*(A+B)+C"=c(-1/2, -1/2, 1),
                       "A-C"=c(-1,    0,   1))


## @knitr unnamed-chunk-15
library(multcomp)
summary(glht(aovRes, linfct=mcp(IVbtw=cMat), alternative="greater"),
        test=adjusted("none"))


## @knitr unnamed-chunk-16
try(detach(package:multcomp))
try(detach(package:mvtnorm))
try(detach(package:car))
try(detach(package:survival))
try(detach(package:splines))
try(detach(package:nnet))
try(detach(package:MASS))


