
## @knitr unnamed-chunk-1
Njk   <- 2
P     <- 2
Q     <- 3
IQ    <- round(rnorm(Njk*P*Q, mean=100, sd=15))
sex   <- factor(rep(c("f", "m"),       times=Q*Njk))
group <- factor(rep(c("T", "WL", "CG"), each=P*Njk))
table(sex, group)


## @knitr unnamed-chunk-2
ave(IQ, sex, FUN=mean)


## @knitr unnamed-chunk-3
tapply(IQ, group, FUN=mean)
tapply(IQ, list(sex, group), FUN=mean)


## @knitr unnamed-chunk-4
set.seed(1.234)
N      <- 12
sex    <- sample(c("f", "m"), N, replace=TRUE)
group  <- sample(rep(c("CG", "WL", "T"), 4), N, replace=FALSE)
age    <- sample(18:35, N, replace=TRUE)
IQ     <- round(rnorm(N, mean=100, sd=15))
rating <- round(runif(N, min=0, max=6))
(myDf1 <- data.frame(id=1:N, sex, group, age, IQ, rating))


## @knitr unnamed-chunk-5
lapply(myDf1[ , c("age", "IQ", "rating")], mean)
sapply(myDf1[ , c("age", "IQ", "rating")], range)


## @knitr unnamed-chunk-6
(numIdx <- sapply(myDf1, is.numeric))
dataNum <- myDf1[ , numIdx]
head(dataNum)


## @knitr unnamed-chunk-7
N    <- 100
x1   <- rnorm(N, 10, 10)
y1   <- rnorm(N, 10, 10)
x2   <- x1 + rnorm(N, 5, 4)
y2   <- y1 + rnorm(N, 10, 4)
tDf1 <- data.frame(x1, y1)
tDf2 <- data.frame(x2, y2)


## @knitr unnamed-chunk-8
mapply(t.test, tDf1, tDf2, MoreArgs=list(alternative="less", var.equal=TRUE))


## @knitr unnamed-chunk-9
tapply(myDf1$IQ, myDf1$group, FUN=mean)


## @knitr unnamed-chunk-10
aggregate(myDf1[ , c("age", "IQ", "rating")],
          list(myDf1$sex, myDf1$group), FUN=mean)
aggregate(cbind(age, IQ, rating) ~ sex + group, FUN=mean, data=myDf1)


## @knitr unnamed-chunk-11
by(myDf1[ , c("age", "IQ", "rating")], list(myDf1$sex, myDf1$group), FUN=mean)


