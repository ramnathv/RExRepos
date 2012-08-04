Visualize univariate and bivariate distributions
=========================




TODO
-------------------------

 - link to diagCategorical, diagScatter, diagMultivariate, diagAddElements, diagBounding
 - new R 2.15.1+ `qqplot()` options `distribution` and `probs`

Install required packages
-------------------------

[`car`](http://cran.r-project.org/package=car), [`hexbin`](http://cran.r-project.org/package=hexbin)


    wants <- c("car", "hexbin")
    has   <- wants %in% rownames(installed.packages())
    if(any(!has)) install.packages(wants[!has])


Histograms
-------------------------

### Histogram with absolute class frequencies
    

    set.seed(1.234)
    x <- rnorm(200, 175, 10)
    hist(x, xlab="x", ylab="N", breaks="FD")

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3.png) 


### Add individual values and theoretical density function


    hist(x, freq=FALSE, xlab="x", ylab="relative Haeufigkeit",
         breaks="FD", main="Histogramm und Normalverteilung")
    rug(jitter(x))
    curve(dnorm(x, mean(x), sd(x)), lwd=2, col="blue", add=TRUE)

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4.png) 


### Add estimated density function


    hist(x, freq=FALSE, xlab="x", breaks="FD",
         main="Histogram and density estimate")
    lines(density(x), lwd=2, col="blue")
    rug(jitter(x))

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5.png) 


To compare histograms from two groups, see `histbackback()` from package [Hmisc](http://cran.r-project.org/package=Hmisc).

Stem and leaf plot
-------------------------


    y <- rnorm(100, mean=175, sd=7)
    stem(y)

    
      The decimal point is 1 digit(s) to the right of the |
    
      15 | 4
      15 | 9
      16 | 01134444
      16 | 5556777788999
      17 | 0000000011111222222222233444
      17 | 5555555667777788999999999
      18 | 001122333344
      18 | 5556778
      19 | 0112
      19 | 
      20 | 2
    


Boxplot
-------------------------


    Nj <- 40
    P  <- 3
    DV <- rnorm(P*Nj, mean=100, sd=15)
    IV <- gl(P, Nj, labels=c("Control", "Group A", "Group B"))



    boxplot(DV ~ IV, ylab="Score", col=c("red", "blue", "green"),
            main="Boxplots der Scores in 3 Gruppen", cex.lab=1.2)
    stripchart(DV ~ IV, pch=16, col="darkgray", vert=TRUE, add=TRUE)

![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-8.png) 



    xC <- DV[IV == "Control"]
    xA <- DV[IV == "Group A"]
    boxplot(xC, xA)

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-9.png) 


Dotchart
-------------------------


    Nj  <- 5
    DV1 <- rnorm(Nj, 20, 2)
    DV2 <- rnorm(Nj, 25, 2)
    DV  <- c(DV1, DV2)
    IV  <- gl(2, Nj)
    Mj  <- tapply(DV, IV, FUN=mean)



    dotchart(DV, gdata=Mj, pch=16, color=rep(c("red", "blue"), each=Nj),
             gcolor="black", labels=rep(LETTERS[1:Nj], 2), groups=IV, xlab="AV",
             ylab="Gruppen",
             main="Individuelle Ergebnisse und Mittelwerte aus 2 Gruppen")

![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-11.png) 


Stripchart
-------------------------


    Nj   <- 25
    P    <- 4
    dice <- sample(1:6, P*Nj, replace=TRUE)
    IV   <- gl(P, Nj)

    stripchart(dice ~ IV, xlab="Augenzahl", ylab="Gruppe", pch=1,  col="blue",
               main="Wuerfelwuerfe - 4 Gruppen", sub="jitter-Methode", method="jitter")

![plot of chunk unnamed-chunk-13](figure/unnamed-chunk-131.png) 

    stripchart(dice ~ IV, xlab="Augenzahl", ylab="Gruppe", pch=16, col="red",
               main="Wuerfelwuerfe - 4 Gruppen", sub="stack-Methode",  method="stack")

![plot of chunk unnamed-chunk-13](figure/unnamed-chunk-132.png) 


QQ-plot
-------------------------


    DV1 <- rnorm(200)
    DV2 <- rf(200, df1=3, df2=15)
    qqplot(DV1, DV2, xlab="Quantile N(0, 1)", ylab="Quantile F(3, 15)",
           main="Vergleich der Quantile von N(0, 1) und F(3, 15)-Verteilung")

![plot of chunk unnamed-chunk-14](figure/unnamed-chunk-14.png) 



    height <- rnorm(100, mean=175, sd=7)
    qqnorm(height)
    qqline(height, col="red", lwd=2)

![plot of chunk unnamed-chunk-15](figure/unnamed-chunk-15.png) 


Empirical cumulative distribution function
-------------------------


    vec <- round(rnorm(10), 1)
    Fn  <- ecdf(vec)
    plot(Fn, main="Empirische kumulierte Haeufigkeitsverteilung", cex.lab=1.4)
    curve(pnorm, add=TRUE, col="gray", lwd=2)

![plot of chunk unnamed-chunk-16](figure/unnamed-chunk-16.png) 


Joint distribution of two variables in separate groups
-------------------------

### Simulate data


    N  <- 200
    P  <- 2
    x  <- rnorm(N, 100, 15)
    y  <- 0.5*x + rnorm(N, 0, 10)
    IV <- gl(P, N/P, labels=LETTERS[1:P])


### Identify group membership by plot symbol and color


    plot(x, y, pch=c(4, 16)[unclass(IV)], lwd=2, col=c("black", "blue")[unclass(IV)],
         main="Gemeinsame Verteilung getrennt nach Gruppen")
    legend(x="topleft", legend=c("Gruppe A", "Gruppe B"), pch=c(4, 16),
           col=c("black", "blue"))

![plot of chunk unnamed-chunk-18](figure/unnamed-chunk-18.png) 


### Add distribution ellipse


    library(car)
    dataEllipse(x, y, xlab="x", ylab="y", asp=1, levels=0.5, lwd=2, center.pch=16,
                col="blue", main="Gemeinsame Verteilung zweier Variablen")
    legend(x="bottomright", legend=c("Datenpunkte", "Zentroid", "Streuungsellipse"),
           pch=c(1, 16, NA), lty=c(NA, NA, 1), col=c("black", "blue", "blue"))

![plot of chunk unnamed-chunk-19](figure/unnamed-chunk-19.png) 


Joint distribution of two variables with many observations
-------------------------

### Using transparency


    N  <- 5000
    xx <- rnorm(N, 100, 15)
    yy <- 0.4*xx + rnorm(N, 0, 10)
    plot(xx, yy, pch=16, col=rgb(0, 0, 1, 0.3))

![plot of chunk unnamed-chunk-20](figure/unnamed-chunk-20.png) 


### Smooth scatter plot


    smoothScatter(xx, yy, bandwidth=4)

![plot of chunk unnamed-chunk-21](figure/unnamed-chunk-21.png) 


### Hexagonal 2-D binning


    library(hexbin)
    res <- hexbin(xx, yy, xbins=20)
    plot(res)

![plot of chunk unnamed-chunk-22](figure/unnamed-chunk-22.png) 

    summary(res)

    Length  Class   Mode 
         1 hexbin     S4 


Detach (automatically) loaded packages (if possible)
-------------------------


    try(detach(package:car))
    try(detach(package:nnet))
    try(detach(package:MASS))
    try(detach(package:hexbin))
    try(detach(package:grid))
    try(detach(package:lattice))


Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/diagDistributions.Rmd) | [markdown](https://github.com/dwoll/RExRepos/raw/master/md/diagDistributions.md) | [R code](https://github.com/dwoll/RExRepos/raw/master/R/diagDistributions.R) - ([all posts](https://github.com/dwoll/RExRepos))
