
## @knitr unnamed-chunk-1
wants <- c("modeest", "psych", "robustbase")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])


## @knitr unnamed-chunk-2
age <- c(17, 30, 30, 25, 23, 21)
mean(age)


## @knitr unnamed-chunk-3
weights <- c(0.6, 0.6, 0.3, 0.2, 0.4, 0.6)
weighted.mean(age, weights)


## @knitr unnamed-chunk-4
library(psych)
geometric.mean(age)


## @knitr unnamed-chunk-5
library(psych)
harmonic.mean(age)


## @knitr unnamed-chunk-6
vec <- c(11, 22, 22, 33, 33, 33, 33)
library(modeest)
mfv(vec)
mlv(vec, method="mfv")


## @knitr unnamed-chunk-7
median(age)


## @knitr unnamed-chunk-8
mean(age, trim=0.2)


## @knitr unnamed-chunk-9
library(psych)
(ageWins <- winsor(age, trim=0.2))
mean(ageWins)


## @knitr unnamed-chunk-10
library(robustbase)
hM <- huberM(age)
hM$mu


## @knitr unnamed-chunk-11
wilcox.test(age, conf.int=TRUE)$estimate


## @knitr unnamed-chunk-12
N <- 8
X <- rnorm(N, 100, 15)
Y <- rnorm(N, 110, 15)
wilcox.test(X, Y, conf.int=TRUE)$estimate


## @knitr unnamed-chunk-13
try(detach(package:modeest))
try(detach(package:psych))
try(detach(package:robustbase))


