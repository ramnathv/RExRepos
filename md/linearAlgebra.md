Linear algebra calculations
=========================

Install required packages
-------------------------

[`expm`](http://cran.r-project.org/package=expm), [`mvtnorm`](http://cran.r-project.org/package=mvtnorm), [`pracma`](http://cran.r-project.org/package=pracma)


{% highlight r %}
wants <- c("expm", "mvtnorm", "pracma")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])
{% endhighlight %}


Matrix algebra
-------------------------

### Transpose


{% highlight r %}
N  <- 4
Q  <- 2
(X <- matrix(c(20, 26, 10, 19, 29, 27, 20, 12), nrow=N, ncol=Q))
{% endhighlight %}



{% highlight text %}
     [,1] [,2]
[1,]   20   29
[2,]   26   27
[3,]   10   20
[4,]   19   12
{% endhighlight %}



{% highlight r %}
t(X)
{% endhighlight %}



{% highlight text %}
     [,1] [,2] [,3] [,4]
[1,]   20   26   10   19
[2,]   29   27   20   12
{% endhighlight %}


### Extracting the diagnoal and creating a diagonal matrix


{% highlight r %}
diag(cov(X))
{% endhighlight %}



{% highlight text %}
[1] 43.58 59.33
{% endhighlight %}



{% highlight r %}
diag(1:3)
{% endhighlight %}



{% highlight text %}
     [,1] [,2] [,3]
[1,]    1    0    0
[2,]    0    2    0
[3,]    0    0    3
{% endhighlight %}



{% highlight r %}
diag(2)
{% endhighlight %}



{% highlight text %}
     [,1] [,2]
[1,]    1    0
[2,]    0    1
{% endhighlight %}


### Multiplication


{% highlight r %}
(Xc <- diag(N) - matrix(rep(1/N, N^2), nrow=N))
{% endhighlight %}



{% highlight text %}
      [,1]  [,2]  [,3]  [,4]
[1,]  0.75 -0.25 -0.25 -0.25
[2,] -0.25  0.75 -0.25 -0.25
[3,] -0.25 -0.25  0.75 -0.25
[4,] -0.25 -0.25 -0.25  0.75
{% endhighlight %}



{% highlight r %}
(Xdot <- Xc %*% X)
{% endhighlight %}



{% highlight text %}
      [,1] [,2]
[1,]  1.25    7
[2,]  7.25    5
[3,] -8.75   -2
[4,]  0.25  -10
{% endhighlight %}



{% highlight r %}
(SSP <- t(Xdot) %*% Xdot)
{% endhighlight %}



{% highlight text %}
      [,1] [,2]
[1,] 130.8   60
[2,]  60.0  178
{% endhighlight %}



{% highlight r %}
crossprod(Xdot)
{% endhighlight %}



{% highlight text %}
      [,1] [,2]
[1,] 130.8   60
[2,]  60.0  178
{% endhighlight %}



{% highlight r %}
(1/(N-1)) * SSP
{% endhighlight %}



{% highlight text %}
      [,1]  [,2]
[1,] 43.58 20.00
[2,] 20.00 59.33
{% endhighlight %}



{% highlight r %}
(S <- cov(X))
{% endhighlight %}



{% highlight text %}
      [,1]  [,2]
[1,] 43.58 20.00
[2,] 20.00 59.33
{% endhighlight %}



{% highlight r %}
Ds <- diag(1/sqrt(diag(S)))
Ds %*% S %*% Ds
{% endhighlight %}



{% highlight text %}
       [,1]   [,2]
[1,] 1.0000 0.3933
[2,] 0.3933 1.0000
{% endhighlight %}



{% highlight r %}
cov2cor(S)
{% endhighlight %}



{% highlight text %}
       [,1]   [,2]
[1,] 1.0000 0.3933
[2,] 0.3933 1.0000
{% endhighlight %}



{% highlight r %}
b <- 2
a <- c(-2, 1)
sweep(b*X, 2, a, "+")
{% endhighlight %}



{% highlight text %}
     [,1] [,2]
[1,]   38   59
[2,]   50   55
[3,]   18   41
[4,]   36   25
{% endhighlight %}



{% highlight r %}
colLens <- sqrt(colSums(X^2))
sweep(X, 2, colLens, "/")
{% endhighlight %}



{% highlight text %}
       [,1]   [,2]
[1,] 0.5101 0.6307
[2,] 0.6632 0.5872
[3,] 0.2551 0.4350
[4,] 0.4846 0.2610
{% endhighlight %}



{% highlight r %}
X %*% diag(1/colLens)
{% endhighlight %}



{% highlight text %}
       [,1]   [,2]
[1,] 0.5101 0.6307
[2,] 0.6632 0.5872
[3,] 0.2551 0.4350
[4,] 0.4846 0.2610
{% endhighlight %}


### Power


{% highlight r %}
B <- cbind(c(1,1,1), c(0,2,0), c(0,0,2))
B %*% B %*% B
{% endhighlight %}



{% highlight text %}
     [,1] [,2] [,3]
[1,]    1    0    0
[2,]    7    8    0
[3,]    7    0    8
{% endhighlight %}



{% highlight r %}
library(expm)
B %^% 3
{% endhighlight %}



{% highlight text %}
     [,1] [,2] [,3]
[1,]    1    0    0
[2,]    7    8    0
[3,]    7    0    8
{% endhighlight %}


### Cross product


{% highlight r %}
a <- c(1, 2, 3)
b <- c(4, 5, 6)
library(pracma)
cross(a, b)
{% endhighlight %}



{% highlight text %}
[1] -3  6 -3
{% endhighlight %}


Solving linear equations and calculating the inverse
-------------------------

### Inverse


{% highlight r %}
Y     <- matrix(c(1, 1, 1, -1), nrow=2)
(Yinv <- solve(Y))
{% endhighlight %}



{% highlight text %}
     [,1] [,2]
[1,]  0.5  0.5
[2,]  0.5 -0.5
{% endhighlight %}



{% highlight r %}
Y %*% Yinv
{% endhighlight %}



{% highlight text %}
     [,1] [,2]
[1,]    1    0
[2,]    0    1
{% endhighlight %}


### Moore-Penrose generalized inverse


{% highlight r %}
library(MASS)
gInv <- ginv(X)
zapsmall(gInv %*% X)
{% endhighlight %}



{% highlight text %}
     [,1] [,2]
[1,]    1    0
[2,]    0    1
{% endhighlight %}


### Solving linear equations


{% highlight r %}
A  <- matrix(c(9, 1, -5, 0), nrow=2)
b  <- c(5, -3)
(x <- solve(A, b))
{% endhighlight %}



{% highlight text %}
[1] -3.0 -6.4
{% endhighlight %}



{% highlight r %}
A %*% x
{% endhighlight %}



{% highlight text %}
     [,1]
[1,]    5
[2,]   -3
{% endhighlight %}


Norms and distances of matrices and vectors
-------------------------

### Norm


{% highlight r %}
a1 <- c(3, 4, 1, 8, 2)
sqrt(crossprod(a1))
{% endhighlight %}



{% highlight text %}
      [,1]
[1,] 9.695
{% endhighlight %}



{% highlight r %}
sqrt(sum(a1^2))
{% endhighlight %}



{% highlight text %}
[1] 9.695
{% endhighlight %}



{% highlight r %}
a2 <- c(6, 9, 10, 8, 7)
A  <- cbind(a1, a2)
sqrt(diag(crossprod(A)))
{% endhighlight %}



{% highlight text %}
    a1     a2 
 9.695 18.166 
{% endhighlight %}



{% highlight r %}
sqrt(colSums(A^2))
{% endhighlight %}



{% highlight text %}
    a1     a2 
 9.695 18.166 
{% endhighlight %}



{% highlight r %}
norm(A, type="F")
{% endhighlight %}



{% highlight text %}
[1] 20.59
{% endhighlight %}



{% highlight r %}
sqrt(crossprod(c(A)))
{% endhighlight %}



{% highlight text %}
      [,1]
[1,] 20.59
{% endhighlight %}


### Distance

Length of difference vector


{% highlight r %}
set.seed(1.234)
B <- matrix(sample(-20:20, 12, replace=TRUE), ncol=3)
sqrt(crossprod(B[1, ] - B[2, ]))
{% endhighlight %}



{% highlight text %}
      [,1]
[1,] 36.58
{% endhighlight %}



{% highlight r %}
dist(B, diag=TRUE, upper=TRUE)
{% endhighlight %}



{% highlight text %}
      1     2     3     4
1  0.00 36.58 36.85 37.60
2 36.58  0.00 10.20 24.29
3 36.85 10.20  0.00 17.83
4 37.60 24.29 17.83  0.00
{% endhighlight %}


### Mahalanobis-transformation


{% highlight r %}
library(mvtnorm)
N     <- 100
mu    <- c(-3, 2, 4)
sigma <- matrix(c(4,2,-3, 2,16,-1, -3,-1,9), byrow=TRUE, ncol=3)
Y     <- round(rmvnorm(N, mean=mu, sigma=sigma))
{% endhighlight %}



{% highlight r %}
ctr   <- colMeans(Y)
S     <- cov(Y)
Seig  <- eigen(S)
sqrtD <- sqrt(Seig$values)
SsqrtInv <- Seig$vectors %*% diag(1/sqrtD) %*% t(Seig$vectors)

Xdot  <- sweep(Y, 2, ctr, "-")
Xmt   <- t(SsqrtInv %*% t(Xdot))
zapsmall(cov(Xmt))
{% endhighlight %}



{% highlight text %}
     [,1] [,2] [,3]
[1,]    1    0    0
[2,]    0    1    0
[3,]    0    0    1
{% endhighlight %}



{% highlight r %}
colMeans(Xmt)
{% endhighlight %}



{% highlight text %}
[1] -5.919e-17  6.649e-17  1.240e-16
{% endhighlight %}


### Mahalanobis-distance


{% highlight r %}
ideal <- c(1, 2, 3)
y1    <- Y[1, ]
y2    <- Y[2, ]
mat   <- rbind(y1, y2)
{% endhighlight %}



{% highlight r %}
mahalanobis(mat, ideal, S)
{% endhighlight %}



{% highlight text %}
   y1    y2 
4.585 5.254 
{% endhighlight %}



{% highlight r %}
Sinv <- solve(S)
t(y1-ideal) %*% Sinv %*% (y1-ideal)
{% endhighlight %}



{% highlight text %}
      [,1]
[1,] 4.585
{% endhighlight %}



{% highlight r %}
t(y2-ideal) %*% Sinv %*% (y2-ideal)
{% endhighlight %}



{% highlight text %}
      [,1]
[1,] 5.254
{% endhighlight %}



{% highlight r %}
mDist <- mahalanobis(Y, ideal, S)
min(mDist)
{% endhighlight %}



{% highlight text %}
[1] 0.4883
{% endhighlight %}



{% highlight r %}
(idxMin <- which.min(mDist))
{% endhighlight %}



{% highlight text %}
[1] 5
{% endhighlight %}



{% highlight r %}
Y[idxMin, ]
{% endhighlight %}



{% highlight text %}
[1] 0 0 3
{% endhighlight %}



{% highlight r %}
idealM <- t(SsqrtInv %*% (ideal - ctr))
crossprod(Xmt[1, ] - t(idealM))
{% endhighlight %}



{% highlight text %}
      [,1]
[1,] 4.585
{% endhighlight %}



{% highlight r %}
crossprod(Xmt[2, ] - t(idealM))
{% endhighlight %}



{% highlight text %}
      [,1]
[1,] 5.254
{% endhighlight %}


Trace, determinant, rank, null space, condition index
-------------------------

### Trace


{% highlight r %}
(A <- matrix(c(9, 1, 1, 4), nrow=2))
{% endhighlight %}



{% highlight text %}
     [,1] [,2]
[1,]    9    1
[2,]    1    4
{% endhighlight %}



{% highlight r %}
sum(diag(A))
{% endhighlight %}



{% highlight text %}
[1] 13
{% endhighlight %}



{% highlight r %}
sum(diag(t(A) %*% A))
{% endhighlight %}



{% highlight text %}
[1] 99
{% endhighlight %}



{% highlight r %}
sum(diag(A %*% t(A)))
{% endhighlight %}



{% highlight text %}
[1] 99
{% endhighlight %}



{% highlight r %}
sum(A^2)
{% endhighlight %}



{% highlight text %}
[1] 99
{% endhighlight %}


### Determinant


{% highlight r %}
det(A)
{% endhighlight %}



{% highlight text %}
[1] 35
{% endhighlight %}



{% highlight r %}
B <- matrix(c(-3, 4, -1, 7), nrow=2)
all.equal(det(A %*% B), det(A) * det(B))
{% endhighlight %}



{% highlight text %}
[1] TRUE
{% endhighlight %}



{% highlight r %}
det(diag(1:4))
{% endhighlight %}



{% highlight text %}
[1] 24
{% endhighlight %}



{% highlight r %}
Ainv <- solve(A)
all.equal(1/det(A), det(Ainv))
{% endhighlight %}



{% highlight text %}
[1] TRUE
{% endhighlight %}


### Rank


{% highlight r %}
qrA <- qr(A)
qrA$rank
{% endhighlight %}



{% highlight text %}
[1] 2
{% endhighlight %}



{% highlight r %}
(eigA <- eigen(A))
{% endhighlight %}



{% highlight text %}
$values
[1] 9.193 3.807

$vectors
        [,1]    [,2]
[1,] -0.9820  0.1891
[2,] -0.1891 -0.9820

{% endhighlight %}



{% highlight r %}
zapsmall(eigA$vectors %*% t(eigA$vectors))
{% endhighlight %}



{% highlight text %}
     [,1] [,2]
[1,]    1    0
[2,]    0    1
{% endhighlight %}



{% highlight r %}
sum(eigA$values)
{% endhighlight %}



{% highlight text %}
[1] 13
{% endhighlight %}



{% highlight r %}
prod(eigA$values)
{% endhighlight %}



{% highlight text %}
[1] 35
{% endhighlight %}


### Null space (kernel)


{% highlight r %}
library(MASS)
Xnull <- Null(X)
t(X) %*% Xnull
{% endhighlight %}



{% highlight text %}
          [,1] [,2]
[1,] 6.661e-15    0
[2,] 5.773e-15    0
{% endhighlight %}


### Condition index


{% highlight r %}
X <- matrix(c(20, 26, 10, 19, 29, 27, 20, 12, 17, 23, 27, 25), nrow=4)
kappa(X, exact=TRUE)
{% endhighlight %}



{% highlight text %}
[1] 7.932
{% endhighlight %}



{% highlight r %}
Xplus <- solve(t(X) %*% X) %*% t(X)
base::norm(X, type="2") * base::norm(Xplus, type="2")
{% endhighlight %}



{% highlight text %}
[1] 7.932
{% endhighlight %}



{% highlight r %}
evX <- eigen(t(X) %*% X)$values
sqrt(max(evX) / min(evX[evX >= .Machine$double.eps]))
{% endhighlight %}



{% highlight text %}
[1] 7.932
{% endhighlight %}



{% highlight r %}
sqrt(evX / min(evX[evX >= .Machine$double.eps]))
{% endhighlight %}



{% highlight text %}
[1] 7.932 1.503 1.000
{% endhighlight %}


Matrix decompositions
-------------------------

### Eigenvalues and eigenvectors


{% highlight r %}
X  <- matrix(c(20, 26, 10, 19, 29, 27, 20, 12, 17, 23, 27, 25), nrow=4)
(S <- cov(X))
{% endhighlight %}



{% highlight text %}
       [,1]   [,2]   [,3]
[1,]  43.58  20.00 -14.00
[2,]  20.00  59.33 -23.33
[3,] -14.00 -23.33  18.67
{% endhighlight %}



{% highlight r %}
eigS <- eigen(S)
G    <- eigS$vectors
D    <- diag(eigS$values)
G %*% D %*% t(G)
{% endhighlight %}



{% highlight text %}
       [,1]   [,2]   [,3]
[1,]  43.58  20.00 -14.00
[2,]  20.00  59.33 -23.33
[3,] -14.00 -23.33  18.67
{% endhighlight %}


### Singular value decomposition


{% highlight r %}
svdX <- svd(X)
all.equal(X, svdX$u %*% diag(svdX$d) %*% t(svdX$v))
{% endhighlight %}



{% highlight text %}
[1] TRUE
{% endhighlight %}



{% highlight r %}
all.equal(sqrt(eigen(t(X) %*% X)$values), svdX$d)
{% endhighlight %}



{% highlight text %}
[1] TRUE
{% endhighlight %}


### Cholesky decomposition


{% highlight r %}
R <- chol(S)
all.equal(S, t(R) %*% R)
{% endhighlight %}



{% highlight text %}
[1] TRUE
{% endhighlight %}


### \(QR\)-decomposition


{% highlight r %}
qrX <- qr(X)
Q   <- qr.Q(qrX)
R   <- qr.R(qrX)
all.equal(X, Q %*% R)
{% endhighlight %}



{% highlight text %}
[1] TRUE
{% endhighlight %}


### Square-root


{% highlight r %}
library(expm)
sqrtm(S)
{% endhighlight %}



{% highlight text %}
$B
       [,1]   [,2]   [,3]
[1,]  6.373  1.294 -1.139
[2,]  1.294  7.328 -1.989
[3,] -1.139 -1.989  3.663

$Binv
        [,1]     [,2]    [,3]
[1,]  0.1682 -0.01820 0.04240
[2,] -0.0182  0.16202 0.08232
[3,]  0.0424  0.08232 0.33091

$k
[1] 7

$acc
[1] 2.314e-10

{% endhighlight %}



{% highlight r %}
sqrtD <- diag(sqrt(eigS$values))
(A <- G %*% sqrtD %*% t(G))
{% endhighlight %}



{% highlight text %}
       [,1]   [,2]   [,3]
[1,]  6.373  1.294 -1.139
[2,]  1.294  7.328 -1.989
[3,] -1.139 -1.989  3.663
{% endhighlight %}



{% highlight r %}
A %*% A
{% endhighlight %}



{% highlight text %}
       [,1]   [,2]   [,3]
[1,]  43.58  20.00 -14.00
[2,]  20.00  59.33 -23.33
[3,] -14.00 -23.33  18.67
{% endhighlight %}


### \(X = N N^{t}\)


{% highlight r %}
N <- eigS$vectors %*% sqrt(diag(eigS$values))
N %*% t(N)
{% endhighlight %}



{% highlight text %}
       [,1]   [,2]   [,3]
[1,]  43.58  20.00 -14.00
[2,]  20.00  59.33 -23.33
[3,] -14.00 -23.33  18.67
{% endhighlight %}


Orthogonal projections
-------------------------

### Direct implementation of \((X^{t} X)^{-1} X^{t}\)


{% highlight r %}
X    <- matrix(c(20, 26, 10, 19, 29, 27, 20, 12, 17, 23, 27, 25), nrow=4)
ones <- rep(1, nrow(X))
P1   <- ones %*% solve(t(ones) %*% ones) %*% t(ones)
P1x  <- P1 %*% X
head(P1x)
{% endhighlight %}



{% highlight text %}
      [,1] [,2] [,3]
[1,] 18.75   22   23
[2,] 18.75   22   23
[3,] 18.75   22   23
[4,] 18.75   22   23
{% endhighlight %}



{% highlight r %}
a  <- ones / sqrt(crossprod(ones))
P2 <- a %*% t(a)
all.equal(P1, P2)
{% endhighlight %}



{% highlight text %}
[1] TRUE
{% endhighlight %}



{% highlight r %}
IP1  <- diag(nrow(X)) - P1
IP1x <- IP1 %*% X
all.equal(IP1x, sweep(X, 2, colMeans(X), "-"))
{% endhighlight %}



{% highlight text %}
[1] TRUE
{% endhighlight %}



{% highlight r %}
A   <- cbind(c(1, 0, 0), c(0, 1, 0))
P3  <- A %*% solve(t(A) %*% A) %*% t(A)
Px3 <- t(P3 %*% t(X))
Px3[1:3, ]
{% endhighlight %}



{% highlight text %}
     [,1] [,2] [,3]
[1,]   20   29    0
[2,]   26   27    0
[3,]   10   20    0
{% endhighlight %}


### Numerically stable implementation using the \(QR\)-decomposition


{% highlight r %}
qrX   <- qr(X)
Q     <- qr.Q(qrX)
R     <- qr.R(qrX)
Xplus <- solve(t(X) %*% X) %*% t(X)
all.equal(Xplus, solve(R) %*% t(Q))
{% endhighlight %}



{% highlight text %}
[1] TRUE
{% endhighlight %}



{% highlight r %}
all.equal(X %*% Xplus, tcrossprod(Q))
{% endhighlight %}



{% highlight text %}
[1] TRUE
{% endhighlight %}


Detach (automatically) loaded packages (if possible)
-------------------------


{% highlight r %}
try(detach(package:MASS))
try(detach(package:expm))
try(detach(package:Matrix))
try(detach(package:lattice))
try(detach(package:pracma))
try(detach(package:mvtnorm))
{% endhighlight %}


Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/linearAlgebra.Rmd) - [markdown](https://github.com/dwoll/RExRepos/raw/master/md/linearAlgebra.md) - [R code](https://github.com/dwoll/RExRepos/raw/master/R/linearAlgebra.R) - [all posts](https://github.com/dwoll/RExRepos)
