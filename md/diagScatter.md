Scatter plots and line diagrams
=========================




TODO
-------------------------

 - link to diagAddElements, diagFormat (-> transparency), diagDistributions for `hexbin()` and `smoothScatter()`

Scatter plot
-------------------------

### Simple scatter plot
    

{% highlight r %}
set.seed(1.234)
N <- 100
x <- rnorm(N, 100, 15)
y <- 0.3*x + rnorm(N, 0, 5)
plot(x, y)
{% endhighlight %}

![plot of chunk rerDiagScatter01](figure/rerDiagScatter01.png) 



{% highlight r %}
plot(x, y, main="Customized scatter plot", xlim=c(50, 150), ylim=c(10, 50),
     xlab="x axis", ylab="y axis", pch=16, col="darkgray")
{% endhighlight %}

![plot of chunk rerDiagScatter02](figure/rerDiagScatter02.png) 



{% highlight r %}
plot(y, main="Univeriate scatter plot", ylim=c(10, 50),
     xlab="Index", ylab="y axis", pch=4, lwd=2, col="blue")
{% endhighlight %}

![plot of chunk rerDiagScatter03](figure/rerDiagScatter03.png) 


### Options for specifying \((x, y)\)-coordinate pairs


{% highlight r %}
xy <- cbind(x, y)
plot(xy)
plot(y ~ x)
{% endhighlight %}


### Jittering points

Useful if one variable can take on only a few values, and one plot symbol represents many observations.


{% highlight r %}
z <- sample(0:5, N, replace=TRUE)
plot(z ~ x, pch=1, col="red", cex=1.5, main="Scatter plot")
{% endhighlight %}

![plot of chunk rerDiagScatter04](figure/rerDiagScatter041.png) 

{% highlight r %}
plot(jitter(z) ~ x, pch=1, col="red", cex=1.5,
     main="Scatter plot with jittered y-coordinate")
{% endhighlight %}

![plot of chunk rerDiagScatter04](figure/rerDiagScatter042.png) 


### Plot types available with `plot()`


{% highlight r %}
vec <- rnorm(10)
plot(vec, type="p", xlab=NA, main="type p", cex=1.5)
{% endhighlight %}

![plot of chunk rerDiagScatter05](figure/rerDiagScatter051.png) 

{% highlight r %}
plot(vec, type="l", xlab=NA, main="type l", cex=1.5)
{% endhighlight %}

![plot of chunk rerDiagScatter05](figure/rerDiagScatter052.png) 

{% highlight r %}
plot(vec, type="b", xlab=NA, main="type b", cex=1.5)
{% endhighlight %}

![plot of chunk rerDiagScatter05](figure/rerDiagScatter053.png) 

{% highlight r %}
plot(vec, type="o", xlab=NA, main="type o", cex=1.5)
{% endhighlight %}

![plot of chunk rerDiagScatter05](figure/rerDiagScatter054.png) 

{% highlight r %}
plot(vec, type="s", xlab=NA, main="type s", cex=1.5)
{% endhighlight %}

![plot of chunk rerDiagScatter05](figure/rerDiagScatter055.png) 

{% highlight r %}
plot(vec, type="h", xlab=NA, main="type h", cex=1.5)
{% endhighlight %}

![plot of chunk rerDiagScatter05](figure/rerDiagScatter056.png) 


Simultaneously plot several variable pairs
-------------------------


{% highlight r %}
vec <- seq(from=-2*pi, to=2*pi, length.out=50)
mat <- cbind(2*sin(vec), sin(vec-(pi/4)), 0.5*sin(vec-(pi/2)))
matplot(vec, mat, type="b", xlab=NA, ylab=NA, pch=1:3, main="Sine-curves")
{% endhighlight %}

![plot of chunk rerDiagScatter06](figure/rerDiagScatter06.png) 


Identify observations from plot points
-------------------------


{% highlight r %}
plot(vec)
identify(vec)
{% endhighlight %}


Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/diagScatter.Rmd) - [markdown](https://github.com/dwoll/RExRepos/raw/master/md/diagScatter.md) - [R code](https://github.com/dwoll/RExRepos/raw/master/R/diagScatter.R) - [all posts](https://github.com/dwoll/RExRepos)
