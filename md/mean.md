The mean and other location measures
=========================

TODO
-------------------------

 - link to npWilcoxon for `wilcox.test()`

Install required packages
-------------------------

[`modeest`](http://cran.r-project.org/package=modeest), [`psych`](http://cran.r-project.org/package=psych), [`robustbase`](http://cran.r-project.org/package=robustbase)


{% highlight r %}
wants <- c("modeest", "psych", "robustbase")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])
{% endhighlight %}


Mean, weighted mean, geometric mean, harmonic mean, and mode
-------------------------

### Mean


{% highlight r %}
age <- c(17, 30, 30, 25, 23, 21)
mean(age)
{% endhighlight %}



{% highlight text %}
[1] 24.33
{% endhighlight %}


### Weighted mean


{% highlight r %}
weights <- c(0.6, 0.6, 0.3, 0.2, 0.4, 0.6)
weighted.mean(age, weights)
{% endhighlight %}



{% highlight text %}
[1] 23.7
{% endhighlight %}


### Geometric mean


{% highlight r %}
library(psych)
geometric.mean(age)
{% endhighlight %}



{% highlight text %}
[1] 23.87
{% endhighlight %}


### Harmonic mean


{% highlight r %}
library(psych)
harmonic.mean(age)
{% endhighlight %}



{% highlight text %}
[1] 23.38
{% endhighlight %}


### Mode


{% highlight r %}
vec <- c(11, 22, 22, 33, 33, 33, 33)
library(modeest)
mfv(vec)
{% endhighlight %}



{% highlight text %}
[1] 33
{% endhighlight %}



{% highlight r %}
mlv(vec, method="mfv")
{% endhighlight %}



{% highlight text %}
Mode (most likely value): 33 
Bickel's modal skewness: -0.4286 
Call: mlv.default(x = vec, method = "mfv") 
{% endhighlight %}


Robust location measures
-------------------------

### Median


{% highlight r %}
median(age)
{% endhighlight %}



{% highlight text %}
[1] 24
{% endhighlight %}


### Trimmed mean


{% highlight r %}
mean(age, trim=0.2)
{% endhighlight %}



{% highlight text %}
[1] 24.75
{% endhighlight %}


### Winsorized mean


{% highlight r %}
library(psych)
(ageWins <- winsor(age, trim=0.2))
{% endhighlight %}



{% highlight text %}
[1] 21 30 30 25 23 21
{% endhighlight %}



{% highlight r %}
mean(ageWins)
{% endhighlight %}



{% highlight text %}
[1] 25
{% endhighlight %}


### Huber-\(M\) estimator


{% highlight r %}
library(robustbase)
hM <- huberM(age)
hM$mu
{% endhighlight %}



{% highlight text %}
[1] 24.33
{% endhighlight %}


### Hodges-Lehmann estimator (pseudo-median)


{% highlight r %}
wilcox.test(age, conf.int=TRUE)$estimate
{% endhighlight %}



{% highlight text %}
(pseudo)median 
            24 
{% endhighlight %}


### Hodges-Lehmann estimator of difference between two location parameters


{% highlight r %}
N <- 8
X <- rnorm(N, 100, 15)
Y <- rnorm(N, 110, 15)
wilcox.test(X, Y, conf.int=TRUE)$estimate
{% endhighlight %}



{% highlight text %}
difference in location 
                -16.05 
{% endhighlight %}


Detach (automatically) loaded packages (if possible)
-------------------------


{% highlight r %}
try(detach(package:modeest))
try(detach(package:psych))
try(detach(package:robustbase))
{% endhighlight %}


Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/mean.Rmd) - [markdown](https://github.com/dwoll/RExRepos/raw/master/md/mean.md) - [R code](https://github.com/dwoll/RExRepos/raw/master/R/mean.R) - [all posts](https://github.com/dwoll/RExRepos)
