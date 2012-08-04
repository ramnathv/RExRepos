
## @knitr unnamed-chunk-1
wants <- c("coin")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])


## @knitr unnamed-chunk-2
categ <- factor(1:3, labels=c("lo", "med", "hi"))
drug  <- rep(categ, c(30, 50, 20))
plac  <- rep(rep(categ, length(categ)), c(14,7,9, 5,26,19, 1,7,12))
cTab  <- table(drug, plac)
addmargins(cTab)


## @knitr unnamed-chunk-3
library(coin)
mh_test(cTab)


## @knitr unnamed-chunk-4
try(detach(package:coin))
try(detach(package:modeltools))
try(detach(package:survival))
try(detach(package:mvtnorm))
try(detach(package:splines))
try(detach(package:stats4))


