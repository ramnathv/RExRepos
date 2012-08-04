Multiple diagrams per window or device
=========================




Using `layout()`
-------------------------

### Four equally sized cells
    

    (mat1 <- matrix(1:4, 2, 2))

         [,1] [,2]
    [1,]    1    3
    [2,]    2    4

    layout(mat1)
    par(lwd=3, cex=2)
    layout.show(4)

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2.png) 



    set.seed(1.234)
    layout(mat1)
    barplot(table(round(rnorm(100))), horiz=TRUE, main="Balkendiagramm")
    boxplot(rt(100, 5), main="Boxplot")
    stripchart(sample(1:20, 40, replace=TRUE), method="stack", main="Stripchart")
    pie(table(sample(1:6, 20, replace=TRUE)), main="Kreisdiagramm")

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3.png) 


### Four cells of different size


    layout(mat1, widths=c(1, 2), heights=c(1, 2))
    par(lwd=3, cex=2)
    layout.show(4)

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4.png) 



    layout(mat1, widths=c(1, 2), heights=c(1, 2))
    barplot(table(round(rnorm(100))), horiz=TRUE, main="Balkendiagramm")
    boxplot(rt(100, 5), main="Boxplot")
    stripchart(sample(1:20, 40, replace=TRUE), method="stack", main="Stripchart")
    pie(table(sample(1:6, 20, replace=TRUE)), main="Kreisdiagramm")

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5.png) 


### Combining and omitting cells


    (mat2 <- matrix(c(1, 0, 1, 2), 2, 2))

         [,1] [,2]
    [1,]    1    1
    [2,]    0    2

    layout(mat2)
    stripchart(sample(1:20, 40, replace=TRUE), method="stack", main="Stripchart")
    barplot(table(round(rnorm(100))), main="Saeulendiagramm")

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-6.png) 


Using `par(mfrow, mfcol)`
-------------------------


    par(mfrow=c(1, 2))
    boxplot(rt(100, 5), xlab=NA, notch=TRUE, main="Boxplot")
    plot(rnorm(10), pch=16, xlab=NA, ylab=NA, main="Streudiagramm")

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-7.png) 


Using `par(fig)`
-------------------------


    resBinom <- rbinom(1000, size=10, prob=0.3)
    facBinom <- factor(resBinom, levels=0:10)
    tabBinom <- table(facBinom)

    par(fig=c(0, 1, 0.10, 1), cex.lab=1.4)
    plot(tabBinom, type="h", bty="n", xaxt="n", xlim=c(0, 10),
         xlab=NA, ylab="Haeufigkeit",
         main="Ergebnisse von 1000*10 Bernoulli Experimenten (p=0.3)")
    points(names(tabBinom), tabBinom, pch=16, col="red", cex=2)
    
    par(fig=c(0, 1, 0, 0.35), bty="n", new=TRUE)
    boxplot(resBinom, horizontal=TRUE, ylim=c(0, 10), notch=TRUE, col="blue",
            xlab="Anzahl der Erfolge")

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-9.png) 


Using `split.screen()`
-------------------------


    splitMat <- rbind(c(0,    0.5,  0,    0.5),
                      c(0.15, 0.85, 0.15, 0.85),
                      c(0.5,  1,    0.5,  1))
    split.screen(splitMat)

    [1] 1 2 3

    screen(1)
    barplot(table(round(rnorm(100))), main="Saeulendiagramm")
    screen(2)
    boxplot(sample(1:20, 100, replace=TRUE) ~ gl(4, 25, labels=LETTERS[1:4]),
            col=rainbow(4), notch=TRUE, main="Boxplot")
    screen(3)
    plot(sample(1:20, 40, replace=TRUE), pch=20, xlab=NA, ylab=NA,
         main="Streudiagramm")

![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-10.png) 

    close.screen(all.screens=TRUE)


Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/diagMultiple.Rmd) | [markdown](https://github.com/dwoll/RExRepos/raw/master/md/diagMultiple.md) | [R code](https://github.com/dwoll/RExRepos/raw/master/R/diagMultiple.R) - ([all posts](https://github.com/dwoll/RExRepos))
