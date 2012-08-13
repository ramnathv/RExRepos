Sets
=========================

TODO
-------------------------

 - link to combinatorics

Install required packages
-------------------------

[`sets`](http://cran.r-project.org/package=sets)


{% highlight r %}
wants <- c("sets")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])
{% endhighlight %}


Treating duplicate values
-------------------------


{% highlight r %}
a <- c(4, 5, 6)
b <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
m <- c(2, 1, 3, 2, 1)
n <- c(5, 3, 1, 3, 4, 4)
x <- c(1, 1, 2, 2)
y <- c(2, 1)
{% endhighlight %}



{% highlight r %}
setequal(x, y)
{% endhighlight %}



{% highlight text %}
[1] TRUE
{% endhighlight %}



{% highlight r %}
duplicated(c(1, 1, 1, 3, 3, 4, 4))
{% endhighlight %}



{% highlight text %}
[1] FALSE  TRUE  TRUE FALSE  TRUE FALSE  TRUE
{% endhighlight %}



{% highlight r %}
unique(c(1, 1, 1, 3, 3, 4, 4))
{% endhighlight %}



{% highlight text %}
[1] 1 3 4
{% endhighlight %}



{% highlight r %}
length(unique(c("A", "B", "C", "C", "B", "B", "A", "C", "C", "A")))
{% endhighlight %}



{% highlight text %}
[1] 3
{% endhighlight %}


Set operations
-------------------------

### Union

{% highlight r %}
union(m, n)
{% endhighlight %}



{% highlight text %}
[1] 2 1 3 5 4
{% endhighlight %}


### Intersection


{% highlight r %}
intersect(m, n)
{% endhighlight %}



{% highlight text %}
[1] 1 3
{% endhighlight %}


### Asymmetric and symmetric difference


{% highlight r %}
setdiff(m, n)
{% endhighlight %}



{% highlight text %}
[1] 2
{% endhighlight %}



{% highlight r %}
setdiff(n, m)
{% endhighlight %}



{% highlight text %}
[1] 5 4
{% endhighlight %}



{% highlight r %}
union(setdiff(m, n), setdiff(n, m))
{% endhighlight %}



{% highlight text %}
[1] 2 5 4
{% endhighlight %}


### Is \(e\) an element of set \(X\)?


{% highlight r %}
is.element(c(29, 23, 30, 17, 30, 10), c(30, 23))
{% endhighlight %}



{% highlight text %}
[1] FALSE  TRUE  TRUE FALSE  TRUE FALSE
{% endhighlight %}



{% highlight r %}
c("A", "Z", "B") %in% c("A", "B", "C", "D", "E")
{% endhighlight %}



{% highlight text %}
[1]  TRUE FALSE  TRUE
{% endhighlight %}


### (Proper) subset


{% highlight r %}
(AinB <- all(a %in% b))
{% endhighlight %}



{% highlight text %}
[1] TRUE
{% endhighlight %}



{% highlight r %}
(BinA <- all(b %in% a))
{% endhighlight %}



{% highlight text %}
[1] FALSE
{% endhighlight %}



{% highlight r %}
AinB & !BinA
{% endhighlight %}



{% highlight text %}
[1] TRUE
{% endhighlight %}


Set operations using package `sets`
-------------------------


{% highlight r %}
library(sets)
sa <- set(4, 5, 6)
sb <- set(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
sm <- set(2, 1, 3, 2, 1)
sn <- set(5, 3, 1, 3, 4, 4)
sx <- set(1, 1, 2, 2)
sy <- set(2, 1)
se <- 4

set_is_empty(sa)
{% endhighlight %}



{% highlight text %}
[1] FALSE
{% endhighlight %}



{% highlight r %}
set_cardinality(sx)
{% endhighlight %}



{% highlight text %}
[1] 2
{% endhighlight %}



{% highlight r %}
set_power(sm)
{% endhighlight %}



{% highlight text %}
{{}, {1}, {2}, {3}, {1, 2}, {1, 3}, {2, 3}, {1, 2, 3}}
{% endhighlight %}



{% highlight r %}
set_cartesian(sa, sx)
{% endhighlight %}



{% highlight text %}
{(4, 1), (4, 2), (5, 1), (5, 2), (6, 1), (6, 2)}
{% endhighlight %}



{% highlight r %}
set_is_equal(sx, sy)
{% endhighlight %}



{% highlight text %}
[1] TRUE
{% endhighlight %}



{% highlight r %}
set_union(sm, sn)
{% endhighlight %}



{% highlight text %}
{1, 2, 3, 4, 5}
{% endhighlight %}



{% highlight r %}
set_intersection(sm, sn)
{% endhighlight %}



{% highlight text %}
{1, 3}
{% endhighlight %}



{% highlight r %}
set_symdiff(sa, sb)
{% endhighlight %}



{% highlight text %}
{1, 2, 3, 7, 8, 9, 10}
{% endhighlight %}



{% highlight r %}
set_complement(sm, sn)
{% endhighlight %}



{% highlight text %}
{4, 5}
{% endhighlight %}



{% highlight r %}
set_is_subset(sa, sb)
{% endhighlight %}



{% highlight text %}
[1] TRUE
{% endhighlight %}



{% highlight r %}
set_is_proper_subset(sa, sb)
{% endhighlight %}



{% highlight text %}
[1] TRUE
{% endhighlight %}



{% highlight r %}
set_contains_element(sa, se)
{% endhighlight %}



{% highlight text %}
[1] TRUE
{% endhighlight %}


Detach (automatically) loaded packages (if possible)
-------------------------


{% highlight r %}
try(detach(package:sets))
{% endhighlight %}


Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/sets.Rmd) - [markdown](https://github.com/dwoll/RExRepos/raw/master/md/sets.md) - [R code](https://github.com/dwoll/RExRepos/raw/master/R/sets.R) - [all posts](https://github.com/dwoll/RExRepos)
