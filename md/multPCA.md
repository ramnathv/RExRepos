Principal components analysis
=========================




Install required packages
-------------------------

[`mvtnorm`](http://cran.r-project.org/package=mvtnorm), [`psych`](http://cran.r-project.org/package=psych), [`robustbase`](http://cran.r-project.org/package=robustbase), [`pcaPP`](http://cran.r-project.org/package=pcaPP)


{% highlight r %}
wants <- c("mvtnorm", "psych", "robustbase", "pcaPP")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])
{% endhighlight %}


PCA
-------------------------
    
### Using `prcomp()`


{% highlight r %}
set.seed(1.234)
library(mvtnorm)
Sigma <- matrix(c(4, 2, 2, 3), ncol=2)
mu    <- c(1, 2)
N     <- 50
X     <- rmvnorm(N, mean=mu, sigma=Sigma)
{% endhighlight %}



{% highlight r %}
(pca <- prcomp(X))
{% endhighlight %}



{% highlight text %}
Standard deviations:
[1] 2.057 1.107

Rotation:
        PC1     PC2
[1,] 0.7182 -0.6958
[2,] 0.6958  0.7182
{% endhighlight %}



{% highlight r %}
summary(pca)
{% endhighlight %}



{% highlight text %}
Importance of components:
                         PC1   PC2
Standard deviation     2.057 1.107
Proportion of Variance 0.775 0.225
Cumulative Proportion  0.775 1.000
{% endhighlight %}



{% highlight r %}
pca$sdev^2 / sum(diag(cov(X)))
{% endhighlight %}



{% highlight text %}
[1] 0.7754 0.2246
{% endhighlight %}



{% highlight r %}
plot(pca)
{% endhighlight %}

![plot of chunk rerMultPCA01](figure/rerMultPCA01.png) 


For rotated principal components, see `principal()` from package [`psych`](http://cran.r-project.org/package=psych).

### Using `princomp()`


{% highlight r %}
(pcaPrin <- princomp(X))
{% endhighlight %}



{% highlight text %}
Call:
princomp(x = X)

Standard deviations:
Comp.1 Comp.2 
 2.036  1.096 

 2  variables and  50 observations.
{% endhighlight %}



{% highlight r %}
(G <- pcaPrin$loadings)
{% endhighlight %}



{% highlight text %}

Loadings:
     Comp.1 Comp.2
[1,] -0.718  0.696
[2,] -0.696 -0.718

               Comp.1 Comp.2
SS loadings       1.0    1.0
Proportion Var    0.5    0.5
Cumulative Var    0.5    1.0
{% endhighlight %}



{% highlight r %}
pc <- pcaPrin$scores
head(pc)
{% endhighlight %}



{% highlight text %}
      Comp.1  Comp.2
[1,]  0.8530 -0.8978
[2,]  0.9786  0.6504
[3,]  1.3111 -1.0479
[4,] -0.7210  2.3721
[5,] -2.4364 -0.8201
[6,] -1.2462 -2.3215
{% endhighlight %}


### Illustration


{% highlight r %}
Gscl <- G %*% diag(pca$sdev)
ctr  <- colMeans(X)
xMat <- rbind(ctr[1] - Gscl[1, ], ctr[1])
yMat <- rbind(ctr[2] - Gscl[2, ], ctr[2])
ab1  <- solve(cbind(1, xMat[ , 1]), yMat[ , 1])
ab2  <- solve(cbind(1, xMat[ , 2]), yMat[ , 2])
{% endhighlight %}



{% highlight r %}
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
{% endhighlight %}

![plot of chunk rerMultPCA02](figure/rerMultPCA02.png) 


### Approximate data by their principal components

#### Full reproduction using all principal components


{% highlight r %}
Hs   <- scale(pc)
BHs  <- t(Gscl %*% t(Hs))
repr <- sweep(BHs, 2, ctr, "+")
all.equal(X, repr)
{% endhighlight %}



{% highlight text %}
[1] TRUE
{% endhighlight %}



{% highlight r %}
sum((X-repr)^2)
{% endhighlight %}



{% highlight text %}
[1] 1.145e-29
{% endhighlight %}


#### Approximation using only the first principal component


{% highlight r %}
BHs1  <- t(Gscl[ , 1] %*% t(Hs[ , 1]))
repr1 <- sweep(BHs1, 2, ctr, "+")
sum((X-repr1)^2)
{% endhighlight %}



{% highlight text %}
[1] 60.04
{% endhighlight %}



{% highlight r %}
qr(scale(repr1, center=TRUE, scale=FALSE))$rank
{% endhighlight %}



{% highlight text %}
[1] 1
{% endhighlight %}



{% highlight r %}
plot(X, xlab="x", ylab="y", pch=20, asp=1, main="Data und approximation")
abline(coef=ab1, lwd=2, col="gray")
abline(coef=ab2, lwd=2, col="gray")
segments(X[ , 1], X[ , 2], repr1[ , 1], repr1[ , 2])
points(repr1, pch=1, lwd=2, col="blue", cex=2)
points(ctr[1], ctr[2], pch=16, col="red", cex=3)
legend(x="topleft", legend=c("data", "PC axes", "centroid", "approximation"),
       pch=c(20, NA, 16, 1), lty=c(NA, 1, NA, NA), lwd=c(NA, 2, NA, 2),
       col=c("black", "gray", "red", "blue"))
{% endhighlight %}

![plot of chunk rerMultPCA03](figure/rerMultPCA03.png) 


### Approximate the covariance matrix using principal components


{% highlight r %}
Gscl %*% t(Gscl)
{% endhighlight %}



{% highlight text %}
      [,1]  [,2]
[1,] 2.775 1.501
[2,] 1.501 2.680
{% endhighlight %}



{% highlight r %}
cov(X)
{% endhighlight %}



{% highlight text %}
      [,1]  [,2]
[1,] 2.775 1.501
[2,] 1.501 2.680
{% endhighlight %}



{% highlight r %}
Gscl[ , 1] %*% t(Gscl[ , 1])
{% endhighlight %}



{% highlight text %}
      [,1]  [,2]
[1,] 2.182 2.114
[2,] 2.114 2.048
{% endhighlight %}


Robust PCA
-------------------------


{% highlight r %}
library(robustbase)
princomp(X, cov=covMcd(X))
{% endhighlight %}



{% highlight text %}
Call:
princomp(x = X, covmat = covMcd(X))

Standard deviations:
Comp.1 Comp.2 
 1.870  1.298 

 2  variables and  50 observations.
{% endhighlight %}



{% highlight r %}
library(pcaPP)
PCAproj(X, k=ncol(X), method="qn")
{% endhighlight %}



{% highlight text %}
Call:
PCAproj(x = X, k = ncol(X), method = "qn")

Standard deviations:
Comp.1 Comp.2 
 1.943  1.283 

 2  variables and  50 observations.
{% endhighlight %}


Detach (automatically) loaded packages (if possible)
-------------------------


{% highlight r %}
try(detach(package:pcaPP))
try(detach(package:mvtnorm))
try(detach(package:psych))
try(detach(package:robustbase))
{% endhighlight %}


Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/multPCA.Rmd) - [markdown](https://github.com/dwoll/RExRepos/raw/master/md/multPCA.md) - [R code](https://github.com/dwoll/RExRepos/raw/master/R/multPCA.R) - [all posts](https://github.com/dwoll/RExRepos)
