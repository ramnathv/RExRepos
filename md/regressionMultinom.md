Multinomial regression
=========================




TODO
-------------------------

 - link to regressionLogistic, regressionOrdinal

Install required packages
-------------------------

[`lmtest`](http://cran.r-project.org/package=lmtest), [`mlogit`](http://cran.r-project.org/package=mlogit), [`nnet`](http://cran.r-project.org/package=nnet), [`VGAM`](http://cran.r-project.org/package=VGAM)


{% highlight r %}
wants <- c("lmtest", "mlogit", "nnet", "VGAM")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])
{% endhighlight %}


Multinomial regression
----------------------

### Simulate data
    

{% highlight r %}
set.seed(1.234)
N      <- 100
X1     <- rnorm(N, 175, 7)
X2     <- rnorm(N,  30, 8)
Ycont  <- 0.5*X1 - 0.3*X2 + 10 + rnorm(N, 0, 6)
Ycateg <- cut(Ycont, breaks=quantile(Ycont), include.lowest=TRUE,
              labels=c("--", "-", "+", "++"))
dfRegr <- data.frame(X1, X2, Ycateg)
{% endhighlight %}


### Using `multinom()` from package `nnet`

Estimator based on neural networks
-> slightly different results than `vglm()`, `mlogit()` below


{% highlight r %}
library(nnet)
mnFit <- multinom(Ycateg ~ X1 + X2, data=dfRegr)
{% endhighlight %}



{% highlight text %}
# weights:  16 (9 variable)
initial  value 138.629436 
iter  10 value 124.455652
iter  20 value 119.074454
iter  30 value 118.619483
iter  40 value 118.549363
iter  40 value 118.549362
iter  40 value 118.549362
final  value 118.549362 
converged
{% endhighlight %}



{% highlight r %}
summary(mnFit)
{% endhighlight %}



{% highlight text %}
Call:
multinom(formula = Ycateg ~ X1 + X2, data = dfRegr)

Coefficients:
   (Intercept)     X1       X2
-       -17.95 0.1027  0.00315
+       -29.81 0.1902 -0.11412
++      -27.75 0.1926 -0.20823

Std. Errors:
   (Intercept)      X1      X2
-        5.893 0.03411 0.03891
+        4.877 0.02843 0.04740
++       4.954 0.02980 0.05630

Residual Deviance: 237.1 
AIC: 255.1 
{% endhighlight %}



{% highlight r %}
library(lmtest)
lrtest(mnFit)
{% endhighlight %}



{% highlight text %}
Error: Objekt 'dfRegr' nicht gefunden
{% endhighlight %}


### Using `vglm()` from package `VGAM`

Estimator based on likelihood-inference


{% highlight r %}
library(VGAM)
vglmFitMN <- vglm(Ycateg ~ X1 + X2, family=multinomial(refLevel=1), data=dfRegr)
summary(vglmFitMN)
{% endhighlight %}



{% highlight text %}
Length  Class   Mode 
     1   vglm     S4 
{% endhighlight %}


### Using `mlogit()` from package `mlogit`

Uses person-choice (long) format


{% highlight r %}
library(mlogit)
dfRegrL   <- mlogit.data(dfRegr, choice="Ycateg", shape="wide", varying=NULL)
mlogitFit <- mlogit(Ycateg ~ 0 | X1 + X2, reflevel="--", data=dfRegrL)
summary(mlogitFit)
{% endhighlight %}



{% highlight text %}

Call:
mlogit(formula = Ycateg ~ 0 | X1 + X2, data = dfRegrL, reflevel = "--", 
    method = "nr", print.level = 0)

Frequencies of alternatives:
  --    -    +   ++ 
0.25 0.25 0.25 0.25 

nr method
5 iterations, 0h:0m:0s 
g'(-H)^-1g = 0.000318 
successive fonction values within tolerance limits 

Coefficients :
                Estimate Std. Error t-value Pr(>|t|)    
-:(intercept)  -18.02102    9.17704   -1.96  0.04956 *  
+:(intercept)  -29.71395    9.91961   -3.00  0.00274 ** 
++:(intercept) -28.48099   10.22016   -2.79  0.00532 ** 
-:X1             0.10310    0.05367    1.92  0.05475 .  
+:X1             0.18979    0.05808    3.27  0.00108 ** 
++:X1            0.19686    0.06025    3.27  0.00108 ** 
-:X2             0.00307    0.03917    0.08  0.93746    
+:X2            -0.11497    0.04778   -2.41  0.01612 *  
++:X2           -0.20915    0.05678   -3.68  0.00023 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 

Log-Likelihood: -119
McFadden R^2:  0.145 
Likelihood ratio test : chisq = 40.2 (p.value = 4.22e-07)
{% endhighlight %}



{% highlight r %}
library(lmtest)
coeftest(mlogitFit)
{% endhighlight %}



{% highlight text %}

t test of coefficients:

                Estimate Std. Error t value Pr(>|t|)    
-:(intercept)  -18.02102    9.17704   -1.96  0.05262 .  
+:(intercept)  -29.71395    9.91961   -3.00  0.00353 ** 
++:(intercept) -28.48099   10.22016   -2.79  0.00648 ** 
-:X1             0.10310    0.05367    1.92  0.05788 .  
+:X1             0.18979    0.05808    3.27  0.00153 ** 
++:X1            0.19686    0.06025    3.27  0.00153 ** 
-:X2             0.00307    0.03917    0.08  0.93763    
+:X2            -0.11497    0.04778   -2.41  0.01814 *  
++:X2           -0.20915    0.05678   -3.68  0.00039 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 

{% endhighlight %}


Predicted category membership
-------------------------

### Predicted category probabilities


{% highlight r %}
PhatCateg <- predict(mnFit, type="probs")
head(PhatCateg)
{% endhighlight %}



{% highlight text %}
       --      -       +       ++
1 0.29441 0.2064 0.23518 0.263978
2 0.22495 0.2871 0.28854 0.199399
3 0.28697 0.1719 0.22624 0.314919
4 0.05887 0.2079 0.44475 0.288511
5 0.11391 0.1586 0.33514 0.392312
6 0.57790 0.3743 0.04031 0.007472
{% endhighlight %}



{% highlight r %}
predict(vglmFitMN, type="response")
fitted(mlogitFit, outcome=FALSE)
# not run
{% endhighlight %}


### Predicted categories


{% highlight r %}
(predCls <- predict(mnFit, type="class"))
{% endhighlight %}



{% highlight text %}
  [1] -- +  ++ +  ++ -- -  -  -  -- ++ ++ -- -- +  +  +  +  -  +  ++ -  + 
 [24] -- +  -  -- -- ++ +  +  ++ -  ++ -- ++ -- ++ ++ +  ++ -- ++ ++ ++ --
 [47] -  +  ++ ++ -  -- +  -- ++ ++ -- -- ++ -  +  +  -  -  -- -  -- ++ + 
 [70] +  -  -- -  -- -- +  -- -  -  -- ++ -  +  ++ -  +  -  ++ +  ++ -- + 
 [93] ++ -  ++ ++ -- ++ -- --
Levels: -- - + ++
{% endhighlight %}



{% highlight r %}
categHat <- levels(dfRegr$Ycateg)[max.col(PhatCateg)]
all.equal(factor(categHat), predCls, check.attributes=FALSE)
{% endhighlight %}



{% highlight text %}
[1] TRUE
{% endhighlight %}


Detach (automatically) loaded packages (if possible)
-------------------------


{% highlight r %}
try(detach(package:mlogit))
try(detach(package:MASS))
try(detach(package:Formula))
try(detach(package:statmod))
try(detach(package:lmtest))
try(detach(package:zoo))
try(detach(package:maxLik))
try(detach(package:miscTools))
try(detach(package:nnet))
try(detach(package:VGAM))
try(detach(package:splines))
try(detach(package:stats4))
{% endhighlight %}


Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/regressionMultinom.Rmd) - [markdown](https://github.com/dwoll/RExRepos/raw/master/md/regressionMultinom.md) - [R code](https://github.com/dwoll/RExRepos/raw/master/R/regressionMultinom.R) - [all posts](https://github.com/dwoll/RExRepos)
