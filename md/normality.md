Assess univariate and multivariate normality
=========================

Install required packages
-------------------------

[`energy`](http://cran.r-project.org/package=energy), [`ICS`](http://cran.r-project.org/package=ICS), [`mvtnorm`](http://cran.r-project.org/package=mvtnorm), [`nortest`](http://cran.r-project.org/package=nortest), [`QuantPsyc`](http://cran.r-project.org/package=QuantPsyc)


{% highlight r %}
wants <- c("energy", "ICS", "mvtnorm", "nortest", "QuantPsyc")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])
{% endhighlight %}


Univariate normality
-------------------------

### QQ-plot


{% highlight r %}
set.seed(1.234)
DV <- rnorm(20, mean=1.5, sd=3)
qqnorm(DV, pch=20, cex=2)
qqline(DV, col="gray60", lwd=2)
{% endhighlight %}

![plot of chunk rerNormality01](figure/rerNormality01.png) 


### Shapiro-Wilk-test

Composite null hypothesis: any normal distribution


{% highlight r %}
shapiro.test(DV)
{% endhighlight %}



{% highlight text %}

	Shapiro-Wilk normality test

data:  DV 
W = 0.9533, p-value = 0.4195

{% endhighlight %}


### Anderson-Darling-test

Composite null hypothesis: any normal distribution


{% highlight r %}
library(nortest)
ad.test(DV)
{% endhighlight %}



{% highlight text %}

	Anderson-Darling normality test

data:  DV 
A = 0.2918, p-value = 0.5704

{% endhighlight %}


### Cramer-von-Mises-test

Composite null hypothesis: any normal distribution


{% highlight r %}
library(nortest)
cvm.test(DV)
{% endhighlight %}



{% highlight text %}

	Cramer-von Mises normality test

data:  DV 
W = 0.0402, p-value = 0.6588

{% endhighlight %}


### Shapiro-Francia-test

Composite null hypothesis: any normal distribution


{% highlight r %}
library(nortest)
sf.test(DV)
{% endhighlight %}



{% highlight text %}

	Shapiro-Francia normality test

data:  DV 
W = 0.9475, p-value = 0.2818

{% endhighlight %}


### Jarque-Bera-test

Composite null hypothesis: any normal distribution


{% highlight r %}
library(tseries)
jarque.bera.test(DV)
{% endhighlight %}



{% highlight text %}

	Jarque Bera Test

data:  DV 
X-squared = 2.073, df = 2, p-value = 0.3547

{% endhighlight %}


### Kolmogorov-Smirnov-test

Exact null hypothesis: fully specified normal distribution


{% highlight r %}
ks.test(DV, "pnorm", mean=1, sd=2, alternative="two.sided")
{% endhighlight %}



{% highlight text %}

	One-sample Kolmogorov-Smirnov test

data:  DV 
D = 0.3216, p-value = 0.0243
alternative hypothesis: two-sided 

{% endhighlight %}


### Lilliefors-test

Composite null hypothesis: any normal distribution


{% highlight r %}
library(nortest)
lillie.test(DV)
{% endhighlight %}



{% highlight text %}

	Lilliefors (Kolmogorov-Smirnov) normality test

data:  DV 
D = 0.1105, p-value = 0.7535

{% endhighlight %}


### Pearson \(\chi^{2}\)-test

Tests weaker null hypothesis (any distribution with the same probabilities for the given class intervals).

Wrong: `pearson.test()` does not use grouped ML-estimate or maximum \(\chi^{2}\)-estimate


{% highlight r %}
library(nortest)
pearson.test(DV, n.classes=6, adjust=TRUE)
{% endhighlight %}



{% highlight text %}

	Pearson chi-square normality test

data:  DV 
P = 0.4, p-value = 0.9402

{% endhighlight %}


Multivariate normality
-------------------------

### Energy-test


{% highlight r %}
mu    <- c(2, 4, 5)
Sigma <- matrix(c(4,2,-3, 2,16,-1, -3,-1,9), byrow=TRUE, ncol=3)
library(mvtnorm)
X <- rmvnorm(100, mu, Sigma)
{% endhighlight %}



{% highlight r %}
library(energy)                    # for mvnorm.etest()
mvnorm.etest(X)
{% endhighlight %}



{% highlight text %}

	Energy test of multivariate normality: estimated parameters

data:  x, sample size 100, dimension 3, replicates 999 
E-statistic = 0.8595, p-value = 0.3944

{% endhighlight %}


### Mardia-Kurtosis-test


{% highlight r %}
library(QuantPsyc)                 # for mult.norm()
mn <- mult.norm(X, chicrit=0.001)
mn$mult.test
{% endhighlight %}



{% highlight text %}
         Beta-hat   kappa  p-val
Skewness   0.5937  9.8958 0.4497
Kurtosis  14.4587 -0.4941 0.6212
{% endhighlight %}


### Kurtosis- and skew-test

#### Kurtosis-test


{% highlight r %}
library(ICS)
mvnorm.kur.test(X)
{% endhighlight %}



{% highlight text %}

	Multivariate Normality Test Based on Kurtosis

data:  X 
W = 7.915, w1 = 1.12, df1 = 5.00, w2 = 1.60, df2 = 1.00, p-value =
0.3579

{% endhighlight %}


#### Skew-test

{% highlight r %}
library(ICS)
X <- rmvnorm(100, c(2, 4, 5))
mvnorm.skew.test(X)
{% endhighlight %}



{% highlight text %}

	Multivariate Normality Test Based on Skewness

data:  X 
U = 2.851, df = 3, p-value = 0.4151

{% endhighlight %}


Detach (automatically) loaded packages (if possible)
-------------------------


{% highlight r %}
try(detach(package:nortest))
try(detach(package:QuantPsyc))
try(detach(package:tseries))
try(detach(package:quadprog))
try(detach(package:zoo))
try(detach(package:energy))
try(detach(package:boot))
try(detach(package:MASS))
try(detach(package:ICS))
try(detach(package:mvtnorm))
try(detach(package:survey))
{% endhighlight %}


Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/normality.Rmd) - [markdown](https://github.com/dwoll/RExRepos/raw/master/md/normality.md) - [R code](https://github.com/dwoll/RExRepos/raw/master/R/normality.R) - [all posts](https://github.com/dwoll/RExRepos)
