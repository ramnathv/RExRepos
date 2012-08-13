Recode variables
=========================




TODO
-------------------------

 - link to factors

Install required packages
-------------------------

[`car`](http://cran.r-project.org/package=car), [`gdata`](http://cran.r-project.org/package=gdata)


{% highlight r %}
wants <- c("car", "gdata")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])
{% endhighlight %}


Recode numerical or character variables
-------------------------
    
### Using index vectors


{% highlight r %}
myColors <- c("red", "purple", "blue", "blue", "orange", "red", "orange")
farben   <- character(length(myColors))
farben[myColors == "red"]    <- "rot"
farben[myColors == "purple"] <- "violett"
farben[myColors == "blue"]   <- "blau"
farben[myColors == "orange"] <- "orange"
farben
{% endhighlight %}



{% highlight text %}
[1] "rot"     "violett" "blau"    "blau"    "orange"  "rot"     "orange" 
{% endhighlight %}



{% highlight r %}
replace(c(1, 2, 3, 4, 5), list=c(2, 4), values=c(200, 400))
{% endhighlight %}



{% highlight text %}
[1]   1 200   3 400   5
{% endhighlight %}


### Using `recode()` from package `car`


{% highlight r %}
library(car)
recode(myColors, "'red'='rot'; 'blue'='blau'; 'purple'='violett'")
{% endhighlight %}



{% highlight text %}
[1] "rot"     "violett" "blau"    "blau"    "orange"  "rot"     "orange" 
{% endhighlight %}



{% highlight r %}
recode(myColors, "c('red', 'blue')='basic'; else='complex'")
{% endhighlight %}



{% highlight text %}
[1] "basic"   "complex" "basic"   "basic"   "complex" "basic"   "complex"
{% endhighlight %}


### Using `ifelse()`


{% highlight r %}
orgVec <- c(5, 9, 11, 8, 9, 3, 1, 13, 9, 12, 5, 12, 6, 3, 17, 5, 8, 7)
cutoff <- 10
(reVec <- ifelse(orgVec <= cutoff, orgVec, cutoff))
{% endhighlight %}



{% highlight text %}
 [1]  5  9 10  8  9  3  1 10  9 10  5 10  6  3 10  5  8  7
{% endhighlight %}



{% highlight r %}
targetSet <- c("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K")
response  <- c("Z", "E", "O", "W", "H", "C", "I", "G", "A", "O", "B")
(respRec  <- ifelse(response %in% targetSet, response, "other"))
{% endhighlight %}



{% highlight text %}
 [1] "other" "E"     "other" "other" "H"     "C"     "I"     "G"    
 [9] "A"     "other" "B"    
{% endhighlight %}


Cut continuous variables into categorical variables
-------------------------

### Free recoding of value ranges into categories


{% highlight r %}
set.seed(1.234)
IQ <- rnorm(20, mean=100, sd=15)
ifelse(IQ >= 100, "hi", "lo")
{% endhighlight %}



{% highlight text %}
 [1] "lo" "hi" "lo" "hi" "hi" "lo" "hi" "hi" "hi" "lo" "hi" "hi" "lo" "lo"
[15] "hi" "lo" "lo" "hi" "hi" "hi"
{% endhighlight %}



{% highlight r %}
library(car)
recode(IQ, "0:100=1; 101:115=2; else=3")
{% endhighlight %}



{% highlight text %}
 [1] 1 2 1 3 2 1 2 2 2 1 3 2 1 1 3 1 1 2 2 2
{% endhighlight %}


### Turn ordered value ranges into factor levels using `cut()`


{% highlight r %}
IQfac <- cut(IQ, breaks=c(0, 85, 115, Inf), labels=c("lo", "mid", "hi"))
head(IQfac)
{% endhighlight %}



{% highlight text %}
[1] mid mid mid hi  mid mid
Levels: lo mid hi
{% endhighlight %}



{% highlight r %}
medSplit <- cut(IQ, breaks=c(-Inf, median(IQ), Inf))
summary(medSplit)
{% endhighlight %}



{% highlight text %}
(-Inf,105] (105, Inf] 
        10         10 
{% endhighlight %}



{% highlight r %}
IQdiscr <- cut(IQ, quantile(IQ), include.lowest=TRUE)
summary(IQdiscr)
{% endhighlight %}



{% highlight text %}
[66.8,94.2]  (94.2,105]   (105,111]   (111,124] 
          5           5           5           5 
{% endhighlight %}


Recode factors
-------------------------

### Add, combine and remove factor levels

#### Add factor levels


{% highlight r %}
(status <- factor(c("hi", "lo", "hi")))
{% endhighlight %}



{% highlight text %}
[1] hi lo hi
Levels: hi lo
{% endhighlight %}



{% highlight r %}
status[4] <- "mid"
status
{% endhighlight %}



{% highlight text %}
[1] hi   lo   hi   <NA>
Levels: hi lo
{% endhighlight %}



{% highlight r %}
levels(status) <- c(levels(status), "mid")
status[4] <- "mid"
status
{% endhighlight %}



{% highlight text %}
[1] hi  lo  hi  mid
Levels: hi lo mid
{% endhighlight %}


#### Combine factor levels


{% highlight r %}
hiNotHi <- status
levels(hiNotHi) <- list(hi="hi", notHi=c("mid", "lo"))
hiNotHi
{% endhighlight %}



{% highlight text %}
[1] hi    notHi hi    notHi
Levels: hi notHi
{% endhighlight %}



{% highlight r %}
library(car)
(statNew <- recode(status, "'hi'='high'; c('mid', 'lo')='notHigh'"))
{% endhighlight %}



{% highlight text %}
[1] high    notHigh high    notHigh
Levels: high notHigh
{% endhighlight %}


#### Remove factor levels


{% highlight r %}
status[1:2]
{% endhighlight %}



{% highlight text %}
[1] hi lo
Levels: hi lo mid
{% endhighlight %}



{% highlight r %}
(newStatus <- droplevels(status[1:2]))
{% endhighlight %}



{% highlight text %}
[1] hi lo
Levels: hi lo
{% endhighlight %}


### Reorder factor levels

#### Using `reorder.factor()` from package `gdata`


{% highlight r %}
(facGrp <- factor(rep(LETTERS[1:3], each=5)))
{% endhighlight %}



{% highlight text %}
 [1] A A A A A B B B B B C C C C C
Levels: A B C
{% endhighlight %}



{% highlight r %}
library(gdata)
(facRe <- reorder.factor(facGrp, new.order=c("C", "B", "A")))
{% endhighlight %}



{% highlight text %}
 [1] A A A A A B B B B B C C C C C
Levels: C B A
{% endhighlight %}


#### Reorder group levels according to group statistics


{% highlight r %}
vec <- rnorm(15, rep(c(10, 5, 15), each=5), 3)
tapply(vec, facGrp, FUN=mean)
{% endhighlight %}



{% highlight text %}
     A      B      C 
10.244  3.954 15.128 
{% endhighlight %}



{% highlight r %}
reorder(facGrp, vec, FUN=mean)
{% endhighlight %}



{% highlight text %}
 [1] A A A A A B B B B B C C C C C
Levels: B A C
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

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/recode.Rmd) - [markdown](https://github.com/dwoll/RExRepos/raw/master/md/recode.md) - [R code](https://github.com/dwoll/RExRepos/raw/master/R/recode.R) - [all posts](https://github.com/dwoll/RExRepos)
