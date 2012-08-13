Association tests and measures for ordered categorical variables
=========================




TODO
-------------------------

 - link to correlation, association, diagCategorical

Install required packages
-------------------------

[`coin`](http://cran.r-project.org/package=coin), [`mvtnorm`](http://cran.r-project.org/package=mvtnorm), [`polycor`](http://cran.r-project.org/package=polycor), [`rms`](http://cran.r-project.org/package=rms), [`ROCR`](http://cran.r-project.org/package=ROCR)


{% highlight r %}
wants <- c("coin", "mvtnorm", "polycor", "rms", "ROCR")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])
{% endhighlight %}


Linear-by-linear association test
-------------------------


{% highlight r %}
set.seed(1.234)
library(mvtnorm)
N     <- 100
Sigma <- matrix(c(4,2,-3, 2,16,-1, -3,-1,9), byrow=TRUE, ncol=3)
mu    <- c(-3, 2, 4)
Xdf   <- data.frame(rmvnorm(n=N, mean=mu, sigma=Sigma))
{% endhighlight %}



{% highlight r %}
lOrd   <- lapply(Xdf, function(x) {
                 cut(x, breaks=quantile(x), include.lowest=TRUE,
                     ordered=TRUE, labels=LETTERS[1:4]) })
dfOrd  <- data.frame(lOrd)
matOrd <- data.matrix(dfOrd)
{% endhighlight %}



{% highlight r %}
cTab <- xtabs(~ X1 + X3, data=dfOrd)
addmargins(cTab)
{% endhighlight %}



{% highlight text %}
     X3
X1      A   B   C   D Sum
  A     2   3   9  11  25
  B     1  10   6   8  25
  C     9   6   7   3  25
  D    13   6   3   3  25
  Sum  25  25  25  25 100
{% endhighlight %}



{% highlight r %}
library(coin)
lbl_test(cTab, distribution=approximate(B=9999))
{% endhighlight %}



{% highlight text %}

	Approximative Linear-by-Linear Association Test

data:  X3 (ordered) by X1 (A < B < C < D) 
chi-squared = 21.31, p-value < 2.2e-16

{% endhighlight %}


Polychoric and polyserial correlation
-------------------------

### Polychoric correlation


{% highlight r %}
library(polycor)
polychor(dfOrd$X1, dfOrd$X2, ML=TRUE)
{% endhighlight %}



{% highlight text %}
[1] 0.3249
{% endhighlight %}



{% highlight r %}
polychor(cTab, ML=TRUE)
{% endhighlight %}



{% highlight text %}
[1] -0.5237
{% endhighlight %}


### Polyserial correlation


{% highlight r %}
library(polycor)
polyserial(Xdf$X2, dfOrd$X3)
{% endhighlight %}



{% highlight text %}
[1] -0.1641
{% endhighlight %}


### Heterogeneous correlation matrices


{% highlight r %}
library(polycor)
Xdf2   <- rmvnorm(n=N, mean=mu, sigma=Sigma)
dfBoth <- cbind(Xdf2, dfOrd)
hetcor(dfBoth, ML=TRUE)
{% endhighlight %}



{% highlight text %}

Maximum-Likelihood Estimates

Correlations/Type of Correlation:
         1       2        3         X1         X2         X3
1        1 Pearson  Pearson Polyserial Polyserial Polyserial
2    0.488       1  Pearson Polyserial Polyserial Polyserial
3   -0.391 0.00279        1 Polyserial Polyserial Polyserial
X1  0.0528 -0.0529   -0.135          1 Polychoric Polychoric
X2 -0.0822  0.0177 -0.00729      0.325          1 Polychoric
X3  0.0249  0.0475    0.126     -0.524     -0.201          1

Standard Errors:
        1     2     3     X1    X2
1                                 
2  0.0766                         
3  0.0851   0.1                   
X1  0.106 0.107 0.107             
X2  0.108 0.109 0.108  0.106      
X3  0.108 0.107 0.107 0.0882 0.114

n = 100 

P-values for Tests of Bivariate Normality:
       1     2     3    X1    X2
1                               
2  0.407                        
3  0.555 0.933                  
X1 0.402 0.507 0.343            
X2   0.3 0.723 0.353 0.762      
X3 0.816 0.339 0.767 0.333 0.462
{% endhighlight %}


Association measures involving categorical and continuous variables
-------------------------

### AUC, Kendall's \(\tau_{a}\), Somers' \(D_{xy}\), Goodman & Kruskal's \(\gamma\)

One continuous variable and one dichotomous variable


{% highlight r %}
N   <- 100
x   <- rnorm(N)
y   <- x + rnorm(N, 0, 2)
yDi <- ifelse(y <= median(y), 0, 1)
{% endhighlight %}



{% highlight r %}
library(rms)
lrm(yDi ~ x)$stats
{% endhighlight %}



{% highlight text %}
       Obs  Max Deriv Model L.R.       d.f.          P          C 
 1.000e+02  2.617e-09  2.877e+00  1.000e+00  8.985e-02  6.010e-01 
       Dxy      Gamma      Tau-a         R2      Brier          g 
 2.020e-01  2.034e-01  1.020e-01  3.781e-02  2.429e-01  3.931e-01 
        gr         gp 
 1.482e+00  9.588e-02 
{% endhighlight %}


### Area under the Curve (AUC)

Package `ROCR` works with S4 objects -> different method to extract components


{% highlight r %}
library(ROCR)
pred <- prediction(x, yDi)
(AUC <- performance(pred, measure="auc")@y.values[[1]])
{% endhighlight %}



{% highlight text %}
[1] 0.6012
{% endhighlight %}



{% highlight r %}
perf <- performance(pred, measure="tpr", x.measure="fpr")
plot(perf, col=rainbow(10), lwd=3, main="ROC-Curve, AUC", asp=1,
     xlim=c(0,1), ylim=c(0,1))
abline(a=0, b=1)
{% endhighlight %}

![plot of chunk rerAssociationOrder01](figure/rerAssociationOrder01.png) 


Detach (automatically) loaded packages (if possible)
-------------------------


{% highlight r %}
try(detach(package:ROCR))
try(detach(package:gplots))
try(detach(package:gtools))
try(detach(package:gdata))
try(detach(package:caTools))
try(detach(package:bitops))
try(detach(package:grid))
try(detach(package:KernSmooth))
try(detach(package:rms))
try(detach(package:Hmisc))
try(detach(package:polycor))
try(detach(package:sfsmisc))
try(detach(package:MASS))
try(detach(package:coin))
try(detach(package:modeltools))
try(detach(package:survival))
try(detach(package:mvtnorm))
try(detach(package:splines))
try(detach(package:stats4))
{% endhighlight %}


Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/associationOrder.Rmd) - [markdown](https://github.com/dwoll/RExRepos/raw/master/md/associationOrder.md) - [R code](https://github.com/dwoll/RExRepos/raw/master/R/associationOrder.R) - [all posts](https://github.com/dwoll/RExRepos)
