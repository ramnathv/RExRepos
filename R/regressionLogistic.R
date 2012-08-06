
## @knitr unnamed-chunk-1
wants <- c("rms")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])


## @knitr unnamed-chunk-2
set.seed(1.234)
N      <- 100
X1     <- rnorm(N, 175, 7)
X2     <- rnorm(N,  30, 8)
Y      <- 0.5*X1 - 0.3*X2 + 10 + rnorm(N, 0, 6)
Yfac   <- cut(Y, breaks=c(-Inf, median(Y), Inf), labels=c("lo", "hi"))
dfRegr <- data.frame(X1, X2, Yfac)


## @knitr rerRegressionLogistic01
cdplot(Yfac ~ X1, data=dfRegr)
cdplot(Yfac ~ X2, data=dfRegr)


## @knitr unnamed-chunk-3
(glmFit <- glm(Yfac ~ X1 + X2,
               family=binomial(link="logit"), data=dfRegr))


## @knitr unnamed-chunk-4
exp(coef(glmFit))
exp(confint(glmFit))


## @knitr unnamed-chunk-5
total  <- sample(40:60, N, replace=TRUE)      ## unequal n_i
hits   <- rbinom(N, size=total, prob=0.4)
hitMat <- cbind(hits, total-hits)
glm(hitMat ~ X1 + X2, family=binomial(link="logit"))


## @knitr unnamed-chunk-6
hitMatRel <- sweep(hitMat, 1, total, "/")
glm(hitMatRel ~ X1 + X2, weights=total, family=binomial(link="logit"))


## @knitr rerRegressionLogistic02
logitHat <- predict(glmFit, type="link")
plot(logitHat, pch=c(1, 16)[unclass(dfRegr$Yfac)])
abline(h=0)


## @knitr unnamed-chunk-7
Phat <- fitted(glmFit)
Phat <- predict(glmFit, type="response")
head(Phat)
mean(Phat)
prop.table(table(dfRegr$Yfac))


## @knitr unnamed-chunk-8
thresh <- 0.5
Yhat   <- cut(Phat, breaks=c(-Inf, thresh, Inf), labels=c("lo", "hi"))
cTab   <- table(Yfac, Yhat)
addmargins(cTab)
sum(diag(cTab)) / sum(cTab)


## @knitr unnamed-chunk-9
logLik(glmFit)


## @knitr unnamed-chunk-10
library(rms)
lrm(Yfac ~ X1 + X2, data=dfRegr)


## @knitr unnamed-chunk-11
glmFit0 <- update(glmFit, . ~ 1)
LLf <- logLik(glmFit)
LL0 <- logLik(glmFit0)
as.vector(1 - (LLf / LL0))


## @knitr unnamed-chunk-12
as.vector(1 - exp((2/N) * (LL0 - LLf)))


## @knitr unnamed-chunk-13
as.vector((1 - exp((2/N) * (LL0 - LLf))) / (1 - exp(LL0)^(2/N)))


## @knitr unnamed-chunk-14
summary(glmFit)


## @knitr unnamed-chunk-15
lrm(Yfac ~ X1 + X2, data=dfRegr)


## @knitr unnamed-chunk-16
anova(glmFit0, glmFit, test="Chisq")


## @knitr unnamed-chunk-17
lrm(Yfac ~ X1 + X2, data=dfRegr)


## @knitr unnamed-chunk-18
drop1(glmFit, test="Chi")


## @knitr unnamed-chunk-19
try(detach(package:rms))
try(detach(package:survival))
try(detach(package:splines))


