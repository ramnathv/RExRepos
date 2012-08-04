Exploratory factor analysis
=========================

TODO
-------------------------

 - link to multFApoly

Install required packages
-------------------------

[`mvtnorm`](http://cran.r-project.org/package=mvtnorm), [`psych`](http://cran.r-project.org/package=psych), [`GPArotation`](http://cran.r-project.org/package=GPArotation)


    wants <- c("mvtnorm", "psych", "GPArotation")
    has   <- wants %in% rownames(installed.packages())
    if(any(!has)) install.packages(wants[!has])


Factor analysis
-------------------------

For confirmatory factor analysis (CFA), see packages [`sem`](http://cran.r-project.org/package=sem), [`OpenMx`](http://openmx.psyc.virginia.edu/), and [`lavaan`](http://cran.r-project.org/package=lavaan) which implement structural equation models.

### Simulate data

True matrix of loadings


    N <- 200
    P <- 6
    Q <- 2
    (Lambda <- matrix(c(0.7,-0.4, 0.8,0, -0.2,0.9, -0.3,0.4, 0.3,0.7, -0.8,0.1),
                      nrow=P, ncol=Q, byrow=TRUE))

         [,1] [,2]
    [1,]  0.7 -0.4
    [2,]  0.8  0.0
    [3,] -0.2  0.9
    [4,] -0.3  0.4
    [5,]  0.3  0.7
    [6,] -0.8  0.1


Non correlated factors


    set.seed(1.234)
    library(mvtnorm)
    Kf <- diag(Q)
    mu <- c(5, 15)
    FF <- rmvnorm(N, mean=mu,        sigma=Kf)
    E  <- rmvnorm(N, mean=rep(0, P), sigma=diag(P))
    X  <- FF %*% t(Lambda) + E


### Using `factanal()`


    (fa <- factanal(X, factors=2, scores="regression"))

    
    Call:
    factanal(x = X, factors = 2, scores = "regression")
    
    Uniquenesses:
    [1] 0.622 0.787 0.735 0.740 0.005 0.652
    
    Loadings:
         Factor1 Factor2
    [1,] -0.602  -0.125 
    [2,] -0.450   0.102 
    [3,]  0.341   0.386 
    [4,]  0.443   0.251 
    [5,] -0.156   0.985 
    [6,]  0.590         
    
                   Factor1 Factor2
    SS loadings      1.249   1.209
    Proportion Var   0.208   0.202
    Cumulative Var   0.208   0.410
    
    Test of the hypothesis that 2 factors are sufficient.
    The chi square statistic is 3.62 on 4 degrees of freedom.
    The p-value is 0.46 


### Using `fa()` from package `psych` with rotation

Rotation uses package `GPArotation`


    library(psych)
    corMat <- cor(X)
    (faPC  <- fa(r=corMat, nfactors=2, n.obs=N, rotate="varimax"))

    Factor Analysis using method =  minres
    Call: fa(r = corMat, nfactors = 2, n.obs = N, rotate = "varimax")
    Standardized loadings (pattern matrix) based upon correlation matrix
        MR2   MR1   h2    u2
    1 -0.60 -0.13 0.38 0.622
    2 -0.45  0.10 0.21 0.787
    3  0.34  0.39 0.27 0.735
    4  0.44  0.25 0.26 0.740
    5 -0.16  0.99 1.00 0.005
    6  0.59 -0.01 0.35 0.652
    
                    MR2  MR1
    SS loadings    1.25 1.21
    Proportion Var 0.21 0.20
    Cumulative Var 0.21 0.41
    
    Test of the hypothesis that 2 factors are sufficient.
    
    The degrees of freedom for the null model are  15  and the objective function was  0.71 with Chi Square of  139.3
    The degrees of freedom for the model are 4  and the objective function was  0.02 
    
    The root mean square of the residuals (RMSR) is  0.02 
    The df corrected root mean square of the residuals is  0.05 
    The number of observations was  200  with Chi Square =  3.62  with prob <  0.46 
    
    Tucker Lewis Index of factoring reliability =  1.012
    RMSEA index =  0  and the 90 % confidence intervals are  NA 0.102
    BIC =  -17.57
    Fit based upon off diagonal values = 0.99
    Measures of factor score adequacy             
                                                    MR2  MR1
    Correlation of scores with factors             0.81 0.99
    Multiple R square of scores with factors       0.66 0.99
    Minimum correlation of possible factor scores  0.32 0.97


Factor scores
-------------------------


    bartlett <- fa$scores
    head(bartlett)

         Factor1 Factor2
    [1,]  0.9556 -1.1165
    [2,] -0.7429  2.4349
    [3,]  1.1023 -0.7070
    [4,] -0.8029 -1.7216
    [5,] -0.8456 -0.8619
    [6,]  0.5332  2.0151



    anderson <- factor.scores(x=X, f=faPC, method="Anderson")
    head(anderson$scores)

             MR2     MR1
    [1,]  1.1372 -1.0911
    [2,] -0.8275  2.4280
    [3,]  1.3329 -0.6729
    [4,] -1.0516 -1.7647
    [5,] -1.0732 -0.8995
    [6,]  0.7299  2.0509


Visualize loadings
-------------------------

You can visualize the loadings from the factor analysis using `factor.plot()` and `fa.diagram()`, both from package `psych`. For some reason, `factor.plot()` accepts only the `$fa` component of the result from `fa.poly()`, not the full object.


    factor.plot(faPC, cut=0.5)

![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-81.png) 

    fa.diagram(faPC)

![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-82.png) 


Determine number of factors
-------------------------

Parallel analysis and a "very simple structure" analysis provide help in selecting the number of factors. Again, package `psych` has the required functions. `vss()` takes the polychoric correlation matrix as an argument.


    fa.parallel(X)                      # parallel analysis

    Parallel analysis suggests that the number of factors =  2  and the number of components =  2 

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-91.png) 

    vss(X, n.obs=N, rotate="varimax")   # very simple structure

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-92.png) 

    
    Very Simple Structure
    Call: VSS(x = x, n = n, rotate = rotate, diagonal = diagonal, fm = fm, 
        n.obs = n.obs, plot = plot, title = title)
    VSS complexity 1 achieves a maximimum of 0.58  with  3  factors
    VSS complexity 2 achieves a maximimum of 0.7  with  3  factors
    
    The Velicer MAP criterion achieves a minimum of NA  with  1  factors
     
    Velicer MAP
    [1] 0.06 0.11 0.21 0.43 1.00   NA
    
    Very Simple Structure Complexity 1
    [1] 0.45 0.56 0.58 0.46 0.46 0.47
    
    Very Simple Structure Complexity 2
    [1] 0.00 0.67 0.70 0.63 0.60 0.61


Detach (automatically) loaded packages (if possible)
-------------------------


    try(detach(package:psych))
    try(detach(package:GPArotation))
    try(detach(package:mvtnorm))


Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/multFA.Rmd) | [markdown](https://github.com/dwoll/RExRepos/raw/master/md/multFA.md) | [R code](https://github.com/dwoll/RExRepos/raw/master/R/multFA.R) - ([all posts](https://github.com/dwoll/RExRepos))
