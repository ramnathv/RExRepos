Inter-rater-reliability and Intra-class-correlation
=========================

Install required packages
-------------------------

[`irr`](http://cran.r-project.org/package=irr), [`psych`](http://cran.r-project.org/package=psych)


{% highlight r %}
wants <- c("irr", "psych")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])
{% endhighlight %}


Inter-rater-reliability
-------------------------

### Absolute agreement between two or more raters

#### Two raters


{% highlight r %}
categ <- c("V", "N", "P")
lvls  <- factor(categ, levels=categ)
rtr1  <- rep(lvls, c(60, 30, 10))
rtr2  <- rep(rep(lvls, nlevels(lvls)), c(53,5,2, 11,14,5, 1,6,3))
cTab  <- table(rtr1, rtr2)
addmargins(cTab)
{% endhighlight %}



{% highlight text %}
     rtr2
rtr1    V   N   P Sum
  V    53   5   2  60
  N    11  14   5  30
  P     1   6   3  10
  Sum  65  25  10 100
{% endhighlight %}



{% highlight r %}
library(irr)
agree(cbind(rtr1, rtr2))
{% endhighlight %}



{% highlight text %}
 Percentage agreement (Tolerance=0)

 Subjects = 100 
   Raters = 2 
  %-agree = 70 
{% endhighlight %}


#### Three raters


{% highlight r %}
rtr3 <- rep(rep(lvls, nlevels(lvls)), c(48,8,3, 15,10,7, 3,4,2))
agree(cbind(rtr1, rtr2, rtr3))
{% endhighlight %}



{% highlight text %}
 Percentage agreement (Tolerance=0)

 Subjects = 100 
   Raters = 3 
  %-agree = 60 
{% endhighlight %}


### Cohen's unweighted \(\kappa\) for two raters


{% highlight r %}
library(irr)
kappa2(cbind(rtr1, rtr2))
{% endhighlight %}



{% highlight text %}
 Cohen's Kappa for 2 Raters (Weights: unweighted)

 Subjects = 100 
   Raters = 2 
    Kappa = 0.429 

        z = 5.46 
  p-value = 4.79e-08 
{% endhighlight %}


### Cohen's weighted \(\kappa\) for two raters

Ordered categories


{% highlight r %}
categ <- c("<10%", "11-20%", "21-30%", "31-40%", "41-50%", ">50%")
lvls  <- factor(categ, levels=categ)
tv1   <- rep(lvls, c(22, 21, 23, 16, 10, 8))
tv2   <- rep(rep(lvls, nlevels(lvls)), c(5,8,1,2,4,2, 3,5,3,5,5,0, 1,2,6,11,2,1,
                                         0,1,5,4,3,3, 0,0,1,2,5,2, 0,0,1, 2,1,4))
cTab  <- table(tv1, tv2)
addmargins(cTab)
{% endhighlight %}



{% highlight text %}
        tv2
tv1      <10% 11-20% 21-30% 31-40% 41-50% >50% Sum
  <10%      5      8      1      2      4    2  22
  11-20%    3      5      3      5      5    0  21
  21-30%    1      2      6     11      2    1  23
  31-40%    0      1      5      4      3    3  16
  41-50%    0      0      1      2      5    2  10
  >50%      0      0      1      2      1    4   8
  Sum       9     16     17     26     20   12 100
{% endhighlight %}



{% highlight r %}
library(irr)
kappa2(cbind(tv1, tv2), weight="equal")
{% endhighlight %}



{% highlight text %}
 Cohen's Kappa for 2 Raters (Weights: equal)

 Subjects = 100 
   Raters = 2 
    Kappa = 0.316 

        z = 5.38 
  p-value = 7.3e-08 
{% endhighlight %}


### Fleiss' \(\kappa\) for two or more raters


{% highlight r %}
rtr1 <- letters[c(4,2,2,5,2, 1,3,1,1,5, 1,1,2,1,2, 3,1,1,2,1, 5,2,2,1,1, 2,1,2,1,5)]
rtr2 <- letters[c(4,2,3,5,2, 1,3,1,1,5, 4,2,2,4,2, 3,1,1,2,3, 5,4,2,1,4, 2,1,2,3,5)]
rtr3 <- letters[c(4,2,3,5,2, 3,3,3,4,5, 4,4,2,4,4, 3,1,1,4,3, 5,4,4,4,4, 2,1,4,3,5)]
rtr4 <- letters[c(4,5,3,5,4, 3,3,3,4,5, 4,4,3,4,4, 3,4,1,4,5, 5,4,5,4,4, 2,1,4,3,5)]
rtr5 <- letters[c(4,5,3,5,4, 3,5,3,4,5, 4,4,3,4,4, 3,5,1,4,5, 5,4,5,4,4, 2,5,4,3,5)]
rtr6 <- letters[c(4,5,5,5,4, 3,5,4,4,5, 4,4,3,4,5, 5,5,2,4,5, 5,4,5,4,5, 4,5,4,3,5)]
ratings <- cbind(rtr1, rtr2, rtr3, rtr4, rtr5, rtr6)
{% endhighlight %}



{% highlight r %}
library(irr)
kappam.fleiss(ratings)
{% endhighlight %}



{% highlight text %}
 Fleiss' Kappa for m Raters

 Subjects = 30 
   Raters = 6 
    Kappa = 0.43 

        z = 17.7 
  p-value = 0 
{% endhighlight %}


### Krippendorff's \(\alpha\) for ordinal ratings and two or more raters


{% highlight r %}
library(irr)
kripp.alpha(ratings, method="ordinal")
{% endhighlight %}



{% highlight text %}
 Krippendorff's alpha

 Subjects = 6 
   Raters = 30 
    alpha = 0.255 
{% endhighlight %}


### Kendall's \(W\) for continuous ordinal ratings and two or more raters


{% highlight r %}
rtr1 <- c(1, 6, 3, 2, 5, 4)
rtr2 <- c(1, 5, 6, 2, 4, 3)
rtr3 <- c(2, 3, 6, 5, 4, 1)
ratings <- cbind(rtr1, rtr2, rtr3)
{% endhighlight %}



{% highlight r %}
library(irr)
kendall(ratings)
{% endhighlight %}



{% highlight text %}
 Kendall's coefficient of concordance W

 Subjects = 6 
   Raters = 3 
        W = 0.568 

 Chisq(5) = 8.52 
  p-value = 0.13 
{% endhighlight %}


Intra-class-correlation for interval-scale ratings and two or more raters
-------------------------


{% highlight r %}
rtr1 <- c(9, 6, 8, 7, 10, 6)
rtr2 <- c(2, 1, 4, 1,  5, 2)
rtr3 <- c(5, 3, 6, 2,  6, 4)
rtr4 <- c(8, 2, 8, 6,  9, 7)
ratings <- cbind(rtr1, rtr2, rtr3, rtr4)
{% endhighlight %}



{% highlight r %}
library(psych)
ICC(ratings)
{% endhighlight %}



{% highlight text %}
Call: ICC(x = ratings)

Intraclass correlation coefficients 
                         type  ICC    F df1 df2       p lower bound
Single_raters_absolute   ICC1 0.17  1.8   5  18 0.16477      -0.133
Single_random_raters     ICC2 0.29 11.0   5  15 0.00013       0.019
Single_fixed_raters      ICC3 0.71 11.0   5  15 0.00013       0.342
Average_raters_absolute ICC1k 0.44  1.8   5  18 0.16477      -0.884
Average_random_raters   ICC2k 0.62 11.0   5  15 0.00013       0.071
Average_fixed_raters    ICC3k 0.91 11.0   5  15 0.00013       0.676
                        upper bound
Single_raters_absolute         0.72
Single_random_raters           0.76
Single_fixed_raters            0.95
Average_raters_absolute        0.91
Average_random_raters          0.93
Average_fixed_raters           0.99

 Number of subjects = 6     Number of Judges =  4{% endhighlight %}


Detach (automatically) loaded packages (if possible)
-------------------------


{% highlight r %}
try(detach(package:psych))
try(detach(package:irr))
try(detach(package:lpSolve))
{% endhighlight %}


Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/interRaterICC.Rmd) - [markdown](https://github.com/dwoll/RExRepos/raw/master/md/interRaterICC.md) - [R code](https://github.com/dwoll/RExRepos/raw/master/R/interRaterICC.R) - [all posts](https://github.com/dwoll/RExRepos)
