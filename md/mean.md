The mean and other location measures
=========================

TODO
-------------------------

 - link to npWilcoxon for `wilcox.test()`

Install required packages
-------------------------

[`modeest`](http://cran.r-project.org/package=modeest), [`psych`](http://cran.r-project.org/package=psych), [`robustbase`](http://cran.r-project.org/package=robustbase)


    wants <- c("modeest", "psych", "robustbase")
    has   <- wants %in% rownames(installed.packages())
    if(any(!has)) install.packages(wants[!has])


Mean, weighted mean, geometric mean, harmonic mean, and mode
-------------------------

### Mean


    age <- c(17, 30, 30, 25, 23, 21)
    mean(age)

    [1] 24.33


### Weighted mean


    weights <- c(0.6, 0.6, 0.3, 0.2, 0.4, 0.6)
    weighted.mean(age, weights)

    [1] 23.7


### Geometric mean


    library(psych)
    geometric.mean(age)

    [1] 23.87


### Harmonic mean


    library(psych)
    harmonic.mean(age)

    [1] 23.38


### Mode


    vec <- c(11, 22, 22, 33, 33, 33, 33)
    library(modeest)
    mfv(vec)

    [1] 33

    mlv(vec, method="mfv")

    Mode (most likely value): 33 
    Bickel's modal skewness: -0.4286 
    Call: mlv.default(x = vec, method = "mfv") 


Robust location measures
-------------------------

### Median


    median(age)

    [1] 24


### Trimmed mean


    mean(age, trim=0.2)

    [1] 24.75


### Winsorized mean


    library(psych)
    (ageWins <- winsor(age, trim=0.2))

    [1] 21 30 30 25 23 21

    mean(ageWins)

    [1] 25


### Huber-$M$ estimator


    library(robustbase)
    hM <- huberM(age)
    hM$mu

    [1] 24.33


### Hodges-Lehmann estimator (pseudo-median)


    wilcox.test(age, conf.int=TRUE)$estimate

    (pseudo)median 
                24 


### Hodges-Lehmann estimator of difference between two location parameters


    N <- 8
    X <- rnorm(N, 100, 15)
    Y <- rnorm(N, 110, 15)
    wilcox.test(X, Y, conf.int=TRUE)$estimate

    difference in location 
                    -16.05 


Detach (automatically) loaded packages (if possible)
-------------------------


    try(detach(package:modeest))
    try(detach(package:psych))
    try(detach(package:robustbase))


Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/mean.Rmd) | [markdown](https://github.com/dwoll/RExRepos/raw/master/md/mean.md) | [R code](https://github.com/dwoll/RExRepos/raw/master/R/mean.R) - ([all posts](https://github.com/dwoll/RExRepos))
