Crossvalidation for linear and generalized linear models
=========================

Install required packages
-------------------------

[`boot`](http://cran.r-project.org/package=boot)


{% highlight r %}
wants <- c("boot")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])
{% endhighlight %}


\(k\)-fold crossvalidation
-------------------------

### Simulate data
    

{% highlight r %}
set.seed(1.234)
N  <- 100
X1 <- rnorm(N, 175, 7)
X2 <- rnorm(N,  30, 8)
X3 <- abs(rnorm(N, 60, 30))
Y  <- 0.5*X1 - 0.3*X2 - 0.4*X3 + 10 + rnorm(N, 0, 3)
dfRegr <- data.frame(X1, X2, X3, Y)
{% endhighlight %}


### Crossvalidation


{% highlight r %}
glmFit <- glm(Y ~ X1 + X2 + X3, data=dfRegr,
              family=gaussian(link="identity"))
{% endhighlight %}



{% highlight r %}
library(boot)
k    <- 3
kfCV <- cv.glm(data=dfRegr, glmfit=glmFit, K=k)
kfCV$delta
{% endhighlight %}



{% highlight text %}
[1] 9.030 8.954
{% endhighlight %}


Leave-one-out crossvalidation
-------------------------


{% highlight r %}
LOOCV <- cv.glm(data=dfRegr, glmfit=glmFit, K=N)
{% endhighlight %}


CVE = mean(PRESS)


{% highlight r %}
LOOCV$delta
{% endhighlight %}



{% highlight text %}
[1] 9.500 9.496
{% endhighlight %}


Detach (automatically) loaded packages (if possible)
-------------------------


{% highlight r %}
try(detach(package:boot))
{% endhighlight %}


Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/crossvalidation.Rmd) - [markdown](https://github.com/dwoll/RExRepos/raw/master/md/crossvalidation.md) - [R code](https://github.com/dwoll/RExRepos/raw/master/R/crossvalidation.R) - [all posts](https://github.com/dwoll/RExRepos)
