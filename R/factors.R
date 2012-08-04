
## @knitr unnamed-chunk-1
opts_knit$set(self.contained=FALSE)
opts_chunk$set(tidy=FALSE, message=FALSE, warning=FALSE, comment="")


## @knitr unnamed-chunk-2
wants <- c("car", "gdata")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])


## @knitr unnamed-chunk-3
sex     <- c("m", "f", "f", "m", "m", "m", "f", "f")
(sexFac <- factor(sex))


## @knitr unnamed-chunk-4
factor(c(1, 1, 3, 3, 4, 4), levels=1:5)
(sexNum <- rbinom(10, size=1, prob=0.5))
factor(sexNum, labels=c("man", "woman"))
levels(sexFac) <- c("female", "male")
sexFac


## @knitr unnamed-chunk-5
(fac1 <- factor(rep(c("A", "B"), c(5, 5))))
(fac2 <- gl(2, 5, labels=c("less", "more"), ordered=TRUE))
sample(fac2, length(fac2), replace=FALSE)


## @knitr unnamed-chunk-6
expand.grid(IV1=gl(2, 2, labels=c("a", "b")), IV2=gl(3, 1))


## @knitr unnamed-chunk-7
nlevels(sexFac)
summary(sexFac)
levels(sexFac)
str(sexFac)


## @knitr unnamed-chunk-8
unclass(sexFac)
unclass(factor(10:15))
as.character(sexFac)


## @knitr unnamed-chunk-9
(fac1 <- factor(sample(LETTERS, 5)))
(fac2 <- factor(sample(letters, 3)))
(charVec1 <- levels(fac1)[fac1])
(charVec2 <- levels(fac2)[fac2])
factor(c(charVec1, charVec2))


## @knitr unnamed-chunk-10
rep(fac1, times=2)


## @knitr unnamed-chunk-11
Njk  <- 2
P    <- 2
Q    <- 3
(IV1 <- factor(rep(c("lo", "hi"), each=Njk*Q)))
(IV2 <- factor(rep(1:Q, times=Njk*P)))
interaction(IV1, IV2)


## @knitr unnamed-chunk-12
(status <- factor(c("hi", "lo", "hi", "mid")))
(ordStat <- ordered(status, levels=c("lo", "mid", "hi")))
ordStat[1] > ordStat[2]


## @knitr unnamed-chunk-13
(chars <- rep(LETTERS[1:3], each=5))
(fac1 <- factor(chars))
factor(chars, levels=c("C", "A", "B"))


## @knitr unnamed-chunk-14
library(gdata)
(facRe <- reorder.factor(fac1, new.order=c("C", "B", "A")))


## @knitr unnamed-chunk-15
vec <- rnorm(15, rep(c(10, 5, 15), each=5), 3)
tapply(vec, fac1, FUN=mean)
reorder(fac1, vec, FUN=mean)


## @knitr unnamed-chunk-16
(fac2 <- factor(sample(1:2, 10, replace=TRUE), labels=c("B", "A")))
sort(fac2)
sort(as.character(fac2))


## @knitr unnamed-chunk-17
try(detach(package:car))
try(detach(package:nnet))
try(detach(package:MASS))
try(detach(package:gdata))


