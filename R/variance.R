
## @knitr unnamed-chunk-1
wants <- c("e1071", "psych", "robustbase", "vegan")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])


## @knitr unnamed-chunk-2
age <- c(17, 30, 30, 25, 23, 21)
N   <- length(age)
M   <- mean(age)
var(age)
sd(age)


## @knitr unnamed-chunk-3
(cML <- cov.wt(as.matrix(age), method="ML"))
(vML <- diag(cML$cov))
sqrt(vML)


## @knitr unnamed-chunk-4
library(psych)
ageWins <- winsor(age, trim=0.2)
var(ageWins)
sd(ageWins)


## @knitr unnamed-chunk-5
quantile(age)
IQR(age)


## @knitr unnamed-chunk-6
mean(abs(age-median(age)))


## @knitr unnamed-chunk-7
mad(age)


## @knitr unnamed-chunk-8
library(robustbase)
Qn(age)


## @knitr unnamed-chunk-9
scaleTau2(age)


## @knitr unnamed-chunk-10
fac <- factor(c("C", "D", "A", "D", "E", "D", "C", "E", "E", "B", "E"),
              levels=c(LETTERS[1:5], "Q"))
P   <- nlevels(fac)
(Fj <- prop.table(table(fac)))


## @knitr unnamed-chunk-11
library(vegan)
shannonIdx <- diversity(Fj, index="shannon")
(H <- (1/log(P)) * shannonIdx)


## @knitr unnamed-chunk-12
library(e1071)
skewness(age)
kurtosis(age)


## @knitr unnamed-chunk-13
try(detach(package:psych))
try(detach(package:robustbase))
try(detach(package:vegan))
try(detach(package:permute))
try(detach(package:e1071))
try(detach(package:class))


