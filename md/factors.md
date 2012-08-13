Factors: Representing categorical data
=========================




TODO
-------------------------

 - link to recode for changing factor levels and for transforming continuous variables into factors

Install required packages
-------------------------

[`car`](http://cran.r-project.org/package=car), [`gdata`](http://cran.r-project.org/package=gdata)


{% highlight r %}
wants <- c("car", "gdata")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])
{% endhighlight %}


Unordered factors
-------------------------

### Create factors from existing variables
    

{% highlight r %}
sex     <- c("m", "f", "f", "m", "m", "m", "f", "f")
(sexFac <- factor(sex))
{% endhighlight %}



{% highlight text %}
[1] m f f m m m f f
Levels: f m
{% endhighlight %}



{% highlight r %}
factor(c(1, 1, 3, 3, 4, 4), levels=1:5)
{% endhighlight %}



{% highlight text %}
[1] 1 1 3 3 4 4
Levels: 1 2 3 4 5
{% endhighlight %}



{% highlight r %}
(sexNum <- rbinom(10, size=1, prob=0.5))
{% endhighlight %}



{% highlight text %}
 [1] 1 1 0 1 1 0 0 0 0 1
{% endhighlight %}



{% highlight r %}
factor(sexNum, labels=c("man", "woman"))
{% endhighlight %}



{% highlight text %}
 [1] woman woman man   woman woman man   man   man   man   woman
Levels: man woman
{% endhighlight %}



{% highlight r %}
levels(sexFac) <- c("female", "male")
sexFac
{% endhighlight %}



{% highlight text %}
[1] male   female female male   male   male   female female
Levels: female male
{% endhighlight %}


### Generate factors


{% highlight r %}
(fac1 <- factor(rep(c("A", "B"), c(5, 5))))
{% endhighlight %}



{% highlight text %}
 [1] A A A A A B B B B B
Levels: A B
{% endhighlight %}



{% highlight r %}
(fac2 <- gl(2, 5, labels=c("less", "more"), ordered=TRUE))
{% endhighlight %}



{% highlight text %}
 [1] less less less less less more more more more more
Levels: less < more
{% endhighlight %}



{% highlight r %}
sample(fac2, length(fac2), replace=FALSE)
{% endhighlight %}



{% highlight text %}
 [1] more more more less less more more less less less
Levels: less < more
{% endhighlight %}



{% highlight r %}
expand.grid(IV1=gl(2, 2, labels=c("a", "b")), IV2=gl(3, 1))
{% endhighlight %}



{% highlight text %}
   IV1 IV2
1    a   1
2    a   1
3    b   1
4    b   1
5    a   2
6    a   2
7    b   2
8    b   2
9    a   3
10   a   3
11   b   3
12   b   3
{% endhighlight %}


### Information about factors


{% highlight r %}
nlevels(sexFac)
{% endhighlight %}



{% highlight text %}
[1] 2
{% endhighlight %}



{% highlight r %}
summary(sexFac)
{% endhighlight %}



{% highlight text %}
female   male 
     4      4 
{% endhighlight %}



{% highlight r %}
levels(sexFac)
{% endhighlight %}



{% highlight text %}
[1] "female" "male"  
{% endhighlight %}



{% highlight r %}
str(sexFac)
{% endhighlight %}



{% highlight text %}
 Factor w/ 2 levels "female","male": 2 1 1 2 2 2 1 1
{% endhighlight %}



{% highlight r %}
unclass(sexFac)
{% endhighlight %}



{% highlight text %}
[1] 2 1 1 2 2 2 1 1
attr(,"levels")
[1] "female" "male"  
{% endhighlight %}



{% highlight r %}
unclass(factor(10:15))
{% endhighlight %}



{% highlight text %}
[1] 1 2 3 4 5 6
attr(,"levels")
[1] "10" "11" "12" "13" "14" "15"
{% endhighlight %}



{% highlight r %}
as.character(sexFac)
{% endhighlight %}



{% highlight text %}
[1] "male"   "female" "female" "male"   "male"   "male"   "female" "female"
{% endhighlight %}


Joining factors
-------------------------

### Concatenating factors


{% highlight r %}
(fac1 <- factor(sample(LETTERS, 5)))
{% endhighlight %}



{% highlight text %}
[1] M X A G L
Levels: A G L M X
{% endhighlight %}



{% highlight r %}
(fac2 <- factor(sample(letters, 3)))
{% endhighlight %}



{% highlight text %}
[1] p g k
Levels: g k p
{% endhighlight %}



{% highlight r %}
(charVec1 <- levels(fac1)[fac1])
{% endhighlight %}



{% highlight text %}
[1] "M" "X" "A" "G" "L"
{% endhighlight %}



{% highlight r %}
(charVec2 <- levels(fac2)[fac2])
{% endhighlight %}



{% highlight text %}
[1] "p" "g" "k"
{% endhighlight %}



{% highlight r %}
factor(c(charVec1, charVec2))
{% endhighlight %}



{% highlight text %}
[1] M X A G L p g k
Levels: A g G k L M p X
{% endhighlight %}


### Repeating factors


{% highlight r %}
rep(fac1, times=2)
{% endhighlight %}



{% highlight text %}
 [1] M X A G L M X A G L
Levels: A G L M X
{% endhighlight %}


### Crossing two factors


{% highlight r %}
Njk  <- 2
P    <- 2
Q    <- 3
(IV1 <- factor(rep(c("lo", "hi"), each=Njk*Q)))
{% endhighlight %}



{% highlight text %}
 [1] lo lo lo lo lo lo hi hi hi hi hi hi
Levels: hi lo
{% endhighlight %}



{% highlight r %}
(IV2 <- factor(rep(1:Q, times=Njk*P)))
{% endhighlight %}



{% highlight text %}
 [1] 1 2 3 1 2 3 1 2 3 1 2 3
Levels: 1 2 3
{% endhighlight %}



{% highlight r %}
interaction(IV1, IV2)
{% endhighlight %}



{% highlight text %}
 [1] lo.1 lo.2 lo.3 lo.1 lo.2 lo.3 hi.1 hi.2 hi.3 hi.1 hi.2 hi.3
Levels: hi.1 lo.1 hi.2 lo.2 hi.3 lo.3
{% endhighlight %}


Ordered factors
-------------------------


{% highlight r %}
(status <- factor(c("hi", "lo", "hi", "mid")))
{% endhighlight %}



{% highlight text %}
[1] hi  lo  hi  mid
Levels: hi lo mid
{% endhighlight %}



{% highlight r %}
(ordStat <- ordered(status, levels=c("lo", "mid", "hi")))
{% endhighlight %}



{% highlight text %}
[1] hi  lo  hi  mid
Levels: lo < mid < hi
{% endhighlight %}



{% highlight r %}
ordStat[1] > ordStat[2]
{% endhighlight %}



{% highlight text %}
[1] TRUE
{% endhighlight %}


Control the order of factor levels
-------------------------

### Free ordering of group levels


{% highlight r %}
(chars <- rep(LETTERS[1:3], each=5))
{% endhighlight %}



{% highlight text %}
 [1] "A" "A" "A" "A" "A" "B" "B" "B" "B" "B" "C" "C" "C" "C" "C"
{% endhighlight %}



{% highlight r %}
(fac1 <- factor(chars))
{% endhighlight %}



{% highlight text %}
 [1] A A A A A B B B B B C C C C C
Levels: A B C
{% endhighlight %}



{% highlight r %}
factor(chars, levels=c("C", "A", "B"))
{% endhighlight %}



{% highlight text %}
 [1] A A A A A B B B B B C C C C C
Levels: C A B
{% endhighlight %}


### Using `reorder.factor()` from package `gdata`


{% highlight r %}
library(gdata)
(facRe <- reorder.factor(fac1, new.order=c("C", "B", "A")))
{% endhighlight %}



{% highlight text %}
 [1] A A A A A B B B B B C C C C C
Levels: C B A
{% endhighlight %}


### Reorder group levels according to group statistics


{% highlight r %}
vec <- rnorm(15, rep(c(10, 5, 15), each=5), 3)
tapply(vec, fac1, FUN=mean)
{% endhighlight %}



{% highlight text %}
     A      B      C 
 9.021  2.567 14.872 
{% endhighlight %}



{% highlight r %}
reorder(fac1, vec, FUN=mean)
{% endhighlight %}



{% highlight text %}
 [1] A A A A A B B B B B C C C C C
Levels: B A C
{% endhighlight %}


### Relevance of level order for sorting factors


{% highlight r %}
(fac2 <- factor(sample(1:2, 10, replace=TRUE), labels=c("B", "A")))
{% endhighlight %}



{% highlight text %}
 [1] A B B A A B A A A A
Levels: B A
{% endhighlight %}



{% highlight r %}
sort(fac2)
{% endhighlight %}



{% highlight text %}
 [1] B B B A A A A A A A
Levels: B A
{% endhighlight %}



{% highlight r %}
sort(as.character(fac2))
{% endhighlight %}



{% highlight text %}
 [1] "A" "A" "A" "A" "A" "A" "A" "B" "B" "B"
{% endhighlight %}


Detach (automatically) loaded packages (if possible)
-------------------------


{% highlight r %}
try(detach(package:car))
try(detach(package:nnet))
try(detach(package:MASS))
try(detach(package:gdata))
{% endhighlight %}


Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/factors.Rmd) - [markdown](https://github.com/dwoll/RExRepos/raw/master/md/factors.md) - [R code](https://github.com/dwoll/RExRepos/raw/master/R/factors.R) - [all posts](https://github.com/dwoll/RExRepos)
