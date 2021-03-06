Variance homogeneity in two or more groups
=========================

TODO
-------------------------

 - link to variance

Install required packages
-------------------------

[`car`](http://cran.r-project.org/package=car), [`coin`](http://cran.r-project.org/package=coin)


```r
wants <- c("car", "coin")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])
```


Compare two groups
-------------------------

### Boxplot with added stripchart


```r
set.seed(1.234)
P     <- 2
Nj    <- c(50, 40)
DV1   <- rnorm(Nj[1], mean=100, sd=15)
DV2   <- rnorm(Nj[2], mean=100, sd=13)
varDf <- data.frame(DV=c(DV1, DV2),
                    IV=factor(rep(1:P, Nj)))
```



```r
boxplot(DV ~ IV, data=varDf)
stripchart(DV ~ IV, data=varDf, pch=16, vert=TRUE, add=TRUE)
```

![plot of chunk rerVarHom01](figure/rerVarHom01.png) 


### \(F\)-test for variance ratio in two groups


```r
var.test(DV1, DV2)
```



```r
var.test(DV ~ IV, data=varDf)
```

```

	F test to compare two variances

data:  DV by IV 
F = 0.9965, num df = 49, denom df = 39, p-value = 0.9816
alternative hypothesis: true ratio of variances is not equal to 1 
95 percent confidence interval:
 0.5397 1.8019 
sample estimates:
ratio of variances 
            0.9965 

```


### Mood-test for two groups (nonparametric)


```r
mood.test(DV ~ IV, alternative="greater", data=varDf)
```

```

	Mood two-sample test of scale

data:  DV by IV 
Z = 0.1659, p-value = 0.4341
alternative hypothesis: greater 

```


### Ansari-Bradley-test for two groups (nonparametric)


```r
ansari.test(DV ~ IV, alternative="greater", exact=FALSE, data=varDf)
```

```

	Ansari-Bradley test

data:  DV by IV 
AB = 1110, p-value = 0.2579
alternative hypothesis: true ratio of scales is greater than 1 

```



```r
library(coin)
ansari_test(DV ~ IV, alternative="greater", distribution="exact", data=varDf)
```

```

	Exact Ansari-Bradley Test

data:  DV by IV (1, 2) 
Z = -0.6497, p-value = 0.2615
alternative hypothesis: true mu is less than 1 

```


Compare more than two groups
-------------------------

### Boxplot with added stripchart


```r
Nj    <- c(22, 18, 20)
N     <- sum(Nj)
P     <- length(Nj)
levDf <- data.frame(DV=sample(0:100, N, replace=TRUE),
                    IV=factor(rep(1:P, Nj)))
```



```r
boxplot(DV ~ IV, data=levDf)
stripchart(DV ~ IV, data=levDf, pch=20, vert=TRUE, add=TRUE)
```

![plot of chunk rerVarHom02](figure/rerVarHom02.png) 


### Levene-test


```r
library(car)
leveneTest(DV ~ IV, center=median, data=levDf)
```

```
Levene's Test for Homogeneity of Variance (center = median)
      Df F value Pr(>F)  
group  2    2.48  0.093 .
      57                 
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
```

```r
leveneTest(DV ~ IV, center=mean, data=levDf)
```

```
Levene's Test for Homogeneity of Variance (center = mean)
      Df F value Pr(>F)  
group  2    2.43  0.097 .
      57                 
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
```


### Fligner-Killeen-test


```r
fligner.test(DV ~ IV, data=levDf)
```

```

	Fligner-Killeen test of homogeneity of variances

data:  DV by IV 
Fligner-Killeen:med chi-squared = 2.719, df = 2, p-value = 0.2568

```



```r
library(coin)
fligner_test(DV ~ IV, distribution=approximate(B=9999), data=levDf)
```

```

	Approximative Fligner-Killeen Test

data:  DV by IV (1, 2, 3) 
chi-squared = 2.719, p-value = 0.2567

```


Detach (automatically) loaded packages (if possible)
-------------------------


```r
try(detach(package:car))
try(detach(package:nnet))
try(detach(package:MASS))
try(detach(package:coin))
try(detach(package:modeltools))
try(detach(package:survival))
try(detach(package:mvtnorm))
try(detach(package:splines))
try(detach(package:stats4))
```


Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/varianceHom.Rmd) - [markdown](https://github.com/dwoll/RExRepos/raw/master/md/varianceHom.md) - [R code](https://github.com/dwoll/RExRepos/raw/master/R/varianceHom.R) - [all posts](https://github.com/dwoll/RExRepos)
