
## @knitr unnamed-chunk-1
opts_knit$set(self.contained=FALSE)
opts_chunk$set(tidy=FALSE, message=FALSE, warning=FALSE, comment="")


## @knitr unnamed-chunk-2
wants <- c("car")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])


## @knitr unnamed-chunk-3
tfVec <- c(TRUE, FALSE, FALSE, TRUE)
as.numeric(tfVec)
as.complex(tfVec)
as.character(tfVec)


## @knitr unnamed-chunk-4
as.logical(c(-1, 0, 1, 2))
as.numeric(as.complex(c(3-2i, 3+2i, 0+1i, 0+0i)))
as.numeric(c("21", "3.141", "abc"))


## @knitr unnamed-chunk-5
vec <- c(10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20)
rev(vec)
vec <- c(10, 12, 1, 12, 7, 16, 6, 19, 10, 19)
sort(vec)
(idxDec <- order(vec, decreasing=TRUE))
vec[idxDec]
sort(c("D", "E", "10", "A", "F", "E", "D", "4", "E", "A"))


## @knitr unnamed-chunk-6
set.seed(1.234)
myColors  <- c("red", "green", "blue", "yellow", "black")
(randCols <- sample(myColors, length(myColors), replace=FALSE))


## @knitr unnamed-chunk-7
P   <- 3
Nj  <- c(4, 3, 5)
(IV <- rep(1:P, Nj))
(IVrand <- sample(IV, length(IV), replace=FALSE))


## @knitr unnamed-chunk-8
x <- c(18, 11, 15, 20, 19, 10, 14, 13, 10, 10)
N <- length(x)
P <- 3
(sample(1:N, N, replace=FALSE) %% P) + 1


## @knitr unnamed-chunk-9
vec <- rep(c("red", "green", "blue"), 10)
sample(vec, 5, replace=FALSE)


## @knitr unnamed-chunk-10
library(car)
some(vec, n=5)


## @knitr unnamed-chunk-11
selIdx1 <- seq(1, length(vec), by=10)
vec[selIdx1]


## @knitr unnamed-chunk-12
selIdx2 <- rbinom(length(vec), size=1, prob=0.1) == 1
vec[selIdx2]


## @knitr unnamed-chunk-13
age <- c(18, 20, 30, 24, 23, 21)
age/10
(age/2) + 5
vec1 <- c(3, 4, 5, 6)
vec2 <- c(-2, 2, -2, 2)
vec1*vec2
vec3 <- c(10, 100, 1000, 10000)
(vec1 + vec2) / vec3


## @knitr unnamed-chunk-14
vec1 <- c(2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24)
vec2 <- c(2, 4, 6, 8, 10)
c(length(age), length(vec1), length(vec2))
vec1*age
vec2*age


## @knitr unnamed-chunk-15
(zAge <- (age - mean(age)) / sd(age))
(zAge <- scale(age))
as.vector(zAge)


## @knitr unnamed-chunk-16
newSd   <- 15
newMean <- 100
(newAge <- (as.vector(zAge)*newSd) + newMean)
mean(newAge)
sd(newAge)


## @knitr unnamed-chunk-17
rank(c(3, 1, 2, 3))


## @knitr unnamed-chunk-18
height <- c(1.78, 1.91, 1.89, 1.83, 1.64)
weight <- c(65, 89, 91, 75, 73)
(bmi   <- weight / (height^2))


## @knitr unnamed-chunk-19
quest1  <- c(FALSE, FALSE, FALSE, TRUE,  FALSE, TRUE, FALSE, TRUE)
quest2  <- c(TRUE,  FALSE, FALSE, FALSE, TRUE,  TRUE, TRUE,  FALSE)
quest3  <- c(TRUE,  TRUE,  TRUE,  TRUE,  FALSE, TRUE, FALSE, FALSE)
(sumVar <- quest1 + quest2 + quest3)


## @knitr unnamed-chunk-20
try(detach(package:car))
try(detach(package:nnet))
try(detach(package:MASS))


