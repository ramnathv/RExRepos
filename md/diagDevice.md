Graphics devices: Opening and saving diagrams
=========================




TODO
-------------------------

 - add regions and margins
 - more device types and options
 - pdf: multiple pages

Opening and closing a device
-------------------------


{% highlight r %}
dev.new(); dev.new(); dev.new()
dev.list()
{% endhighlight %}



{% highlight text %}
pdf pdf pdf pdf 
  2   3   4   5 
{% endhighlight %}



{% highlight r %}
dev.cur()
{% endhighlight %}



{% highlight text %}
pdf 
  5 
{% endhighlight %}



{% highlight r %}
dev.set(3)
{% endhighlight %}



{% highlight text %}
pdf 
  3 
{% endhighlight %}



{% highlight r %}
dev.set(dev.next())
{% endhighlight %}



{% highlight text %}
pdf 
  4 
{% endhighlight %}



{% highlight r %}
dev.off()
{% endhighlight %}



{% highlight text %}
pdf 
  5 
{% endhighlight %}



{% highlight r %}
graphics.off()
{% endhighlight %}


Saving plots to a graphics file
-------------------------


{% highlight r %}
pdf("pdf_test.pdf")
plot(1:10, rnorm(10))
dev.off()
{% endhighlight %}



{% highlight r %}
plot(1:10, rnorm(10))
dev.copy(jpeg, filename="copied.jpg", quality=90)
graphics.off()
{% endhighlight %}


Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/diagDevice.Rmd) - [markdown](https://github.com/dwoll/RExRepos/raw/master/md/diagDevice.md) - [R code](https://github.com/dwoll/RExRepos/raw/master/R/diagDevice.R) - [all posts](https://github.com/dwoll/RExRepos)
