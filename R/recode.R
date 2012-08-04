
## @knitr unnamed-chunk-1
opts_knit$set(self.contained=FALSE)
opts_chunk$set(tidy=FALSE, message=FALSE, warning=FALSE, comment="")


## @knitr unnamed-chunk-2
wants <- c("car", "gdata")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])


## @knitr unnamed-chunk-3
myColors <- c("red", "purple", "blue", "blue", "orange", "red", "orange")
farben   <- character(length(myColors))
farben[myColors == "red"]    <- "rot"
farben[myColors == "purple"] <- "violett"
farben[myColors == "blue"]   <- "blau"
farben[myColors == "orange"] <- "orange"
farben


## @knitr unnamed-chunk-4
replace(c(1, 2, 3, 4, 5), list=c(2, 4), values=c(200, 400))


## @knitr unnamed-chunk-5
library(car)
recode(myColors, "'red'='rot'; 'blue'='blau'; 'purple'='violett'")


## @knitr unnamed-chunk-6
recode(myColors, "c('red', 'blue')='basic'; else='complex'")


## @knitr unnamed-chunk-7
orgVec <- c(5, 9, 11, 8, 9, 3, 1, 13, 9, 12, 5, 12, 6, 3, 17, 5, 8, 7)
cutoff <- 10
(reVec <- ifelse(orgVec <= cutoff, orgVec, cutoff))


## @knitr unnamed-chunk-8
targetSet <- c("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K")
response  <- c("Z", "E", "O", "W", "H", "C", "I", "G", "A", "O", "B")
(respRec  <- ifelse(response %in% targetSet, response, "other"))


## @knitr unnamed-chunk-9
set.seed(1.234)
IQ <- rnorm(20, mean=100, sd=15)
ifelse(IQ >= 100, "hi", "lo")


## @knitr unnamed-chunk-10
library(car)
recode(IQ, "0:100=1; 101:115=2; else=3")


## @knitr unnamed-chunk-11
IQfac <- cut(IQ, breaks=c(0, 85, 115, Inf), labels=c("lo", "mid", "hi"))
head(IQfac)


## @knitr unnamed-chunk-12
medSplit <- cut(IQ, breaks=c(-Inf, median(IQ), Inf))
summary(medSplit)


## @knitr unnamed-chunk-13
IQdiscr <- cut(IQ, quantile(IQ), include.lowest=TRUE)
summary(IQdiscr)


## @knitr unnamed-chunk-14
(status <- factor(c("hi", "lo", "hi")))
status[4] <- "mid"
status
levels(status) <- c(levels(status), "mid")
status[4] <- "mid"
status


## @knitr unnamed-chunk-15
hiNotHi <- status
levels(hiNotHi) <- list(hi="hi", notHi=c("mid", "lo"))
hiNotHi


## @knitr unnamed-chunk-16
library(car)
(statNew <- recode(status, "'hi'='high'; c('mid', 'lo')='notHigh'"))


## @knitr unnamed-chunk-17
status[1:2]
(newStatus <- droplevels(status[1:2]))


## @knitr unnamed-chunk-18
(facGrp <- factor(rep(LETTERS[1:3], each=5)))
library(gdata)
(facRe <- reorder.factor(facGrp, new.order=c("C", "B", "A")))


## @knitr unnamed-chunk-19
vec <- rnorm(15, rep(c(10, 5, 15), each=5), 3)
tapply(vec, facGrp, FUN=mean)
reorder(facGrp, vec, FUN=mean)


## @knitr unnamed-chunk-20
try(detach(package:car))
try(detach(package:nnet))
try(detach(package:MASS))
try(detach(package:gdata))


