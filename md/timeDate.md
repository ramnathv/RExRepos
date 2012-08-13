Time and date
=========================




Create and format date values
-------------------------

### Class `Date`


{% highlight r %}
Sys.Date()
{% endhighlight %}



{% highlight text %}
[1] "2012-08-13"
{% endhighlight %}



{% highlight r %}
(myDate <- as.Date("01.11.1974", format="%d.%m.%Y"))
{% endhighlight %}



{% highlight text %}
[1] "1974-11-01"
{% endhighlight %}



{% highlight r %}
format(myDate, format="%d.%m.%Y")
{% endhighlight %}



{% highlight text %}
[1] "01.11.1974"
{% endhighlight %}


### Internal representation


{% highlight r %}
(negDate <- as.Date(-374, "1910-12-16"))
{% endhighlight %}



{% highlight text %}
[1] "1909-12-07"
{% endhighlight %}



{% highlight r %}
as.numeric(negDate)
{% endhighlight %}



{% highlight text %}
[1] -21940
{% endhighlight %}


Time values
-------------------------

### Class `POSIXct`


{% highlight r %}
Sys.time()
{% endhighlight %}



{% highlight text %}
[1] "2012-08-13 14:53:49 CEST"
{% endhighlight %}



{% highlight r %}
date()
{% endhighlight %}



{% highlight text %}
[1] "Mon Aug 13 14:53:49 2012"
{% endhighlight %}



{% highlight r %}
(myTime <- as.POSIXct("2009-02-07 09:23:02"))
{% endhighlight %}



{% highlight text %}
[1] "2009-02-07 09:23:02 CET"
{% endhighlight %}



{% highlight r %}
ISOdate(2010, 6, 30, 17, 32, 10, tz="CET")
{% endhighlight %}



{% highlight text %}
[1] "2010-06-30 17:32:10 CEST"
{% endhighlight %}



{% highlight r %}
format(myTime, "%H:%M:%S")
{% endhighlight %}



{% highlight text %}
[1] "09:23:02"
{% endhighlight %}



{% highlight r %}
format(myTime, "%d.%m.%Y")
{% endhighlight %}



{% highlight text %}
[1] "07.02.2009"
{% endhighlight %}


### Class `POSIXlt`


{% highlight r %}
charDates <- c("05.08.1972, 03:37", "02.04.1981, 12:44")
(lDates   <- strptime(charDates, format="%d.%m.%Y, %H:%M"))
{% endhighlight %}



{% highlight text %}
[1] "1972-08-05 03:37:00" "1981-04-02 12:44:00"
{% endhighlight %}



{% highlight r %}
lDates$mday
{% endhighlight %}



{% highlight text %}
[1] 5 2
{% endhighlight %}



{% highlight r %}
lDates$hour
{% endhighlight %}



{% highlight text %}
[1]  3 12
{% endhighlight %}



{% highlight r %}
weekdays(lDates)
{% endhighlight %}



{% highlight text %}
[1] "Samstag"    "Donnerstag"
{% endhighlight %}



{% highlight r %}
months(lDates)
{% endhighlight %}



{% highlight text %}
[1] "August" "April" 
{% endhighlight %}


Time and date arithmetic
-------------------------

### Sum and difference of time-date values


{% highlight r %}
(myDate <- as.Date("01.11.1974", format="%d.%m.%Y"))
{% endhighlight %}



{% highlight text %}
[1] "1974-11-01"
{% endhighlight %}



{% highlight r %}
myDate + 365
{% endhighlight %}



{% highlight text %}
[1] "1975-11-01"
{% endhighlight %}



{% highlight r %}
(diffDate <- as.Date("1976-06-19") - myDate)
{% endhighlight %}



{% highlight text %}
Time difference of 596 days
{% endhighlight %}



{% highlight r %}
as.numeric(diffDate)
{% endhighlight %}



{% highlight text %}
[1] 596
{% endhighlight %}



{% highlight r %}
myDate + diffDate
{% endhighlight %}



{% highlight text %}
[1] "1976-06-19"
{% endhighlight %}



{% highlight r %}
lDates + c(60, 120)
{% endhighlight %}



{% highlight text %}
[1] "1972-08-05 03:38:00 CET"  "1981-04-02 12:46:00 CEST"
{% endhighlight %}



{% highlight r %}
(diff21 <- lDates[2] - lDates[1])
{% endhighlight %}



{% highlight text %}
Time difference of 3162 days
{% endhighlight %}



{% highlight r %}
lDates[1] + diff21
{% endhighlight %}



{% highlight text %}
[1] "1981-04-02 12:44:00 CEST"
{% endhighlight %}


### Systematically and randomly generate time-date values


{% highlight r %}
seq(ISOdate(2010, 5, 1), ISOdate(2013, 5, 1), by="years")
{% endhighlight %}



{% highlight text %}
[1] "2010-05-01 12:00:00 GMT" "2011-05-01 12:00:00 GMT"
[3] "2012-05-01 12:00:00 GMT" "2013-05-01 12:00:00 GMT"
{% endhighlight %}



{% highlight r %}
seq(ISOdate(1997, 10, 22), by="2 weeks", length.out=4)
{% endhighlight %}



{% highlight text %}
[1] "1997-10-22 12:00:00 GMT" "1997-11-05 12:00:00 GMT"
[3] "1997-11-19 12:00:00 GMT" "1997-12-03 12:00:00 GMT"
{% endhighlight %}



{% highlight r %}
secsPerDay <- 60 * 60 * 24
randDates  <- ISOdate(1995, 6, 13) + sample(0:(28*secsPerDay), 100, replace=TRUE)
randWeeks  <- cut(randDates, breaks="week")
summary(randWeeks)
{% endhighlight %}



{% highlight text %}
1995-06-12 1995-06-19 1995-06-26 1995-07-03 1995-07-10 
        21         27         25         25          2 
{% endhighlight %}


Useful packages
-------------------------

Packages [`timeDate`](http://cran.r-project.org/package=timeDate) and [`lubridate`](http://cran.r-project.org/package=lubridate) provide more functions for efficiently and consistently handling times and dates. More packages can be found in CRAN task view [Time Series](http://cran.r-project.org/web/views/TimeSeries.html).

Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/timeDate.Rmd) - [markdown](https://github.com/dwoll/RExRepos/raw/master/md/timeDate.md) - [R code](https://github.com/dwoll/RExRepos/raw/master/R/timeDate.R) - [all posts](https://github.com/dwoll/RExRepos)
