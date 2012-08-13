Transform data frames
=========================

TODO
-------------------------

 - link to strings for `grep()`, dfSplitMerge, dfReshape

Add variables to a data frame
-------------------------


{% highlight r %}
set.seed(1.234)
N      <- 12
sex    <- sample(c("f", "m"), N, replace=TRUE)
group  <- sample(rep(c("CG", "WL", "T"), 4), N, replace=FALSE)
age    <- sample(18:35, N, replace=TRUE)
IQ     <- round(rnorm(N, mean=100, sd=15))
rating <- round(runif(N, min=0, max=6))
(myDf1 <- data.frame(id=1:N, sex, group, age, IQ, rating))
{% endhighlight %}



{% highlight text %}
   id sex group age  IQ rating
1   1   f     T  22 112      5
2   2   f    WL  24 109      2
3   3   m    WL  18 114      3
4   4   m    WL  24 112      2
5   5   f     T  33 101      4
6   6   m    CG  24  70      2
7   7   m     T  26 109      3
8   8   m    CG  28  99      5
9   9   m     T  26  98      1
10 10   f    CG  21  78      5
11 11   f    WL  32  93      2
12 12   f    CG  30 106      5
{% endhighlight %}



{% highlight r %}
isSingle <- sample(c(TRUE, FALSE), nrow(myDf1), replace=TRUE)
myDf2    <- myDf1
myDf2$isSingle1    <- isSingle
myDf2["isSingle2"] <- isSingle
myDf3 <- cbind(myDf1, isSingle)
head(myDf3)
{% endhighlight %}



{% highlight text %}
  id sex group age  IQ rating isSingle
1  1   f     T  22 112      5     TRUE
2  2   f    WL  24 109      2     TRUE
3  3   m    WL  18 114      3     TRUE
4  4   m    WL  24 112      2    FALSE
5  5   f     T  33 101      4    FALSE
6  6   m    CG  24  70      2     TRUE
{% endhighlight %}



{% highlight r %}
myDf4 <- transform(myDf3, rSq=rating^2)
head(myDf4)
{% endhighlight %}



{% highlight text %}
  id sex group age  IQ rating isSingle rSq
1  1   f     T  22 112      5     TRUE  25
2  2   f    WL  24 109      2     TRUE   4
3  3   m    WL  18 114      3     TRUE   9
4  4   m    WL  24 112      2    FALSE   4
5  5   f     T  33 101      4    FALSE  16
6  6   m    CG  24  70      2     TRUE   4
{% endhighlight %}


Remove variables from a data frame
-------------------------


{% highlight r %}
dfTemp       <- myDf1
dfTemp$group <- NULL
head(dfTemp)
{% endhighlight %}



{% highlight text %}
  id sex age  IQ rating
1  1   f  22 112      5
2  2   f  24 109      2
3  3   m  18 114      3
4  4   m  24 112      2
5  5   f  33 101      4
6  6   m  24  70      2
{% endhighlight %}



{% highlight r %}
delVars         <- c("sex", "IQ")
dfTemp[delVars] <- list(NULL)
head(dfTemp)
{% endhighlight %}



{% highlight text %}
  id age rating
1  1  22      5
2  2  24      2
3  3  18      3
4  4  24      2
5  5  33      4
6  6  24      2
{% endhighlight %}


Sort data frames
-------------------------


{% highlight r %}
(idx1 <- order(myDf1$rating))
{% endhighlight %}



{% highlight text %}
 [1]  9  2  4  6 11  3  7  5  1  8 10 12
{% endhighlight %}



{% highlight r %}
myDf1[idx1, ]
{% endhighlight %}



{% highlight text %}
   id sex group age  IQ rating
9   9   m     T  26  98      1
2   2   f    WL  24 109      2
4   4   m    WL  24 112      2
6   6   m    CG  24  70      2
11 11   f    WL  32  93      2
3   3   m    WL  18 114      3
7   7   m     T  26 109      3
5   5   f     T  33 101      4
1   1   f     T  22 112      5
8   8   m    CG  28  99      5
10 10   f    CG  21  78      5
12 12   f    CG  30 106      5
{% endhighlight %}



{% highlight r %}
(idx2 <- order(myDf1$group, myDf1$IQ))
{% endhighlight %}



{% highlight text %}
 [1]  6 10  8 12  9  5  7  1 11  2  4  3
{% endhighlight %}



{% highlight r %}
myDf1[idx2, ]
{% endhighlight %}



{% highlight text %}
   id sex group age  IQ rating
6   6   m    CG  24  70      2
10 10   f    CG  21  78      5
8   8   m    CG  28  99      5
12 12   f    CG  30 106      5
9   9   m     T  26  98      1
5   5   f     T  33 101      4
7   7   m     T  26 109      3
1   1   f     T  22 112      5
11 11   f    WL  32  93      2
2   2   f    WL  24 109      2
4   4   m    WL  24 112      2
3   3   m    WL  18 114      3
{% endhighlight %}



{% highlight r %}
(idx3 <- order(myDf1$group, -myDf1$rating))
{% endhighlight %}



{% highlight text %}
 [1]  8 10 12  6  1  5  7  9  3  2  4 11
{% endhighlight %}



{% highlight r %}
myDf1[idx3, ]
{% endhighlight %}



{% highlight text %}
   id sex group age  IQ rating
8   8   m    CG  28  99      5
10 10   f    CG  21  78      5
12 12   f    CG  30 106      5
6   6   m    CG  24  70      2
1   1   f     T  22 112      5
5   5   f     T  33 101      4
7   7   m     T  26 109      3
9   9   m     T  26  98      1
3   3   m    WL  18 114      3
2   2   f    WL  24 109      2
4   4   m    WL  24 112      2
11 11   f    WL  32  93      2
{% endhighlight %}


Select subsets of data
-------------------------

### Select cases and variables using index vectors


{% highlight r %}
(idxLog <- myDf1$sex == "f")
{% endhighlight %}



{% highlight text %}
 [1]  TRUE  TRUE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE  TRUE
[12]  TRUE
{% endhighlight %}



{% highlight r %}
(idxNum <- which(idxLog))
{% endhighlight %}



{% highlight text %}
[1]  1  2  5 10 11 12
{% endhighlight %}



{% highlight r %}
myDf1[idxNum, ]
{% endhighlight %}



{% highlight text %}
   id sex group age  IQ rating
1   1   f     T  22 112      5
2   2   f    WL  24 109      2
5   5   f     T  33 101      4
10 10   f    CG  21  78      5
11 11   f    WL  32  93      2
12 12   f    CG  30 106      5
{% endhighlight %}



{% highlight r %}
(idx2 <- (myDf1$sex == "m") & (myDf1$rating > 2))
{% endhighlight %}



{% highlight text %}
 [1] FALSE FALSE  TRUE FALSE FALSE FALSE  TRUE  TRUE FALSE FALSE FALSE
[12] FALSE
{% endhighlight %}



{% highlight r %}
myDf1[which(idx2), ]
{% endhighlight %}



{% highlight text %}
  id sex group age  IQ rating
3  3   m    WL  18 114      3
7  7   m     T  26 109      3
8  8   m    CG  28  99      5
{% endhighlight %}



{% highlight r %}
(idx3 <- (myDf1$IQ < 90) | (myDf1$IQ > 110))
{% endhighlight %}



{% highlight text %}
 [1]  TRUE FALSE  TRUE  TRUE FALSE  TRUE FALSE FALSE FALSE  TRUE FALSE
[12] FALSE
{% endhighlight %}



{% highlight r %}
myDf1[which(idx3), ]
{% endhighlight %}



{% highlight text %}
   id sex group age  IQ rating
1   1   f     T  22 112      5
3   3   m    WL  18 114      3
4   4   m    WL  24 112      2
6   6   m    CG  24  70      2
10 10   f    CG  21  78      5
{% endhighlight %}



{% highlight r %}
myDf1[1:3, c("group", "IQ")]
{% endhighlight %}



{% highlight text %}
  group  IQ
1     T 112
2    WL 109
3    WL 114
{% endhighlight %}



{% highlight r %}
myDf1[1:3, 2:4]
{% endhighlight %}



{% highlight text %}
  sex group age
1   f     T  22
2   f    WL  24
3   m    WL  18
{% endhighlight %}



{% highlight r %}
dfTemp         <- myDf1
(names(dfTemp) <- paste(rep(c("A", "B"), each=3), 100:102, sep=""))
{% endhighlight %}



{% highlight text %}
[1] "A100" "A101" "A102" "B100" "B101" "B102"
{% endhighlight %}



{% highlight r %}
(colIdx <- grep("^B.*$", names(dfTemp)))
{% endhighlight %}



{% highlight text %}
[1] 4 5 6
{% endhighlight %}



{% highlight r %}
dfTemp[1:3, colIdx]
{% endhighlight %}



{% highlight text %}
  B100 B101 B102
1   22  112    5
2   24  109    2
3   18  114    3
{% endhighlight %}


See `?Extract` for help on this topic.

### Select cases and variables using `subset()`


{% highlight r %}
subset(myDf1, sex == "f")
{% endhighlight %}



{% highlight text %}
   id sex group age  IQ rating
1   1   f     T  22 112      5
2   2   f    WL  24 109      2
5   5   f     T  33 101      4
10 10   f    CG  21  78      5
11 11   f    WL  32  93      2
12 12   f    CG  30 106      5
{% endhighlight %}



{% highlight r %}
subset(myDf1, sex == "f", select=-2)
{% endhighlight %}



{% highlight text %}
   id group age  IQ rating
1   1     T  22 112      5
2   2    WL  24 109      2
5   5     T  33 101      4
10 10    CG  21  78      5
11 11    WL  32  93      2
12 12    CG  30 106      5
{% endhighlight %}



{% highlight r %}
subset(myDf1, (sex == "m") & (rating > 2))
{% endhighlight %}



{% highlight text %}
  id sex group age  IQ rating
3  3   m    WL  18 114      3
7  7   m     T  26 109      3
8  8   m    CG  28  99      5
{% endhighlight %}



{% highlight r %}
subset(myDf1, (IQ < 90) | (IQ > 110))
{% endhighlight %}



{% highlight text %}
   id sex group age  IQ rating
1   1   f     T  22 112      5
3   3   m    WL  18 114      3
4   4   m    WL  24 112      2
6   6   m    CG  24  70      2
10 10   f    CG  21  78      5
{% endhighlight %}



{% highlight r %}
subset(myDf1, group %in% c("CG", "WL"))
{% endhighlight %}



{% highlight text %}
   id sex group age  IQ rating
2   2   f    WL  24 109      2
3   3   m    WL  18 114      3
4   4   m    WL  24 112      2
6   6   m    CG  24  70      2
8   8   m    CG  28  99      5
10 10   f    CG  21  78      5
11 11   f    WL  32  93      2
12 12   f    CG  30 106      5
{% endhighlight %}


Remove duplicated cases
-------------------------


{% highlight r %}
myDfDouble <- rbind(myDf1, myDf1[sample(1:nrow(myDf1), 4), ])
duplicated(myDfDouble)
{% endhighlight %}



{% highlight text %}
 [1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[12] FALSE  TRUE  TRUE  TRUE  TRUE
{% endhighlight %}



{% highlight r %}
myDfUnique <- unique(myDfDouble)
{% endhighlight %}


Treat missing values
-------------------------


{% highlight r %}
myDfNA           <- myDf1
myDfNA$IQ[4]     <- NA
myDfNA$rating[5] <- NA
{% endhighlight %}



{% highlight r %}
is.na(myDfNA)[1:5, c("age", "IQ", "rating")]
{% endhighlight %}



{% highlight text %}
       age    IQ rating
[1,] FALSE FALSE  FALSE
[2,] FALSE FALSE  FALSE
[3,] FALSE FALSE  FALSE
[4,] FALSE  TRUE  FALSE
[5,] FALSE FALSE   TRUE
{% endhighlight %}



{% highlight r %}
apply(is.na(myDfNA), 2, any)
{% endhighlight %}



{% highlight text %}
    id    sex  group    age     IQ rating 
 FALSE  FALSE  FALSE  FALSE   TRUE   TRUE 
{% endhighlight %}



{% highlight r %}
complete.cases(myDfNA)
{% endhighlight %}



{% highlight text %}
 [1]  TRUE  TRUE  TRUE FALSE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
[12]  TRUE
{% endhighlight %}



{% highlight r %}
subset(myDfNA, !complete.cases(myDfNA))
{% endhighlight %}



{% highlight text %}
  id sex group age  IQ rating
4  4   m    WL  24  NA      2
5  5   f     T  33 101     NA
{% endhighlight %}



{% highlight r %}
head(na.omit(myDfNA))
{% endhighlight %}



{% highlight text %}
  id sex group age  IQ rating
1  1   f     T  22 112      5
2  2   f    WL  24 109      2
3  3   m    WL  18 114      3
6  6   m    CG  24  70      2
7  7   m     T  26 109      3
8  8   m    CG  28  99      5
{% endhighlight %}


Useful packages
-------------------------

Package [`plyr`](http://cran.r-project.org/package=plyr) provides very handy functions for the split-apply-combine approach to aggregating data frames.

Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/dfTransform.Rmd) - [markdown](https://github.com/dwoll/RExRepos/raw/master/md/dfTransform.md) - [R code](https://github.com/dwoll/RExRepos/raw/master/R/dfTransform.R) - [all posts](https://github.com/dwoll/RExRepos)
