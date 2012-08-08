Multivariate analysis of variance (MANOVA)
=========================

TODO
-------------------------

 - link to multLDA, anovaSStypes

Install required packages
-------------------------

[`car`](http://cran.r-project.org/package=car), [`mvtnorm`](http://cran.r-project.org/package=mvtnorm)


```r
wants <- c("car", "mvtnorm")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])
```


One-way MANOVA
-------------------------
    

```r
set.seed(1.234)
P     <- 3
Nj    <- c(15, 25, 20)
Sigma <- matrix(c(16,-2, -2,9), byrow=TRUE, ncol=2)
mu11  <- c(-4,  4)
mu21  <- c( 3,  3)
mu31  <- c( 1, -1)

library(mvtnorm)
Y11 <- round(rmvnorm(Nj[1], mean=mu11, sigma=Sigma))
Y21 <- round(rmvnorm(Nj[2], mean=mu21, sigma=Sigma))
Y31 <- round(rmvnorm(Nj[3], mean=mu31, sigma=Sigma))

dfMan1 <- data.frame(Y =rbind(Y11, Y21, Y31),
                     IV=factor(rep(1:P, Nj)))
```



```r
manRes1 <- manova(cbind(Y.1, Y.2) ~ IV, data=dfMan1)
summary(manRes1, test="Wilks")
```

```
          Df Wilks approx F num Df den Df Pr(>F)    
IV         2 0.371       18      4    112  2e-11 ***
Residuals 57                                        
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
```



```r
summary(manRes1, test="Roy")
summary(manRes1, test="Pillai")
summary(manRes1, test="Hotelling-Lawley")
```


Two-way MANOVA
-------------------------


```r
Q    <- 2
mu12 <- c(-1,  4)
mu22 <- c( 4,  8)
mu32 <- c( 4,  0)

library(mvtnorm)
Y12  <- round(rmvnorm(Nj[1], mean=mu12, sigma=Sigma))
Y22  <- round(rmvnorm(Nj[2], mean=mu22, sigma=Sigma))
Y32  <- round(rmvnorm(Nj[3], mean=mu32, sigma=Sigma))

dfMan2 <- data.frame(Y  =rbind(Y11, Y21, Y31, Y12, Y22, Y32),
                     IV1=factor(rep(rep(1:P, Nj), Q)),
                     IV2=factor(rep(1:Q, each=sum(Nj))))
```


### Type I sum of squares


```r
manRes2 <- manova(cbind(Y.1, Y.2) ~ IV1*IV2, data=dfMan2)
summary(manRes2, test="Pillai")
```

```
           Df Pillai approx F num Df den Df  Pr(>F)    
IV1         2  0.855     42.6      4    228 < 2e-16 ***
IV2         1  0.141      9.3      2    113 0.00018 ***
IV1:IV2     2  0.205      6.5      4    228 5.6e-05 ***
Residuals 114                                          
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
```



```r
summary(manRes2, test="Wilks")
summary(manRes2, test="Roy")
summary(manRes2, test="Hotelling-Lawley")
```


### Type II/III sum of squares


```r
library(car)
fitIII <- lm(cbind(Y.1, Y.2) ~ IV1*IV2, data=dfMan2,
             contrasts=list(IV1=contr.sum, IV2=contr.sum))
ManRes <- Manova(fitIII, type="III")
summary(ManRes, multivariate=TRUE)
```

```

Type III MANOVA Tests:

Sum of squares and products for error:
       Y.1    Y.2
Y.1 1596.1 -145.9
Y.2 -145.9  994.6

------------------------------------------
 
Term: (Intercept) 

Sum of squares and products for the hypothesis:
      Y.1   Y.2
Y.1 295.4 501.8
Y.2 501.8 852.5

Multivariate Tests: (Intercept)
                 Df test stat approx F num Df den Df Pr(>F)    
Pillai            1    0.5348    64.96      2    113 <2e-16 ***
Wilks             1    0.4652    64.96      2    113 <2e-16 ***
Hotelling-Lawley  1    1.1498    64.96      2    113 <2e-16 ***
Roy               1    1.1498    64.96      2    113 <2e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 

------------------------------------------
 
Term: IV1 

Sum of squares and products for the hypothesis:
       Y.1    Y.2
Y.1 870.07  28.32
Y.2  28.32 988.64

Multivariate Tests: IV1
                 Df test stat approx F num Df den Df Pr(>F)    
Pillai            2    0.8551    42.57      4    228 <2e-16 ***
Wilks             2    0.3211    43.20      4    226 <2e-16 ***
Hotelling-Lawley  2    1.5654    43.83      4    224 <2e-16 ***
Roy               2    1.0354    59.02      2    114 <2e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 

------------------------------------------
 
Term: IV2 

Sum of squares and products for the hypothesis:
       Y.1   Y.2
Y.1 151.07 55.26
Y.2  55.26 20.21

Multivariate Tests: IV2
                 Df test stat approx F num Df den Df  Pr(>F)   
Pillai            1    0.1126    7.166      2    113 0.00118 **
Wilks             1    0.8874    7.166      2    113 0.00118 **
Hotelling-Lawley  1    0.1268    7.166      2    113 0.00118 **
Roy               1    0.1268    7.166      2    113 0.00118 **
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 

------------------------------------------
 
Term: IV1:IV2 

Sum of squares and products for the hypothesis:
       Y.1    Y.2
Y.1  47.37 -80.82
Y.2 -80.82 232.23

Multivariate Tests: IV1:IV2
                 Df test stat approx F num Df den Df   Pr(>F)    
Pillai            2    0.2052    6.516      4    228 5.56e-05 ***
Wilks             2    0.7971    6.784      4    226 3.57e-05 ***
Hotelling-Lawley  2    0.2517    7.047      4    224 2.32e-05 ***
Roy               2    0.2398   13.668      2    114 4.78e-06 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
```


Detach (automatically) loaded packages (if possible)
-------------------------


```r
try(detach(package:mvtnorm))
try(detach(package:car))
try(detach(package:nnet))
try(detach(package:MASS))
```


Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/multMANOVA.Rmd) - [markdown](https://github.com/dwoll/RExRepos/raw/master/md/multMANOVA.md) - [R code](https://github.com/dwoll/RExRepos/raw/master/R/multMANOVA.R) - [all posts](https://github.com/dwoll/RExRepos)
