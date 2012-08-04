Scatter plots and line diagrams
=========================




TODO
-------------------------

 - link to diagAddElements, diagFormat (-> transparency), diagDistributions for `hexbin()` and `smoothScatter()`

Scatter plot
-------------------------

### Simple scatter plot
    

    set.seed(1.234)
    N <- 100
    x <- rnorm(N, 100, 15)
    y <- 0.3*x + rnorm(N, 0, 5)
    plot(x, y)

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2.png) 



    plot(x, y, main="Customized scatter plot", xlim=c(50, 150), ylim=c(10, 50),
         xlab="x axis", ylab="y axis", pch=16, col="darkgray")

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3.png) 



    plot(y, main="Univeriate scatter plot", ylim=c(10, 50),
         xlab="Index", ylab="y axis", pch=4, lwd=2, col="blue")

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4.png) 


### Options for specifying $(x, y)$-coordinate pairs


    xy <- cbind(x, y)
    plot(xy)
    plot(y ~ x)


### Jittering points

Useful if one variable can take on only a few values, and one plot symbol represents many observations.


    z <- sample(0:5, N, replace=TRUE)
    plot(z ~ x, pch=1, col="red", cex=1.5, main="Punktwolke")

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-61.png) 

    plot(jitter(z) ~ x, pch=1, col="red", cex=1.5, main="Punktwolke mit jitter")

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-62.png) 


### Plot types available with `plot()`


    vec <- rnorm(10)
    plot(vec, type="p", xlab=NA, main="type p", cex=1.5)

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-71.png) 

    plot(vec, type="l", xlab=NA, main="type l", cex=1.5)

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-72.png) 

    plot(vec, type="b", xlab=NA, main="type b", cex=1.5)

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-73.png) 

    plot(vec, type="o", xlab=NA, main="type o", cex=1.5)

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-74.png) 

    plot(vec, type="s", xlab=NA, main="type s", cex=1.5)

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-75.png) 

    plot(vec, type="h", xlab=NA, main="type h", cex=1.5)

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-76.png) 


Simultaneously plot several variable pairs
-------------------------


    vec <- seq(from=-2*pi, to=2*pi, length.out=50)
    mat <- cbind(2*sin(vec), sin(vec-(pi/4)), 0.5*sin(vec-(pi/2)))
    matplot(vec, mat, type="b", xlab=NA, ylab=NA, pch=1:3, main="Sinuskurven")

![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-8.png) 


Identify observations from plot points
-------------------------


    plot(vec)
    identify(vec)


Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/diagScatter.Rmd) | [markdown](https://github.com/dwoll/RExRepos/raw/master/md/diagScatter.md) | [R code](https://github.com/dwoll/RExRepos/raw/master/R/diagScatter.R) - ([all posts](https://github.com/dwoll/RExRepos))
