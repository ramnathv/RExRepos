Stuart-Maxwell-test for marginal homogeneity
=========================

Install required packages
-------------------------

[`coin`](http://cran.r-project.org/package=coin)


{% highlight r %}
wants <- c("coin")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])
{% endhighlight %}


MH-test
-------------------------


{% highlight r %}
categ <- factor(1:3, labels=c("lo", "med", "hi"))
drug  <- rep(categ, c(30, 50, 20))
plac  <- rep(rep(categ, length(categ)), c(14,7,9, 5,26,19, 1,7,12))
cTab  <- table(drug, plac)
addmargins(cTab)
{% endhighlight %}



{% highlight text %}
     plac
drug   lo med  hi Sum
  lo   14   7   9  30
  med   5  26  19  50
  hi    1   7  12  20
  Sum  20  40  40 100
{% endhighlight %}



{% highlight r %}
library(coin)
mh_test(cTab, distribution=approximate(B=9999))
{% endhighlight %}



{% highlight text %}

	Approximative Marginal-Homogeneity Test

data:  response by
	 groups (drug, plac) 
	 stratified by block 
chi-squared = 12.14, p-value = 0.0017

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

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/npStuartMaxwell.Rmd) - [markdown](https://github.com/dwoll/RExRepos/raw/master/md/npStuartMaxwell.md) - [R code](https://github.com/dwoll/RExRepos/raw/master/R/npStuartMaxwell.R) - [all posts](https://github.com/dwoll/RExRepos)
