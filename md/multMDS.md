Multidimensional scaling (MDS)
=========================

Install required packages
-------------------------

[`vegan`](http://cran.r-project.org/package=vegan)


{% highlight r %}
wants <- c("vegan")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])
{% endhighlight %}


Metric MDS
-------------------------

### Given a distance matrix


{% highlight r %}
cities <- c("Augsburg", "Berlin", "Dresden", "Hamburg", "Hannover",
            "Karlsruhe", "Kiel", "Muenchen", "Rostock", "Stuttgart")
N      <- length(cities)
dstMat <- matrix(numeric(N^2), nrow=N)
##             B   DD   HH    H   KA   KI    M  HRO    S
cityDst <- c(596, 467, 743, 599, 226, 838,  65, 782, 160, ## AUG
                  194, 288, 286, 673, 353, 585, 231, 633, ## B
                       477, 367, 550, 542, 465, 420, 510, ## DD
                            157, 623,  96, 775, 187, 665, ## HH
                                 480, 247, 632, 330, 512, ## H
                                      723, 298, 805,  80, ## KA
                                           872, 206, 752, ## KI
                                                777, 220, ## M
                                                     824) ## HRO

dstMat[upper.tri(dstMat)] <- rev(cityDst)
dstMat <- t(dstMat[ , N:1])[ , N:1]
dstMat[lower.tri(dstMat)] <- t(dstMat)[lower.tri(dstMat)]
dimnames(dstMat) <- list(city=cities, city=cities)
{% endhighlight %}



{% highlight r %}
(mds <- cmdscale(dstMat, k=2))
{% endhighlight %}



{% highlight text %}
             [,1]    [,2]
Augsburg   399.61  -70.51
Berlin    -200.20 -183.39
Dresden    -18.47 -213.02
Hamburg   -316.40  130.72
Hannover  -161.38  120.22
Karlsruhe  333.39  212.13
Kiel      -409.09  147.62
Muenchen   408.56 -144.46
Rostock   -401.20 -126.21
Stuttgart  365.19  126.91
{% endhighlight %}


### Given object-wise ratings


{% highlight r %}
set.seed(1.234)
P   <- 3
obj <- matrix(sample(-20:20, N*P, replace=TRUE), ncol=P)
dst <- dist(obj, diag=TRUE, upper=TRUE)
cmdscale(dst, k=2)
{% endhighlight %}


### Plot


{% highlight r %}
xLims <- range(mds[ , 1]) + c(0, 250)
plot(mds, xlim=xLims, xlab="North-South", ylab="East-West", pch=16,
     main="City locations according to MDS")
text(mds[ , 1]+50, mds[ , 2], adj=0, labels=cities)
{% endhighlight %}

![plot of chunk rerMultMDS01](figure/rerMultMDS01.png) 


Non-metric MDS
-------------------------


{% highlight r %}
library(vegan)
(nmMDS <- monoMDS(dstMat, k=2))
{% endhighlight %}



{% highlight text %}

Call:
monoMDS(dist = dstMat, k = 2) 

Non-metric Multidimensional Scaling

10 points, dissimilarity 'unknown'

Dimensions: 2 
Stress:     0.03911 
Stress type 1, weak ties
Scores scaled to unit root mean square, rotated to principal components
Stopped after 57 iterations: Scale factor of gradient nearly zero
{% endhighlight %}



{% highlight r %}
scores(nmMDS)
{% endhighlight %}



{% highlight text %}
              MDS1     MDS2
Augsburg  -1.14117 -0.18781
Berlin     0.50459 -0.51167
Dresden    0.08429 -0.71736
Hamburg    0.85574  0.33510
Hannover   0.40313  0.39986
Karlsruhe -0.92301  0.61331
Kiel       1.15409 -0.04916
Muenchen  -1.14863 -0.24649
Rostock    1.20672  0.16289
Stuttgart -0.99576  0.20133
attr(,"pc")
[1] TRUE
{% endhighlight %}


Detach (automatically) loaded packages (if possible)
-------------------------


{% highlight r %}
try(detach(package:vegan))
try(detach(package:permute))
{% endhighlight %}


Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/multMDS.Rmd) - [markdown](https://github.com/dwoll/RExRepos/raw/master/md/multMDS.md) - [R code](https://github.com/dwoll/RExRepos/raw/master/R/multMDS.R) - [all posts](https://github.com/dwoll/RExRepos)
