Multivariate multiple regression
=========================

TODO
-------------------------

 - link to OLS for diagnostics
 - link to anovaSStypes

Install required packages
-------------------------

[`car`](http://cran.r-project.org/package=car)


    wants <- c("car")
    has   <- wants %in% rownames(installed.packages())
    if(any(!has)) install.packages(wants[!has])


Model fit
-------------------------
    

    set.seed(1.234)
    N  <- 100
    X1 <- rnorm(N, 175, 7)
    X2 <- rnorm(N, 30, 8)
    X3 <- abs(rnorm(N, 60, 30))
    Y1 <- 0.2*X1 - 0.3*X2 - 0.4*X3 + 10 + rnorm(N, 0, 10)
    Y2 <- -0.3*X2 + 0.2*X3 + rnorm(N, 10)
    Y  <- cbind(Y1, Y2)
    dfRegr <- data.frame(X1, X2, X3, Y1, Y2)



    (fit <- lm(cbind(Y1, Y2) ~ X1 + X2 + X3, data=dfRegr))

    
    Call:
    lm(formula = cbind(Y1, Y2) ~ X1 + X2 + X3, data = dfRegr)
    
    Coefficients:
                 Y1       Y2     
    (Intercept)  24.9395   4.4079
    X1            0.1192   0.0273
    X2           -0.3697  -0.2789
    X3           -0.3702   0.2021
    



    coef(lm(Y1 ~ X1 + X2 + X3, data=dfRegr))

    (Intercept)          X1          X2          X3 
        24.9395      0.1192     -0.3697     -0.3702 

    coef(lm(Y2 ~ X1 + X2 + X3, data=dfRegr))

    (Intercept)          X1          X2          X3 
         4.4079      0.0273     -0.2789      0.2021 


Coefficient and overall tests
-------------------------

### Type I sum of squares


    summary(manova(fit), test="Hotelling-Lawley")

              Df Hotelling-Lawley approx F num Df den Df Pr(>F)    
    X1         1             0.04        2      2     95   0.14    
    X2         1             4.60      219      2     95 <2e-16 ***
    X3         1            27.19     1292      2     95 <2e-16 ***
    Residuals 96                                                   
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 



    summary(manova(fit), test="Wilks")
    summary(manova(fit), test="Roy")
    summary(manova(fit), test="Pillai")


No possibility to use `confint()` for multivariate models.

### Type II/III sum of squares


    library(car)                           # for Manova()
    Manova(fit, type="II")

    
    Type II MANOVA Tests: Pillai test statistic
       Df test stat approx F num Df den Df Pr(>F)    
    X1  1     0.027        1      2     95   0.28    
    X2  1     0.779      168      2     95 <2e-16 ***
    X3  1     0.965     1292      2     95 <2e-16 ***
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 


Detach (automatically) loaded packages (if possible)
-------------------------


    try(detach(package:car))
    try(detach(package:nnet))
    try(detach(package:MASS))


Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/multRegression.Rmd) | [markdown](https://github.com/dwoll/RExRepos/raw/master/md/multRegression.md) | [R code](https://github.com/dwoll/RExRepos/raw/master/R/multRegression.R) - ([all posts](https://github.com/dwoll/RExRepos))
