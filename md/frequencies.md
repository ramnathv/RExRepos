Frequency tables
=========================

Install required packages
-------------------------

[`epitools`](http://cran.r-project.org/package=epitools)


{% highlight r %}
wants <- c("epitools")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])
{% endhighlight %}


Category frequencies for one variable
-------------------------

### Absolute frequencies


{% highlight r %}
set.seed(1.234)
(myLetters <- sample(LETTERS[1:5], 12, replace=TRUE))
{% endhighlight %}



{% highlight text %}
 [1] "B" "B" "C" "E" "B" "E" "E" "D" "D" "A" "B" "A"
{% endhighlight %}



{% highlight r %}
(tab <- table(myLetters))
{% endhighlight %}



{% highlight text %}
myLetters
A B C D E 
2 4 1 2 3 
{% endhighlight %}



{% highlight r %}
names(tab)
{% endhighlight %}



{% highlight text %}
[1] "A" "B" "C" "D" "E"
{% endhighlight %}



{% highlight r %}
tab["B"]
{% endhighlight %}



{% highlight text %}
B 
4 
{% endhighlight %}



{% highlight r %}
barplot(tab, main="Counts")
{% endhighlight %}

![plot of chunk rerFrequencies01](figure/rerFrequencies01.png) 


### (Cumulative) relative frequencies


{% highlight r %}
(relFreq <- prop.table(tab))
{% endhighlight %}



{% highlight text %}
myLetters
      A       B       C       D       E 
0.16667 0.33333 0.08333 0.16667 0.25000 
{% endhighlight %}



{% highlight r %}
cumsum(relFreq)
{% endhighlight %}



{% highlight text %}
     A      B      C      D      E 
0.1667 0.5000 0.5833 0.7500 1.0000 
{% endhighlight %}


### Counting non-existent categories


{% highlight r %}
letFac <- factor(myLetters, levels=c(LETTERS[1:5], "Q"))
letFac
{% endhighlight %}



{% highlight text %}
 [1] B B C E B E E D D A B A
Levels: A B C D E Q
{% endhighlight %}



{% highlight r %}
table(letFac)
{% endhighlight %}



{% highlight text %}
letFac
A B C D E Q 
2 4 1 2 3 0 
{% endhighlight %}


Counting runs
-------------------------


{% highlight r %}
(vec <- rep(rep(c("f", "m"), 3), c(1, 3, 2, 4, 1, 2)))
{% endhighlight %}



{% highlight text %}
 [1] "f" "m" "m" "m" "f" "f" "m" "m" "m" "m" "f" "m" "m"
{% endhighlight %}



{% highlight r %}
(res <- rle(vec))
{% endhighlight %}



{% highlight text %}
Run Length Encoding
  lengths: int [1:6] 1 3 2 4 1 2
  values : chr [1:6] "f" "m" "f" "m" "f" "m"
{% endhighlight %}



{% highlight r %}
length(res$lengths)
{% endhighlight %}



{% highlight text %}
[1] 6
{% endhighlight %}



{% highlight r %}
inverse.rle(res)
{% endhighlight %}



{% highlight text %}
 [1] "f" "m" "m" "m" "f" "f" "m" "m" "m" "m" "f" "m" "m"
{% endhighlight %}


Contingency tables for two or more variables
-------------------------

### Absolute frequencies using `table()`


{% highlight r %}
N    <- 10
(sex <- factor(sample(c("f", "m"), N, replace=TRUE)))
{% endhighlight %}



{% highlight text %}
 [1] m f m f m m f m m f
Levels: f m
{% endhighlight %}



{% highlight r %}
(work <- factor(sample(c("home", "office"), N, replace=TRUE)))
{% endhighlight %}



{% highlight text %}
 [1] office home   home   home   home   home   office home   home   office
Levels: home office
{% endhighlight %}



{% highlight r %}
(cTab <- table(sex, work))
{% endhighlight %}



{% highlight text %}
   work
sex home office
  f    2      2
  m    5      1
{% endhighlight %}



{% highlight r %}
summary(cTab)
{% endhighlight %}



{% highlight text %}
Number of cases in table: 10 
Number of factors: 2 
Test for independence of all factors:
	Chisq = 1.3, df = 1, p-value = 0.3
	Chi-squared approximation may be incorrect
{% endhighlight %}



{% highlight r %}
barplot(cTab, beside=TRUE, legend.text=rownames(cTab), ylab="absolute frequency")
{% endhighlight %}

![plot of chunk rerFrequencies02](figure/rerFrequencies02.png) 


### Using `xtabs()`


{% highlight r %}
counts   <- sample(0:5, N, replace=TRUE)
(persons <- data.frame(sex, work, counts))
{% endhighlight %}



{% highlight text %}
   sex   work counts
1    m office      2
2    f   home      1
3    m   home      4
4    f   home      4
5    m   home      4
6    m   home      0
7    f office      4
8    m   home      2
9    m   home      4
10   f office      3
{% endhighlight %}



{% highlight r %}
xtabs(~ sex + work, data=persons)
{% endhighlight %}



{% highlight text %}
   work
sex home office
  f    2      2
  m    5      1
{% endhighlight %}



{% highlight r %}
xtabs(counts ~ sex + work, data=persons)
{% endhighlight %}



{% highlight text %}
   work
sex home office
  f    5      7
  m   14      2
{% endhighlight %}


### Marginal sums and means


{% highlight r %}
apply(cTab, MARGIN=1, FUN=sum)
{% endhighlight %}



{% highlight text %}
f m 
4 6 
{% endhighlight %}



{% highlight r %}
colMeans(cTab)
{% endhighlight %}



{% highlight text %}
  home office 
   3.5    1.5 
{% endhighlight %}



{% highlight r %}
addmargins(cTab, c(1, 2), FUN=mean)
{% endhighlight %}



{% highlight text %}
Margins computed over dimensions
in the following order:
1: sex
2: work
{% endhighlight %}



{% highlight text %}
      work
sex    home office mean
  f     2.0    2.0  2.0
  m     5.0    1.0  3.0
  mean  3.5    1.5  2.5
{% endhighlight %}


### Relative frequencies


{% highlight r %}
(relFreq <- prop.table(cTab))
{% endhighlight %}



{% highlight text %}
   work
sex home office
  f  0.2    0.2
  m  0.5    0.1
{% endhighlight %}


### Conditional relative frequencies


{% highlight r %}
prop.table(cTab, 1)
{% endhighlight %}



{% highlight text %}
   work
sex   home office
  f 0.5000 0.5000
  m 0.8333 0.1667
{% endhighlight %}



{% highlight r %}
prop.table(cTab, 2)
{% endhighlight %}



{% highlight text %}
   work
sex   home office
  f 0.2857 0.6667
  m 0.7143 0.3333
{% endhighlight %}


### Flat contingency tables for more than two variables


{% highlight r %}
(group <- factor(sample(c("A", "B"), 10, replace=TRUE)))
{% endhighlight %}



{% highlight text %}
 [1] B B B B A A B B A B
Levels: A B
{% endhighlight %}



{% highlight r %}
ftable(work, sex, group, row.vars="work", col.vars=c("sex", "group"))
{% endhighlight %}



{% highlight text %}
       sex   f   m  
       group A B A B
work                
home         0 2 3 2
office       0 2 0 1
{% endhighlight %}


Recovering the original data from contingency tables
-------------------------

Individual-level data frame


{% highlight r %}
library(epitools)
expand.table(cTab)
{% endhighlight %}



{% highlight text %}
   sex   work
1    f   home
2    f   home
3    f office
4    f office
5    m   home
6    m   home
7    m   home
8    m   home
9    m   home
10   m office
{% endhighlight %}


Group-level data frame


{% highlight r %}
as.data.frame(cTab, stringsAsFactors=TRUE)
{% endhighlight %}



{% highlight text %}
  sex   work Freq
1   f   home    2
2   m   home    5
3   f office    2
4   m office    1
{% endhighlight %}


Percentile rank
-------------------------


{% highlight r %}
(vec <- round(rnorm(10), 2))
{% endhighlight %}



{% highlight text %}
 [1] -0.16 -1.47 -0.48  0.42  1.36 -0.10  0.39 -0.05 -1.38 -0.41
{% endhighlight %}



{% highlight r %}
Fn <- ecdf(vec)
Fn(vec)
{% endhighlight %}



{% highlight text %}
 [1] 0.5 0.1 0.3 0.9 1.0 0.6 0.8 0.7 0.2 0.4
{% endhighlight %}



{% highlight r %}
100 * Fn(0.1)
{% endhighlight %}



{% highlight text %}
[1] 70
{% endhighlight %}



{% highlight r %}
Fn(sort(vec))
{% endhighlight %}



{% highlight text %}
 [1] 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0
{% endhighlight %}



{% highlight r %}
knots(Fn)
{% endhighlight %}



{% highlight text %}
 [1] -1.47 -1.38 -0.48 -0.41 -0.16 -0.10 -0.05  0.39  0.42  1.36
{% endhighlight %}



{% highlight r %}
plot(Fn, main="cumulative frequencies")
{% endhighlight %}

![plot of chunk rerFrequencies03](figure/rerFrequencies03.png) 


Detach (automatically) loaded packages (if possible)
-------------------------


{% highlight r %}
try(detach(package:epitools))
{% endhighlight %}


Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/frequencies.Rmd) - [markdown](https://github.com/dwoll/RExRepos/raw/master/md/frequencies.md) - [R code](https://github.com/dwoll/RExRepos/raw/master/R/frequencies.R) - [all posts](https://github.com/dwoll/RExRepos)
