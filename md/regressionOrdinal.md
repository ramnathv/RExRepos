Ordinal regression
=========================

TODO
-------------------------

 - link to regressionMultinom

Install required packages
-------------------------

[`MASS`](http://cran.r-project.org/package=MASS), [`ordinal`](http://cran.r-project.org/package=ordinal), [`rms`](http://cran.r-project.org/package=rms), [`VGAM`](http://cran.r-project.org/package=VGAM)


    wants <- c("MASS", "ordinal", "rms", "VGAM")
    has   <- wants %in% rownames(installed.packages())
    if(any(!has)) install.packages(wants[!has])


Ordinal regression (proportional odds model)
-------------------------
    
### Simulate data
    

    set.seed(1.234)
    N      <- 100
    X1     <- rnorm(N, 175, 7)
    X2     <- rnorm(N,  30, 8)
    Ycont  <- 0.5*X1 - 0.3*X2 + 10 + rnorm(N, 0, 6)
    Yord   <- cut(Ycont, breaks=quantile(Ycont), include.lowest=TRUE,
                  labels=c("--", "-", "+", "++"), ordered=TRUE)
    dfRegr <- data.frame(X1, X2, Yord)


### Using `lrm()` from package `rms`

logit($p(Y \geq g)$)


    library(rms)
    (lrmFit <- lrm(Yord ~ X1 + X2, data=dfRegr))

    
    Logistic Regression Model
    
    lrm(formula = Yord ~ X1 + X2, data = dfRegr)
    
    Frequencies of Responses
    
    --  -  + ++ 
    25 25 25 25 
    
                          Model Likelihood     Discrimination    Rank Discrim.    
                             Ratio Test            Indexes          Indexes       
    Obs           100    LR chi2      33.84    R2       0.306    C       0.737    
    max |deriv| 4e-08    d.f.             2    g        1.357    Dxy     0.474    
                         Pr(> chi2) <0.0001    gr       3.884    gamma   0.474    
                                               gp       0.274    tau-a   0.359    
                                               Brier    0.180                     
    
          Coef     S.E.   Wald Z Pr(>|Z|)
    y>=-  -16.7826 5.5242 -3.04  0.0024  
    y>=+  -18.2037 5.5741 -3.27  0.0011  
    y>=++ -19.6302 5.6161 -3.50  0.0005  
    X1      0.1235 0.0321  3.84  0.0001  
    X2     -0.1180 0.0271 -4.36  <0.0001 
    
    


### Using `vglm()` from package `VGAM`

logit($p(Y \geq g)$)


    library(VGAM)
    vglmFit <- vglm(Yord ~ X1 + X2, family=propodds, data=dfRegr)
    summary(vglmFit)

    Length  Class   Mode 
         1   vglm     S4 


### Using `clm()` from package `ordinal`

logit($p(Y \leq g)$)


    library(ordinal)
    clmFit <- clm(Yord ~ X1 + X2, link="logit", data=dfRegr)
    summary(clmFit)

    formula: Yord ~ X1 + X2
    data:    dfRegr
    
     link  threshold nobs logLik  AIC    niter max.grad cond.H 
     logit flexible  100  -121.71 253.41 4(0)  4.20e-08 8.6e+07
    
    Coefficients:
       Estimate Std. Error z value Pr(>|z|)    
    X1   0.1235     0.0321    3.84  0.00012 ***
    X2  -0.1180     0.0271   -4.36  1.3e-05 ***
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
    
    Threshold coefficients:
         Estimate Std. Error z value
    --|-    16.78       5.52    3.04
    -|+     18.20       5.57    3.27
    +|++    19.63       5.62    3.50


### Using `polr()` from package `MASS`

logit($p(Y \leq g)$)


    library(MASS)
    polrFit <- polr(Yord ~ X1 + X2, method="logistic", data=dfRegr)
    summary(polrFit)

    Error: Objekt 'dfRegr' nicht gefunden


Predicted category membership
-------------------------

### Predicted category probabilities


    PhatCateg <- predict(lrmFit, type="fitted.ind")
    head(PhatCateg)

      Yord=-- Yord=-  Yord=+ Yord=++
    1 0.20885 0.3134 0.29762 0.18010
    2 0.19673 0.3068 0.30501 0.19143
    3 0.19383 0.3051 0.30675 0.19431
    4 0.07463 0.1758 0.33136 0.41825
    5 0.10060 0.2160 0.34200 0.34140
    6 0.74828 0.1766 0.05599 0.01913



    predict(vglmFit, type="response")
    predict(clmFit, subset(dfRegr, select=c("X1", "X2"), type="prob"))$fit
    predict(polrFit, type="probs")


### Predicted categories


    predict(clmFit, type="class")

    $fit
      [1] -  -  +  ++ +  -- -  -  +  -- ++ +  -- -- ++ +  +  ++ +  +  ++ -  + 
     [24] -- +  -- -  -- +  +  ++ +  -  ++ -- ++ -  +  ++ +  ++ -- ++ ++ +  - 
     [47] -- +  ++ ++ -  -  +  -  ++ ++ -- -  ++ -- ++ +  -  -- -  -- -- ++ + 
     [70] ++ -- -- -  -- -- +  -- -- -- -- +  -- +  -  -  +  -  +  +  ++ -  + 
     [93] ++ -  ++ ++ -- +  -- - 
    Levels: -- - + ++
    



    (predCls <- predict(polrFit, type="class"))



    categHat <- levels(dfRegr$Yord)[max.col(PhatCateg)]
    all.equal(factor(categHat), predCls, check.attributes=FALSE)

    [1] TRUE


Detach (automatically) loaded packages (if possible)
-------------------------


    try(detach(package:ordinal))
    try(detach(package:ucminf))
    try(detach(package:Matrix))
    try(detach(package:lattice))
    try(detach(package:MASS))
    try(detach(package:rms))
    try(detach(package:Hmisc))
    try(detach(package:survival))
    try(detach(package:VGAM))
    try(detach(package:splines))
    try(detach(package:stats4))


Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/regressionOrdinal.Rmd) | [markdown](https://github.com/dwoll/RExRepos/raw/master/md/regressionOrdinal.md) | [R code](https://github.com/dwoll/RExRepos/raw/master/R/regressionOrdinal.R) - ([all posts](https://github.com/dwoll/RExRepos))
