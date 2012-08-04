
## @knitr unnamed-chunk-1
wants <- c("ICSNP", "mvtnorm")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])


## @knitr unnamed-chunk-2
set.seed(1.234)
library(mvtnorm)
Nj    <- c(15, 25)
Sigma <- matrix(c(16,-2, -2,9), byrow=TRUE, ncol=2)
mu1   <- c(-4, 4)
Y1    <- round(rmvnorm(Nj[1], mean=mu1, sigma=Sigma))


## @knitr unnamed-chunk-3
muH0 <- c(-1, 2)
library(ICSNP)
HotellingsT2(Y1, mu=muH0)


## @knitr unnamed-chunk-4
Y1ctr  <- sweep(Y1, 2, muH0, "-")
(anRes <- anova(lm(Y1ctr ~ 1), test="Hotelling-Lawley"))


## @knitr unnamed-chunk-5
mu2 <- c(3, 3)
Y2  <- round(rmvnorm(Nj[2], mean=mu2, sigma=Sigma))
Y12 <- rbind(Y1, Y2)
IV  <- factor(rep(1:2, Nj))


## @knitr unnamed-chunk-6
library(ICSNP)
HotellingsT2(Y12 ~ IV)


## @knitr unnamed-chunk-7
anova(lm(Y12 ~ IV), test="Hotelling-Lawley")
summary(manova(Y12 ~ IV), test="Hotelling-Lawley")


## @knitr unnamed-chunk-8
N    <- 20
P    <- 2
muJK <- c(90, 100, 85, 105)
Sig  <- 15
Y1t0 <- rnorm(N, mean=muJK[1], sd=Sig)
Y1t1 <- rnorm(N, mean=muJK[2], sd=Sig)
Y2t0 <- rnorm(N, mean=muJK[3], sd=Sig)
Y2t1 <- rnorm(N, mean=muJK[4], sd=Sig)
Ydf  <- data.frame(id=factor(rep(1:N, times=P)),
                   Y1=c(Y1t0, Y1t1),
                   Y2=c(Y2t0, Y2t1),
                   IV=factor(rep(1:P, each=N), labels=c("t0", "t1")))


## @knitr unnamed-chunk-9
dfDiff <- aggregate(cbind(Y1, Y2) ~ id, data=Ydf, FUN=diff)
DVdiff <- data.matrix(dfDiff[ , -1])
muH0   <- c(0, 0)


## @knitr unnamed-chunk-10
library(ICSNP)
HotellingsT2(DVdiff, mu=muH0)


## @knitr unnamed-chunk-11
anova(lm(DVdiff ~ 1), test="Hotelling-Lawley")


## @knitr unnamed-chunk-12
try(detach(package:ICSNP))
try(detach(package:ICS))
try(detach(package:survey))
try(detach(package:mvtnorm))


