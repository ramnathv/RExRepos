Variance, other spread measures, skewness and kurtosis
=========================

TODO
-------------------------

 - link to diagDistributions

Install required packages
-------------------------

[`e1071`](http://cran.r-project.org/package=e1071), [`psych`](http://cran.r-project.org/package=psych), [`robustbase`](http://cran.r-project.org/package=robustbase), [`vegan`](http://cran.r-project.org/package=vegan)


    wants <- c("e1071", "psych", "robustbase", "vegan")
    has   <- wants %in% rownames(installed.packages())
    if(any(!has)) install.packages(wants[!has])


Variance and standard deviation
-------------------------

### Corrected (sample) variance and standard deviation


    age <- c(17, 30, 30, 25, 23, 21)
    N   <- length(age)
    M   <- mean(age)
    var(age)

    [1] 26.27

    sd(age)

    [1] 5.125


### Uncorrected (population) variance and standard deviation


    (cML <- cov.wt(as.matrix(age), method="ML"))

    $cov
          [,1]
    [1,] 21.89
    
    $center
    [1] 24.33
    
    $n.obs
    [1] 6
    

    (vML <- diag(cML$cov))

    [1] 21.89

    sqrt(vML)

    [1] 4.679


Robust spread measures
-------------------------

### Winsorized variance and standard deviation


    library(psych)
    ageWins <- winsor(age, trim=0.2)
    var(ageWins)

    [1] 17.2

    sd(ageWins)

    [1] 4.147


### Inter-quartile-range


    quantile(age)

       0%   25%   50%   75%  100% 
    17.00 21.50 24.00 28.75 30.00 

    IQR(age)

    [1] 7.25

### Mean absolute difference to the median


    mean(abs(age-median(age)))

    [1] 4


### Median absolute difference to the median (MAD)


    mad(age)

    [1] 6.672


### $Qn$: more efficient alternative to MAD


    library(robustbase)
    Qn(age)

    [1] 6.793


### $\tau$ estimate of scale


    scaleTau2(age)

    [1] 4.865


Diversity of categorical data
-------------------------


    fac <- factor(c("C", "D", "A", "D", "E", "D", "C", "E", "E", "B", "E"),
                  levels=c(LETTERS[1:5], "Q"))
    P   <- nlevels(fac)
    (Fj <- prop.table(table(fac)))

    fac
          A       B       C       D       E       Q 
    0.09091 0.09091 0.18182 0.27273 0.36364 0.00000 



    library(vegan)
    shannonIdx <- diversity(Fj, index="shannon")
    (H <- (1/log(P)) * shannonIdx)

    [1] 0.8194


Higher moments: skewness and kurtosis
-------------------------


    library(e1071)
    skewness(age)

    [1] -0.08611

    kurtosis(age)

    [1] -1.773


Detach (automatically) loaded packages (if possible)
-------------------------


    try(detach(package:psych))
    try(detach(package:robustbase))
    try(detach(package:vegan))
    try(detach(package:permute))
    try(detach(package:e1071))
    try(detach(package:class))


Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/variance.Rmd) | [markdown](https://github.com/dwoll/RExRepos/raw/master/md/variance.md) | [R code](https://github.com/dwoll/RExRepos/raw/master/R/variance.R) - ([all posts](https://github.com/dwoll/RExRepos))
