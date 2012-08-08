Binary logistic regression
=========================

TODO
-------------------------

 - link to associationOrder for `ROCR`, regressionOrdinal, regressionMultinom, regressionDiag for outliers, collinearity, crossvalidation

Install required packages
-------------------------

[`rms`](http://cran.r-project.org/package=rms)


```r
wants <- c("rms")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])
```


Descriptive model fit
-------------------------

### Simulate data
    

```r
set.seed(1.234)
N      <- 100
X1     <- rnorm(N, 175, 7)
X2     <- rnorm(N,  30, 8)
Y      <- 0.5*X1 - 0.3*X2 + 10 + rnorm(N, 0, 6)
Yfac   <- cut(Y, breaks=c(-Inf, median(Y), Inf), labels=c("lo", "hi"))
dfRegr <- data.frame(X1, X2, Yfac)
```



```r
cdplot(Yfac ~ X1, data=dfRegr)
```

![plot of chunk rerRegressionLogistic01](figure/rerRegressionLogistic011.png) 

```r
cdplot(Yfac ~ X2, data=dfRegr)
```

![plot of chunk rerRegressionLogistic01](figure/rerRegressionLogistic012.png) 


### Fit the model


```r
(glmFit <- glm(Yfac ~ X1 + X2,
               family=binomial(link="logit"), data=dfRegr))
```

```

Call:  glm(formula = Yfac ~ X1 + X2, family = binomial(link = "logit"), 
    data = dfRegr)

Coefficients:
(Intercept)           X1           X2  
    -19.485        0.137       -0.154  

Degrees of Freedom: 99 Total (i.e. Null);  97 Residual
Null Deviance:	    139 
Residual Deviance: 106 	AIC: 112 
```



```r
exp(coef(glmFit))
```

```
(Intercept)          X1          X2 
  3.451e-09   1.147e+00   8.575e-01 
```

```r
exp(confint(glmFit))
```

```
                2.5 %  97.5 %
(Intercept) 7.249e-16 0.00239
X1          1.060e+00 1.25564
X2          7.870e-01 0.92066
```


### Fit the model based on a matrix of counts


```r
total  <- sample(40:60, N, replace=TRUE)      ## unequal n_i
hits   <- rbinom(N, size=total, prob=0.4)
hitMat <- cbind(hits, total-hits)
glm(hitMat ~ X1 + X2, family=binomial(link="logit"))
```

```

Call:  glm(formula = hitMat ~ X1 + X2, family = binomial(link = "logit"))

Coefficients:
(Intercept)           X1           X2  
   -0.12761     -0.00188      0.00166  

Degrees of Freedom: 99 Total (i.e. Null);  97 Residual
Null Deviance:	    105 
Residual Deviance: 105 	AIC: 542 
```


### Fit the model based on a matrix with relative frequencies


```r
hitMatRel <- sweep(hitMat, 1, total, "/")
glm(hitMatRel ~ X1 + X2, weights=total, family=binomial(link="logit"))
```

```

Call:  glm(formula = hitMatRel ~ X1 + X2, family = binomial(link = "logit"), 
    weights = total)

Coefficients:
(Intercept)           X1           X2  
   -0.12761     -0.00188      0.00166  

Degrees of Freedom: 99 Total (i.e. Null);  97 Residual
Null Deviance:	    105 
Residual Deviance: 105 	AIC: 542 
```


### Fitted logits and probabilities


```r
logitHat <- predict(glmFit, type="link")
plot(logitHat, pch=c(1, 16)[unclass(dfRegr$Yfac)])
abline(h=0)
```

![plot of chunk rerRegressionLogistic02](figure/rerRegressionLogistic02.png) 



```r
Phat <- fitted(glmFit)
Phat <- predict(glmFit, type="response")
head(Phat)
```

```
      1       2       3       4       5       6 
0.49807 0.48815 0.53732 0.76152 0.72098 0.04186 
```

```r
mean(Phat)
```

```
[1] 0.5
```

```r
prop.table(table(dfRegr$Yfac))
```

```

 lo  hi 
0.5 0.5 
```


Assess model fit
-------------------------

### Classification table


```r
thresh <- 0.5
Yhat   <- cut(Phat, breaks=c(-Inf, thresh, Inf), labels=c("lo", "hi"))
cTab   <- table(Yfac, Yhat)
addmargins(cTab)
```

```
     Yhat
Yfac   lo  hi Sum
  lo   34  16  50
  hi   13  37  50
  Sum  47  53 100
```

```r
sum(diag(cTab)) / sum(cTab)
```

```
[1] 0.71
```


### log-Likelihood, AUC, Somers's \(D_{xy}\), Nagelkerke's pseudo \(R^{2}\)


```r
logLik(glmFit)
```

```
'log Lik.' -53.25 (df=3)
```



```r
library(rms)
lrm(Yfac ~ X1 + X2, data=dfRegr)
```

```

Logistic Regression Model

lrm(formula = Yfac ~ X1 + X2, data = dfRegr)

                      Model Likelihood     Discrimination    Rank Discrim.    
                         Ratio Test            Indexes          Indexes       
Obs           100    LR chi2      32.14    R2       0.366    C       0.808    
 lo            50    d.f.             2    g        1.658    Dxy     0.616    
 hi            50    Pr(> chi2) <0.0001    gr       5.251    gamma   0.617    
max |deriv| 7e-10                          gp       0.309    tau-a   0.311    
                                           Brier    0.179                     

          Coef     S.E.   Wald Z Pr(>|Z|)
Intercept -19.4847 7.2768 -2.68  0.0074  
X1          0.1367 0.0427  3.21  0.0013  
X2         -0.1538 0.0396 -3.88  0.0001  

```


For plotting the ROC-curve, see `ROCR` in associationOrder

### McFadden and Cox & Snell seudo \(R^{2}\)

McFadden pseudo-\(R^2\)


```r
glmFit0 <- update(glmFit, . ~ 1)
LLf <- logLik(glmFit)
LL0 <- logLik(glmFit0)
as.vector(1 - (LLf / LL0))
```

```
[1] 0.2318
```


Cox & Snell


```r
as.vector(1 - exp((2/N) * (LL0 - LLf)))
```

```
[1] 0.2749
```


Nagelkerke


```r
as.vector((1 - exp((2/N) * (LL0 - LLf))) / (1 - exp(LL0)^(2/N)))
```

```
[1] 0.3665
```


### Crossvalidation

`cv.glm()` function from package `boot`, see crossvalidation

Coefficient tests and overall model test
-------------------------

### Individual coefficient tests


```r
summary(glmFit)
```

```

Call:
glm(formula = Yfac ~ X1 + X2, family = binomial(link = "logit"), 
    data = dfRegr)

Deviance Residuals: 
    Min       1Q   Median       3Q      Max  
-1.7693  -0.9053   0.0086   0.9246   2.5193  

Coefficients:
            Estimate Std. Error z value Pr(>|z|)    
(Intercept) -19.4847     7.2767   -2.68   0.0074 ** 
X1            0.1367     0.0427    3.21   0.0013 ** 
X2           -0.1538     0.0396   -3.88   0.0001 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 138.63  on 99  degrees of freedom
Residual deviance: 106.49  on 97  degrees of freedom
AIC: 112.5

Number of Fisher Scoring iterations: 4

```



```r
lrm(Yfac ~ X1 + X2, data=dfRegr)
```



### Model comparisons


```r
anova(glmFit0, glmFit, test="Chisq")
```

```
Analysis of Deviance Table

Model 1: Yfac ~ 1
Model 2: Yfac ~ X1 + X2
  Resid. Df Resid. Dev Df Deviance Pr(>Chi)    
1        99        139                         
2        97        106  2     32.1  1.1e-07 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
```



```r
lrm(Yfac ~ X1 + X2, data=dfRegr)
```



```r
drop1(glmFit, test="Chi")
```

```
Single term deletions

Model:
Yfac ~ X1 + X2
       Df Deviance AIC  LRT Pr(>Chi)    
<none>         106 112                  
X1      1      119 123 12.8  0.00035 ***
X2      1      128 132 21.5  3.5e-06 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
```


Detach (automatically) loaded packages (if possible)
-------------------------


```r
try(detach(package:rms))
try(detach(package:survival))
try(detach(package:splines))
```


Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/regressionLogistic.Rmd) - [markdown](https://github.com/dwoll/RExRepos/raw/master/md/regressionLogistic.md) - [R code](https://github.com/dwoll/RExRepos/raw/master/R/regressionLogistic.R) - [all posts](https://github.com/dwoll/RExRepos)
