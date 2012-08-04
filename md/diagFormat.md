Customize diagrams: Formatting
=========================




TODO
-------------------------

 - link to diagAddElements -> `axis()`, diagMultiple
 - `RColorBrewer`
 - show colors
 - common set of options, example: `plot()`
 - xlab, ylab, xlim, ylim, main, sub, asp, log, axes, type="n"
 - only in `par()`: bt, mar, oma, xlog, ylog
 - `par()` and `plot()`: cex, cex.axis, cex.main, cex.lab, col, font, family, las, lend, lty,
    lwd, pch, srt, xaxs, yaxs, xaxt, yaxt
 - fonts

Install required packages
-------------------------

[`RColorBrewer`](http://cran.r-project.org/package=RColorBrewer)


    wants <- c("RColorBrewer")
    has   <- wants %in% rownames(installed.packages())
    if(any(!has)) install.packages(wants[!has])


Plot symbols and line types
-------------------------

### Contour plots
    

    X <- matrix(rep(1:6, times=11), ncol=11)
    Y <- matrix(rep(1:11, each=6),  ncol=11)
    
    par(mar=c(1, 1, 4, 2))
    plot(0:6, seq(1, 11, length.out=7), type="n", xlab=NA, ylab=NA,
         axes=FALSE, main="pch Datenpunkt-Symbole und lty Linientypen")
    points(X[1:26], Y[1:26], pch=0:25, bg="gray", cex=2)
    matpoints(X[ , 6:11], Y[ , 6:11], type="l", lty=6:1, lwd=2, col="black")
    text(X[1:26]-0.3, Y[1:26],    labels=0:25)
    text(rep(0.7, 6), Y[1, 6:11], labels=6:1)
    text(0, 7.5, labels="Linientypen fuer lty", srt=90, cex=1.2)
    text(0, 2.0, labels="Symbole fuer pch",     srt=90, cex=1.2)

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3.png) 


Setting parameters with `par()`
-------------------------


    set.seed(1.234)
    opv <- par(mfrow=c(1, 2), cex.main=0.9)
    op  <- par(col="gray60", lwd=2, pch=16)
    plot(rnorm(10), main="Grau, fett, gefuellte Kreise")
    par(op)
    plot(rnorm(10), main="Standardformatierung")

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4.png) 

    par(opv)


Colors
-------------------------


    palette("default")
    rgb(0, 1, 1)

    [1] "#00FFFF"

    rgb(t(col2rgb("red")/255))

    [1] "#FF0000"

    hsv(0.1666, 1, 1)

    [1] "#FFFF00"

    gray(0.5)

    [1] "#808080"



    library(RColorBrewer)
    colorRampPalette(brewer.pal(9, "Blues"))(100)

      [1] "#F7FBFF" "#F4F9FE" "#F2F8FD" "#F0F7FD" "#EEF5FC" "#ECF4FB" "#EAF3FB"
      [8] "#E8F1FA" "#E6F0F9" "#E4EFF9" "#E2EEF8" "#E0ECF7" "#DEEBF7" "#DCEAF6"
     [15] "#DAE8F5" "#D8E7F5" "#D6E6F4" "#D5E5F4" "#D3E3F3" "#D1E2F2" "#CFE1F2"
     [22] "#CDDFF1" "#CBDEF0" "#C9DDF0" "#C7DBEF" "#C5DAEE" "#C1D9ED" "#BED7EC"
     [29] "#BBD6EB" "#B8D5EA" "#B5D3E9" "#B1D2E7" "#AED1E6" "#ABCFE5" "#A8CEE4"
     [36] "#A4CCE3" "#A1CBE2" "#9ECAE1" "#9AC8E0" "#96C5DF" "#92C3DE" "#8EC1DD"
     [43] "#89BEDC" "#85BCDB" "#81BADA" "#7DB8DA" "#79B5D9" "#75B3D8" "#71B1D7"
     [50] "#6DAFD6" "#69ACD5" "#66AAD4" "#62A8D2" "#5FA6D1" "#5CA3D0" "#58A1CE"
     [57] "#559FCD" "#529DCC" "#4E9ACB" "#4B98C9" "#4896C8" "#4493C7" "#4191C5"
     [64] "#3E8EC4" "#3C8CC3" "#3989C1" "#3686C0" "#3484BE" "#3181BD" "#2E7EBC"
     [71] "#2C7CBA" "#2979B9" "#2776B8" "#2474B6" "#2171B5" "#1F6FB3" "#1D6CB1"
     [78] "#1B69AF" "#1967AD" "#1764AB" "#1562A9" "#135FA7" "#115CA5" "#0F5AA3"
     [85] "#0D57A1" "#0B559F" "#09529D" "#084F9A" "#084D96" "#084A92" "#08478E"
     [92] "#08458A" "#084286" "#083F82" "#083D7E" "#083A7A" "#083776" "#083572"
     [99] "#08326E" "#08306B"


A very nice overview of R colors is the [R color chart](http://research.stowers-institute.org/efg/R/Color/Chart/).

Useful packages
-------------------------

Package [`colorspace`](http://cran.r-project.org/package=colorspace) provides more functions for converting between different color spaces.

Detach (automatically) loaded packages (if possible)
-------------------------


    try(detach(package:RColorBrewer))


Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/diagFormat.Rmd) | [markdown](https://github.com/dwoll/RExRepos/raw/master/md/diagFormat.md) | [R code](https://github.com/dwoll/RExRepos/raw/master/R/diagFormat.R) - ([all posts](https://github.com/dwoll/RExRepos))
