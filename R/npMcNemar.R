
## @knitr unnamed-chunk-1
wants <- c("coin")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])


## @knitr unnamed-chunk-2
set.seed(1.234)
N       <- 20
pre     <- rbinom(N, size=1, prob=0.6)
post    <- rbinom(N, size=1, prob=0.4)
preFac  <- factor(pre,  labels=c("no", "yes"))
postFac <- factor(post, labels=c("no", "yes"))
cTab    <- table(preFac, postFac)
addmargins(cTab)


## @knitr unnamed-chunk-3
mcnemar.test(cTab, correct=FALSE)


## @knitr unnamed-chunk-4
library(coin)
symmetry_test(cTab, teststat="quad", distribution=approximate(B=9999))


## @knitr unnamed-chunk-5
try(detach(package:coin))
try(detach(package:modeltools))
try(detach(package:survival))
try(detach(package:mvtnorm))
try(detach(package:splines))
try(detach(package:stats4))


