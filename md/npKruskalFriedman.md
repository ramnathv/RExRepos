Nonparametric location tests for more than two samples
=========================

Install required packages
-------------------------

[`coin`](http://cran.r-project.org/package=coin)


    wants <- c("coin")
    has   <- wants %in% rownames(installed.packages())
    if(any(!has)) install.packages(wants[!has])


Independent samples - unordered groups
-------------------------

### Kruskal-Wallis-test
#### Using `kruskal.test()`


    IQ1  <- c( 99, 131, 118, 112, 128, 136, 120, 107, 134, 122)
    IQ2  <- c(134, 103, 127, 121, 139, 114, 121, 132)
    IQ3  <- c(110, 123, 100, 131, 108, 114, 101, 128, 110)
    IQ4  <- c(117, 125, 140, 109, 128, 137, 110, 138, 127, 141, 119, 148)
    Nj   <- c(length(IQ1), length(IQ2), length(IQ3), length(IQ4))
    KWdf <- data.frame(DV=c(IQ1, IQ2, IQ3, IQ4),
                       IV=factor(rep(1:4, Nj), labels=c("I", "II", "III", "IV")))



    kruskal.test(DV ~ IV, data=KWdf)

    
    	Kruskal-Wallis rank sum test
    
    data:  DV by IV 
    Kruskal-Wallis chi-squared = 6.059, df = 3, p-value = 0.1087
    


#### Using `kruskal_test()` from package `coin`


    library(coin)
    kruskal_test(DV ~ IV, distribution=approximate(B=9999), data=KWdf)

    
    	Approximative Kruskal-Wallis Test
    
    data:  DV by IV (I, II, III, IV) 
    chi-squared = 6.059, p-value = 0.1015
    


#### Pairwise group-comparisons using Wilcoxon's rank-sum test


    pairwise.wilcox.test(KWdf$DV, KWdf$IV, p.adjust.method="holm")

    
    	Pairwise comparisons using Wilcoxon rank sum test 
    
    data:  KWdf$DV and KWdf$IV 
    
        I    II   III 
    II  0.97 -    -   
    III 0.84 0.51 -   
    IV  0.84 0.97 0.16
    
    P value adjustment method: holm 


### Permutation test with untransformed response values


    oneway_test(DV ~ IV, distribution=approximate(B=9999), data=KWdf)

    
    	Approximative K-Sample Permutation Test
    
    data:  DV by IV (I, II, III, IV) 
    maxT = 2.206, p-value = 0.09511
    


Independent samples - ordered groups
------------------------------------

<!--
### Jonckheere-Terpstra test 

From [Dale Steele on R-help](http://tolstoy.newcastle.edu.au/R/e10/help/10/05/3900.html)


    set.seed(1.234)
    P    <- 4
    Nj   <- c(41, 37, 42, 40)
    muJ  <- rep(c(-1, 0, 1, 2), Nj)
    JTdf <- data.frame(IV=ordered(rep(LETTERS[1:P], Nj)),
                       DV=rnorm(sum(Nj), muJ, 7))



    ff <- function(x) {
        K <- contrMat(table(x), "Tukey")[ , x]
        as.vector(rep(1, nrow(K)) %*% K)
    }
    
    independence_test(DV ~ IV, data=JTdf,
                      ytrafo=rank,
                      xtrafo=function(data) { trafo(data, factor_trafo=ff) },
                      alternative="greater",
                      distribution=approximate(B=9999))

    
    	Approximative General Independence Test
    
    data:  DV by IV (A < B < C < D) 
    Z = -0.1465, p-value = 0.5684
    alternative hypothesis: greater 
    

-->

### Linear by linear association test


    set.seed(1.234)
    P    <- 4
    Nj   <- c(41, 37, 42, 40)
    muJ  <- rep(c(-1, 0, 1, 2), Nj)
    JTdf <- data.frame(IV=ordered(rep(LETTERS[1:P], Nj)),
                       DV=rnorm(sum(Nj), muJ, 7))



    library(coin)
    kruskal_test(DV ~ IV, distribution=approximate(B=9999), data=JTdf)

    
    	Approximative Linear-by-Linear Association Test
    
    data:  DV by IV (A < B < C < D) 
    chi-squared = 0.0215, p-value = 0.883
    


Dependent samples - unordered groups
-------------------------

### Friedman-test
#### Using `friedman.test()`


    N   <- 5
    P   <- 4
    DV1 <- c(14, 13, 12, 11, 10)
    DV2 <- c(11, 12, 13, 14, 15)
    DV3 <- c(16, 15, 14, 13, 12)
    DV4 <- c(13, 12, 11, 10,  9)
    Fdf <- data.frame(id=factor(rep(1:N, times=P)),
                      DV=c(DV1, DV2, DV3, DV4),
                      IV=factor(rep(1:P, each=N),
                                labels=LETTERS[1:P]))



    friedman.test(DV ~ IV | id, data=Fdf)

    
    	Friedman rank sum test
    
    data:  DV and IV and id 
    Friedman chi-squared = 8.265, df = 3, p-value = 0.04084
    


#### Using `friedman_test()` from package `coin`


    friedman_test(DV ~ IV | id, distribution=approximate(B=9999), data=Fdf)

    
    	Approximative Friedman Test
    
    data:  DV by IV (A, B, C, D) 
    	 stratified by id 
    chi-squared = 8.265, p-value = 0.0309
    


### Permutation test with untransformed response values


    oneway_test(DV ~ IV | id, distribution=approximate(B=9999), data=Fdf)

    
    	Approximative K-Sample Permutation Test
    
    data:  DV by IV (A, B, C, D) 
    	 stratified by id 
    maxT = 2.023, p-value = 0.194
    


Dependent samples - ordered groups
-------------------------

### Page trend test for ordered alternatives


    N   <- 10
    P   <- 4
    muJ <- rep(c(-1, 0, 1, 2), each=N)
    Pdf <- data.frame(id=factor(rep(1:N, times=P)),
                      DV=rnorm(N*P, muJ, 3),
                      IV=ordered(rep(LETTERS[1:P], each=N)))



    friedman_test(DV ~ IV | id, distribution=approximate(B=9999), data=Pdf)

    
    	Approximative Page Test
    
    data:  DV by
    	 IV (A < B < C < D) 
    	 stratified by id 
    chi-squared = 6.912, p-value = 0.009501
    


Detach (automatically) loaded packages (if possible)
-------------------------


    try(detach(package:coin))
    try(detach(package:modeltools))
    try(detach(package:survival))
    try(detach(package:mvtnorm))
    try(detach(package:splines))
    try(detach(package:stats4))


Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/npKruskalFriedman.Rmd) | [markdown](https://github.com/dwoll/RExRepos/raw/master/md/npKruskalFriedman.md) | [R code](https://github.com/dwoll/RExRepos/raw/master/R/npKruskalFriedman.R) - ([all posts](https://github.com/dwoll/RExRepos))
