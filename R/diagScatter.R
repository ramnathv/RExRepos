
## @knitr unnamed-chunk-1
opts_knit$set(self.contained=FALSE)
opts_chunk$set(tidy=FALSE, message=FALSE, warning=FALSE, comment="")


## @knitr unnamed-chunk-2
set.seed(1.234)
N <- 100
x <- rnorm(N, 100, 15)
y <- 0.3*x + rnorm(N, 0, 5)
plot(x, y)


## @knitr unnamed-chunk-3
plot(x, y, main="Customized scatter plot", xlim=c(50, 150), ylim=c(10, 50),
     xlab="x axis", ylab="y axis", pch=16, col="darkgray")


## @knitr unnamed-chunk-4
plot(y, main="Univeriate scatter plot", ylim=c(10, 50),
     xlab="Index", ylab="y axis", pch=4, lwd=2, col="blue")


## @knitr unnamed-chunk-5
xy <- cbind(x, y)
plot(xy)
plot(y ~ x)


## @knitr unnamed-chunk-6
z <- sample(0:5, N, replace=TRUE)
plot(z ~ x, pch=1, col="red", cex=1.5, main="Punktwolke")
plot(jitter(z) ~ x, pch=1, col="red", cex=1.5, main="Punktwolke mit jitter")


## @knitr unnamed-chunk-7
vec <- rnorm(10)
plot(vec, type="p", xlab=NA, main="type p", cex=1.5)
plot(vec, type="l", xlab=NA, main="type l", cex=1.5)
plot(vec, type="b", xlab=NA, main="type b", cex=1.5)
plot(vec, type="o", xlab=NA, main="type o", cex=1.5)
plot(vec, type="s", xlab=NA, main="type s", cex=1.5)
plot(vec, type="h", xlab=NA, main="type h", cex=1.5)


## @knitr unnamed-chunk-8
vec <- seq(from=-2*pi, to=2*pi, length.out=50)
mat <- cbind(2*sin(vec), sin(vec-(pi/4)), 0.5*sin(vec-(pi/2)))
matplot(vec, mat, type="b", xlab=NA, ylab=NA, pch=1:3, main="Sinuskurven")


## @knitr unnamed-chunk-9
plot(vec)
identify(vec)


