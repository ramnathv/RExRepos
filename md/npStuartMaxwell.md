Stuart-Maxwell-test for marginal homogeneity
=========================

Install required packages
-------------------------

[`coin`](http://cran.r-project.org/package=coin)


    wants <- c("coin")
    has   <- wants %in% rownames(installed.packages())
    if(any(!has)) install.packages(wants[!has])


MH-test
-------------------------


    categ <- factor(1:3, labels=c("lo", "med", "hi"))
    drug  <- rep(categ, c(30, 50, 20))
    plac  <- rep(rep(categ, length(categ)), c(14,7,9, 5,26,19, 1,7,12))
    cTab  <- table(drug, plac)
    addmargins(cTab)

         plac
    drug   lo med  hi Sum
      lo   14   7   9  30
      med   5  26  19  50
      hi    1   7  12  20
      Sum  20  40  40 100



    library(coin)
    mh_test(cTab)

    
    	Asymptotic Marginal-Homogeneity Test
    
    data:  response by
    	 groups (drug, plac) 
    	 stratified by block 
    chi-squared = 12.14, df = 2, p-value = 0.002313
    


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

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/npStuartMaxwell.Rmd) | [markdown](https://github.com/dwoll/RExRepos/raw/master/md/npStuartMaxwell.md) | [R code](https://github.com/dwoll/RExRepos/raw/master/R/npStuartMaxwell.R) - ([all posts](https://github.com/dwoll/RExRepos))
