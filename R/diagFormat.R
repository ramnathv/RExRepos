
## @knitr unnamed-chunk-1
opts_knit$set(self.contained=FALSE)
opts_chunk$set(tidy=FALSE, message=FALSE, warning=FALSE, comment="")


## @knitr unnamed-chunk-2
wants <- c("RColorBrewer")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])


## @knitr unnamed-chunk-3
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


## @knitr unnamed-chunk-4
set.seed(1.234)
opv <- par(mfrow=c(1, 2), cex.main=0.9)
op  <- par(col="gray60", lwd=2, pch=16)
plot(rnorm(10), main="Grau, fett, gefuellte Kreise")
par(op)
plot(rnorm(10), main="Standardformatierung")
par(opv)


## @knitr unnamed-chunk-5
palette("default")
rgb(0, 1, 1)
rgb(t(col2rgb("red")/255))
hsv(0.1666, 1, 1)
gray(0.5)


## @knitr unnamed-chunk-6
library(RColorBrewer)
colorRampPalette(brewer.pal(9, "Blues"))(100)


## @knitr unnamed-chunk-7
try(detach(package:RColorBrewer))


