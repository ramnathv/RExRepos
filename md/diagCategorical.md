Diagrams for categorical data
=========================




Install required packages
-------------------------

[`plotrix`](http://cran.r-project.org/package=plotrix)


    wants <- c("plotrix")
    has   <- wants %in% rownames(installed.packages())
    if(any(!has)) install.packages(wants[!has])


Barplots
-------------------------

### Simulate data
    

    set.seed(1.234)
    dice  <- sample(1:6, 100, replace=TRUE)
    (dTab <- table(dice))

    dice
     1  2  3  4  5  6 
    11 16 25 13 21 14 


###  Simple barplot


    barplot(dTab, ylim=c(0, 30), xlab="Augenzahl", ylab="N", col="black",
            main="Absolute Haeufigkeiten")

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4.png) 



    barplot(prop.table(dTab), ylim=c(0, 0.3), xlab="Augenzahl",
            ylab="relative Haeufigkeit", col="gray50", main="Relative Haeufigkeiten")


### Barplots for contingency tables of two variables
#### Stacked barplot


    roll1   <- dice[1:50]
    roll2   <- dice[51:100]
    rollAll <- rbind(table(roll1), table(roll2))
    rownames(rollAll) <- c("first", "second"); rollAll

           1 2  3 4  5 6
    first  5 7 11 8 13 6
    second 6 9 14 5  8 8

    
    barplot(rollAll, beside=FALSE, legend.text=TRUE, xlab="Augenzahl", ylab="N",
            main="Absolute Haeufigkeiten in zwei Substichproben")

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-6.png) 


#### Grouped barplot


    barplot(rollAll, beside=TRUE, ylim=c(0, 15), col=c("red", "green"),
            legend.text=TRUE, xlab="Augenzahl", ylab="N",
            main="Absolute Haeufigkeiten in zwei Substichproben")

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-7.png) 


Spineplot
-------------------------


    N      <- 100
    age    <- sample(18:45, N, replace=TRUE)
    drinks <- c("beer", "red wine", "white wine")
    pref   <- factor(sample(drinks, N, replace=TRUE))
    xRange <- round(range(age), -1) + c(-10, 10)
    lims   <- c(18, 25, 35, 45)
    spineplot(x=age, y=pref, xlab="Altersstufe", ylab="Getraenk", breaks=lims,
              main="Bevorzugte Getraenke pro Altersstufe")

![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-8.png) 


Mosaic-plot
-------------------------


    ageCls <- cut(age, breaks=lims, labels=LETTERS[1:(length(lims)-1)])
    group  <- factor(sample(letters[1:2], N, replace=TRUE))
    cTab   <- table(ageCls, pref, group)
    mosaicplot(cTab, cex.axis=1)

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-9.png) 


Pie-charts
-------------------------

### 2-D pie-chart


    dice <- sample(1:6, 100, replace=TRUE)
    dTab <- table(dice)
    pie(dTab, col=c("blue", "red", "yellow", "pink", "green", "orange"),
        main="Relative Haeufigkeiten beim Wuerfeln")
    
    dTabFreq <- prop.table(dTab)
    textRad  <- 0.5
    angles   <- dTabFreq * 2 * pi
    csAngles <- cumsum(angles)
    csAngles <- csAngles - angles/2
    textX    <- textRad * cos(csAngles)
    textY    <- textRad * sin(csAngles)
    text(x=textX, y=textY, labels=dTabFreq)

![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-10.png) 


### 3-D pie-chart


    library(plotrix)
    pie3D(dTab, theta=pi/4, explode=0.1, labels=names(dTab))

![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-11.png) 


Conditional density plot
-------------------------


    N    <- 100
    X    <- rnorm(N, 175, 7)
    Y    <- 0.5*X + rnorm(N, 0, 6)
    Yfac <- cut(Y, breaks=c(-Inf, median(Y), Inf), labels=c("lo", "hi"))
    myDf <- data.frame(X, Yfac)



    cdplot(Yfac ~ X, data=myDf)

![plot of chunk unnamed-chunk-13](figure/unnamed-chunk-13.png) 


Useful packages
-------------------------

More plot types for categorical data are available in packages [`vcd`](http://cran.r-project.org/package=vcd) and [`vcdExtra`](http://cran.r-project.org/package=vcdExtra).

Detach (automatically) loaded packages (if possible)
-------------------------


    try(detach(package:plotrix))


Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/diagCategorical.Rmd) | [markdown](https://github.com/dwoll/RExRepos/raw/master/md/diagCategorical.md) | [R code](https://github.com/dwoll/RExRepos/raw/master/R/diagCategorical.R) - ([all posts](https://github.com/dwoll/RExRepos))
