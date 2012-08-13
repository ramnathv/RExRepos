Nonparametric location tests for one and two samples
=========================

Install required packages
-------------------------

[`coin`](http://cran.r-project.org/package=coin)


{% highlight r %}
wants <- c("coin")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])
{% endhighlight %}


One-sample
-------------------------

### Sign-test
    

{% highlight r %}
set.seed(1.234)
medH0 <- 30
DV    <- sample(0:100, 20, replace=TRUE)
DV    <- DV[DV != medH0]
N     <- length(DV)
(obs  <- sum(DV > medH0))
{% endhighlight %}



{% highlight text %}
[1] 15
{% endhighlight %}



{% highlight r %}
(pGreater <- 1-pbinom(obs-1, N, 0.5))
{% endhighlight %}



{% highlight text %}
[1] 0.02069
{% endhighlight %}



{% highlight r %}
(pTwoSided <- 2 * pGreater)
{% endhighlight %}



{% highlight text %}
[1] 0.04139
{% endhighlight %}


### Wilcoxon signed rank test


{% highlight r %}
IQ    <- c(99, 131, 118, 112, 128, 136, 120, 107, 134, 122)
medH0 <- 110
{% endhighlight %}



{% highlight r %}
wilcox.test(IQ, alternative="greater", mu=medH0, conf.int=TRUE)
{% endhighlight %}



{% highlight text %}

	Wilcoxon signed rank test

data:  IQ 
V = 48, p-value = 0.01855
alternative hypothesis: true location is greater than 110 
95 percent confidence interval:
 113.5   Inf 
sample estimates:
(pseudo)median 
           121 

{% endhighlight %}


Two independent samples
-------------------------

### Sign-test


{% highlight r %}
Nj  <- c(20, 30)
DVa <- rnorm(Nj[1], mean= 95, sd=15)
DVb <- rnorm(Nj[2], mean=100, sd=15)
wIndDf <- data.frame(DV=c(DVa, DVb),
                     IV=factor(rep(1:2, Nj), labels=LETTERS[1:2]))
{% endhighlight %}


Looks at the number of cases in each group which are below or above the median of the combined data.


{% highlight r %}
library(coin)
median_test(DV ~ IV, distribution="exact", data=wIndDf)
{% endhighlight %}



{% highlight text %}

	Exact Median Test

data:  DV by IV (A, B) 
Z = 0, p-value = 1
alternative hypothesis: true mu is not equal to 0 

{% endhighlight %}


### Wilcoxon rank-sum test (\(=\) Mann-Whitney \(U\)-test)


{% highlight r %}
wilcox.test(DV ~ IV, alternative="less", conf.int=TRUE, data=wIndDf)
{% endhighlight %}



{% highlight text %}

	Wilcoxon rank sum test

data:  DV by IV 
W = 246, p-value = 0.1462
alternative hypothesis: true location shift is less than 0 
95 percent confidence interval:
  -Inf 2.159 
sample estimates:
difference in location 
                -4.021 

{% endhighlight %}



{% highlight r %}
library(coin)
wilcox_test(DV ~ IV, alternative="less", conf.int=TRUE,
            distribution="exact", data=wIndDf)
{% endhighlight %}



{% highlight text %}

	Exact Wilcoxon Mann-Whitney Rank Sum Test

data:  DV by IV (A, B) 
Z = -1.069, p-value = 0.1462
alternative hypothesis: true mu is less than 0 
95 percent confidence interval:
  -Inf 2.159 
sample estimates:
difference in location 
                -4.021 

{% endhighlight %}


Two dependent samples
-------------------------

### Sign-test


{% highlight r %}
N      <- 20
DVpre  <- rnorm(N, mean= 95, sd=15)
DVpost <- rnorm(N, mean=100, sd=15)
wDepDf <- data.frame(id=factor(rep(1:N, times=2)),
                     DV=c(DVpre, DVpost),
                     IV=factor(rep(0:1, each=N), labels=c("pre", "post")))
{% endhighlight %}



{% highlight r %}
medH0  <- 0
DVdiff <- aggregate(DV ~ id, FUN=diff, data=wDepDf)
(obs   <- sum(DVdiff$DV < medH0))
{% endhighlight %}



{% highlight text %}
[1] 8
{% endhighlight %}



{% highlight r %}
(pLess <- pbinom(obs, N, 0.5))
{% endhighlight %}



{% highlight text %}
[1] 0.2517
{% endhighlight %}


### Wilcoxon signed rank test


{% highlight r %}
wilcoxsign_test(DV ~ IV | id, alternative="greater",
                distribution="exact", data=wDepDf)
{% endhighlight %}



{% highlight text %}

	Exact Wilcoxon-Signed-Rank Test

data:  y by x (neg, pos) 
	 stratified by block 
Z = 0.8213, p-value = 0.2152
alternative hypothesis: true mu is greater than 0 

{% endhighlight %}


Detach (automatically) loaded packages (if possible)
-------------------------


{% highlight r %}
try(detach(package:coin))
try(detach(package:modeltools))
try(detach(package:survival))
try(detach(package:mvtnorm))
try(detach(package:splines))
try(detach(package:stats4))
{% endhighlight %}


Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/npWilcoxon.Rmd) - [markdown](https://github.com/dwoll/RExRepos/raw/master/md/npWilcoxon.md) - [R code](https://github.com/dwoll/RExRepos/raw/master/R/npWilcoxon.R) - [all posts](https://github.com/dwoll/RExRepos)
