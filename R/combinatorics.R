
## @knitr unnamed-chunk-1
wants <- c("e1071", "permute")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])


## @knitr unnamed-chunk-2
myN <- 5
myK <- 4
choose(myN, myK)
factorial(myN) / (factorial(myK)*factorial(myN-myK))


## @knitr unnamed-chunk-3
combn(c("a", "b", "c", "d", "e"), myK)
combn(c(1, 2, 3, 4), 3)


## @knitr unnamed-chunk-4
combn(c(1, 2, 3, 4), 3, sum)
combn(c(1, 2, 3, 4), 3, weighted.mean, w=c(0.5, 0.2, 0.3))


## @knitr unnamed-chunk-5
factorial(7)


## @knitr unnamed-chunk-6
set.seed(1.234)
set <- LETTERS[1:10]
sample(set, length(set), replace=FALSE)


## @knitr unnamed-chunk-7
library(permute)
shuffle(length(set))


## @knitr unnamed-chunk-8
set <- LETTERS[1:3]
len <- length(set)
library(e1071)
(mat <- permutations(len))
apply(mat, 1, function(x) set[x])


## @knitr unnamed-chunk-9
(grp <- rep(letters[1:3], each=3))
N      <- length(grp)
nPerms <- 100
library(permute)
pCtrl <- permControl(nperm=nPerms, complete=FALSE)
for(i in 1:5) {
    perm <- permute(i, n=N, control=pCtrl)
    print(grp[perm])
}


## @knitr unnamed-chunk-10
Njk    <- 4                                 # Zellbesetzung
P      <- 2                                 # Anzahl Stufen Faktor A
Q      <- 3                                 # Anzahl Stufen Faktor B
N      <- Njk*P*Q
nPerms <- 10             # Anzahl Permutationen
id     <- 1:(Njk*P*Q)
IV1    <- factor(rep(1:P,  each=Njk*Q))     # Faktor A
IV2    <- factor(rep(1:Q, times=Njk*P))     # Faktor B
(myDf  <- data.frame(id, IV1, IV2))

# lege Permutationsschema fuer Test von A, B fest
library(permute)                                                # fuer permControl(), permute()
pCtrlA <- permControl(strata=IV2, complete=FALSE, nperm=nPerms) # only permute across A (within B)
pCtrlB <- permControl(strata=IV1, complete=FALSE, nperm=nPerms) # only permute across B (within A)


## @knitr unnamed-chunk-11
for(i in 1:3) {
    perm <- permute(i, n=N, control=pCtrlA)
    print(myDf[perm, ])
}


## @knitr unnamed-chunk-12
for(i in 1:3) {
    perm <- permute(i, n=N, control=pCtrlB)
    print(myDf[perm, ])
}


## @knitr unnamed-chunk-13
IV1 <- c("control", "treatment")
IV2 <- c("f", "m")
IV3 <- c(1, 2)
expand.grid(IV1, IV2, IV3)


## @knitr unnamed-chunk-14
outer(1:5, 1:5, FUN="*")


## @knitr unnamed-chunk-15
try(detach(package:e1071))
try(detach(package:class))
try(detach(package:permute))


