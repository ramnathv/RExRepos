Principal components analysis
=========================




Install required packages
-------------------------

[`mvtnorm`](http://cran.r-project.org/package=mvtnorm), [`psych`](http://cran.r-project.org/package=psych), [`robustbase`](http://cran.r-project.org/package=robustbase), [`pcaPP`](http://cran.r-project.org/package=pcaPP)


```r
wants <- c("mvtnorm", "psych", "robustbase", "pcaPP")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])
```


PCA
-------------------------
    
### Using `prcomp()`


```r
set.seed(1.234)
library(mvtnorm)
Sigma <- matrix(c(4, 2, 2, 3), ncol=2)
mu    <- c(1, 2)
N     <- 50
X     <- rmvnorm(N, mean=mu, sigma=Sigma)
```



```r
(pca <- prcomp(X))
```

```
Standard deviations:
[1] 2.057 1.107

Rotation:
        PC1     PC2
[1,] 0.7182 -0.6958
[2,] 0.6958  0.7182
```



```r
summary(pca)
```

```
Importance of components:
                         PC1   PC2
Standard deviation     2.057 1.107
Proportion of Variance 0.775 0.225
Cumulative Proportion  0.775 1.000
```

```r
pca$sdev^2 / sum(diag(cov(X)))
```

```
[1] 0.7754 0.2246
```



```r
plot(pca)
```

![plot of chunk rerMultPCA01](figure/rerMultPCA01.png) 


For rotated principal components, see `principal()` from package `psych`.

### Using `princomp()`


```r
(pcaPrin <- princomp(X))
```

```
Call:
princomp(x = X)

Standard deviations:
Comp.1 Comp.2 
 2.036  1.096 

 2  variables and  50 observations.
```

```r
(G <- pcaPrin$loadings)
```

```

Loadings:
     Comp.1 Comp.2
[1,] -0.718  0.696
[2,] -0.696 -0.718

               Comp.1 Comp.2
SS loadings       1.0    1.0
Proportion Var    0.5    0.5
Cumulative Var    0.5    1.0
```

```r
pc <- pcaPrin$scores
head(pc)
```

```
      Comp.1  Comp.2
[1,]  0.8530 -0.8978
[2,]  0.9786  0.6504
[3,]  1.3111 -1.0479
[4,] -0.7210  2.3721
[5,] -2.4364 -0.8201
[6,] -1.2462 -2.3215
```


### Illustration


```r
Gscl <- G %*% diag(pca$sdev)
ctr  <- colMeans(X)
xMat <- rbind(ctr[1] - Gscl[1, ], ctr[1])
yMat <- rbind(ctr[2] - Gscl[2, ], ctr[2])
ab1  <- solve(cbind(1, xMat[ , 1]), yMat[ , 1])
ab2  <- solve(cbind(1, xMat[ , 2]), yMat[ , 2])
```



```r
par(lend=1)
plot(X, xlab="x", ylab="y", pch=20, asp=1,
     main="Data und principal components")
abline(coef=ab1, lwd=2, col="gray")
abline(coef=ab2, lwd=2, col="gray")
matlines(xMat, yMat, lty=1, lwd=6, col="blue")
points(ctr[1], ctr[2], pch=16, col="red", cex=3)
legend(x="topleft", legend=c("data", "PC axes", "SDs of PC", "centroid"),
       pch=c(20, NA, NA, 16), lty=c(NA, 1, 1, NA), lwd=c(NA, 2, 2, NA),
       col=c("black", "gray", "blue", "red"))
```

![plot of chunk rerMultPCA02](figure/rerMultPCA02.png) 


### Approximate data by their principal components
#### Full reproduction using all principal components


```r
Hs   <- scale(pc)
BHs  <- t(Gscl %*% t(Hs))
repr <- sweep(BHs, 2, ctr, "+")
all.equal(X, repr)
```

```
[1] TRUE
```

```r
sum((X-repr)^2)
```

```
[1] 1.145e-29
```


#### Approximation using only the first principal component


```r
BHs1  <- t(Gscl[ , 1] %*% t(Hs[ , 1]))
repr1 <- sweep(BHs1, 2, ctr, "+")
sum((X-repr1)^2)
```

```
[1] 60.04
```

```r
qr(scale(repr1, center=TRUE, scale=FALSE))$rank
```

```
[1] 1
```



```r
plot(X, xlab="x", ylab="y", pch=20, asp=1, main="Data und approximation")
abline(coef=ab1, lwd=2, col="gray")
abline(coef=ab2, lwd=2, col="gray")
segments(X[ , 1], X[ , 2], repr1[ , 1], repr1[ , 2])
points(repr1, pch=1, lwd=2, col="blue", cex=2)
points(ctr[1], ctr[2], pch=16, col="red", cex=3)
legend(x="topleft", legend=c("data", "PC axes", "centroid", "approximation"),
       pch=c(20, NA, 16, 1), lty=c(NA, 1, NA, NA), lwd=c(NA, 2, NA, 2),
       col=c("black", "gray", "red", "blue"))
```

![plot of chunk rerMultPCA03](figure/rerMultPCA03.png) 


### Approximate the covariance matrix using principal components


```r
Gscl %*% t(Gscl)
```

```
      [,1]  [,2]
[1,] 2.775 1.501
[2,] 1.501 2.680
```

```r
cov(X)
```

```
      [,1]  [,2]
[1,] 2.775 1.501
[2,] 1.501 2.680
```

```r
Gscl[ , 1] %*% t(Gscl[ , 1])
```

```
      [,1]  [,2]
[1,] 2.182 2.114
[2,] 2.114 2.048
```


Robust PCA
-------------------------


```r
library(robustbase)
princomp(X, cov=covMcd(X))
```

```
Call:
princomp(x = X, covmat = covMcd(X))

Standard deviations:
Comp.1 Comp.2 
 1.870  1.298 

 2  variables and  50 observations.
```



```r
library(pcaPP)
PCAproj(X, k=ncol(X), method="qn")
```

```
Call:
PCAproj(x = X, k = ncol(X), method = "qn")

Standard deviations:
Comp.1 Comp.2 
 1.943  1.283 

 2  variables and  50 observations.
```


Detach (automatically) loaded packages (if possible)
-------------------------


```r
try(detach(package:pcaPP))
try(detach(package:mvtnorm))
try(detach(package:psych))
try(detach(package:robustbase))
```


Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/multPCA.Rmd) | [markdown](https://github.com/dwoll/RExRepos/raw/master/md/multPCA.md) | [R code](https://github.com/dwoll/RExRepos/raw/master/R/multPCA.R) - ([all posts](https://github.com/dwoll/RExRepos))

Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/multPCA.Rmd) | [markdown](https://github.com/dwoll/RExRepos/raw/master/md/multPCA.md) | [R code](https://github.com/dwoll/RExRepos/raw/master/R/multPCA.R) - ([all posts](https://github.com/dwoll/RExRepos))
