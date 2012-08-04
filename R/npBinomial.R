
## @knitr unnamed-chunk-1
wants <- c("binom")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])


## @knitr unnamed-chunk-2
DV   <- factor(c("+", "+", "-", "+", "-", "+", "+"), levels=c("+", "-"))
N    <- length(DV)
(tab <- table(DV))
pH0 <- 0.25
binom.test(tab, p=pH0, alternative="greater", conf.level=0.95)


## @knitr unnamed-chunk-3
N    <- 20
hits <- 10
binom.test(hits, N, p=pH0, alternative="two.sided")


## @knitr unnamed-chunk-4
sum(dbinom(hits:N, N, p=pH0)) + sum(dbinom(0, N, p=pH0))


## @knitr unnamed-chunk-5
library(binom)
binom.confint(tab[1], sum(tab))


## @knitr unnamed-chunk-6
total <- c(4000, 5000, 3000)
hits  <- c( 585,  610,  539)
prop.test(hits, total)


## @knitr unnamed-chunk-7
try(detach(package:binom))
try(detach(package:lattice))


