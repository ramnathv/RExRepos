Variance, other spread measures, skewness and kurtosis
=========================

TODO
-------------------------

 - link to diagDistributions, varianceHom

Install required packages
-------------------------

[`e1071`](http://cran.r-project.org/package=e1071), [`psych`](http://cran.r-project.org/package=psych), [`robustbase`](http://cran.r-project.org/package=robustbase), [`vegan`](http://cran.r-project.org/package=vegan)


{% highlight r %}
wants <- c("e1071", "psych", "robustbase", "vegan")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])
{% endhighlight %}


Variance and standard deviation
-------------------------

### Corrected (sample) variance and standard deviation


{% highlight r %}
age <- c(17, 30, 30, 25, 23, 21)
N   <- length(age)
M   <- mean(age)
var(age)
{% endhighlight %}



{% highlight text %}
[1] 26.27
{% endhighlight %}



{% highlight r %}
sd(age)
{% endhighlight %}



{% highlight text %}
[1] 5.125
{% endhighlight %}


### Uncorrected (population) variance and standard deviation


{% highlight r %}
(cML <- cov.wt(as.matrix(age), method="ML"))
{% endhighlight %}



{% highlight text %}
$cov
      [,1]
[1,] 21.89

$center
[1] 24.33

$n.obs
[1] 6

{% endhighlight %}



{% highlight r %}
(vML <- diag(cML$cov))
{% endhighlight %}



{% highlight text %}
[1] 21.89
{% endhighlight %}



{% highlight r %}
sqrt(vML)
{% endhighlight %}



{% highlight text %}
[1] 4.679
{% endhighlight %}


Robust spread measures
-------------------------

### Winsorized variance and standard deviation


{% highlight r %}
library(psych)
ageWins <- winsor(age, trim=0.2)
var(ageWins)
{% endhighlight %}



{% highlight text %}
[1] 17.2
{% endhighlight %}



{% highlight r %}
sd(ageWins)
{% endhighlight %}



{% highlight text %}
[1] 4.147
{% endhighlight %}


### Inter-quartile-range


{% highlight r %}
quantile(age)
{% endhighlight %}



{% highlight text %}
   0%   25%   50%   75%  100% 
17.00 21.50 24.00 28.75 30.00 
{% endhighlight %}



{% highlight r %}
IQR(age)
{% endhighlight %}



{% highlight text %}
[1] 7.25
{% endhighlight %}

### Mean absolute difference to the median


{% highlight r %}
mean(abs(age-median(age)))
{% endhighlight %}



{% highlight text %}
[1] 4
{% endhighlight %}


### Median absolute difference to the median (MAD)


{% highlight r %}
mad(age)
{% endhighlight %}



{% highlight text %}
[1] 6.672
{% endhighlight %}


### \(Q_{n}\): more efficient alternative to MAD


{% highlight r %}
library(robustbase)
Qn(age)
{% endhighlight %}



{% highlight text %}
[1] 6.793
{% endhighlight %}


### \(\tau\) estimate of scale


{% highlight r %}
scaleTau2(age)
{% endhighlight %}



{% highlight text %}
[1] 4.865
{% endhighlight %}


Diversity of categorical data
-------------------------


{% highlight r %}
fac <- factor(c("C", "D", "A", "D", "E", "D", "C", "E", "E", "B", "E"),
              levels=c(LETTERS[1:5], "Q"))
P   <- nlevels(fac)
(Fj <- prop.table(table(fac)))
{% endhighlight %}



{% highlight text %}
fac
      A       B       C       D       E       Q 
0.09091 0.09091 0.18182 0.27273 0.36364 0.00000 
{% endhighlight %}



{% highlight r %}
library(vegan)
shannonIdx <- diversity(Fj, index="shannon")
(H <- (1/log(P)) * shannonIdx)
{% endhighlight %}



{% highlight text %}
[1] 0.8194
{% endhighlight %}


Higher moments: skewness and kurtosis
-------------------------


{% highlight r %}
library(e1071)
skewness(age)
{% endhighlight %}



{% highlight text %}
[1] -0.08611
{% endhighlight %}



{% highlight r %}
kurtosis(age)
{% endhighlight %}



{% highlight text %}
[1] -1.773
{% endhighlight %}


Detach (automatically) loaded packages (if possible)
-------------------------


{% highlight r %}
try(detach(package:psych))
try(detach(package:robustbase))
try(detach(package:vegan))
try(detach(package:permute))
try(detach(package:e1071))
try(detach(package:class))
{% endhighlight %}


Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/variance.Rmd) - [markdown](https://github.com/dwoll/RExRepos/raw/master/md/variance.md) - [R code](https://github.com/dwoll/RExRepos/raw/master/R/variance.R) - [all posts](https://github.com/dwoll/RExRepos)
