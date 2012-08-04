One-way ANOVA (CR-$p$ design)
=========================

TODO
-------------------------

 - link to normality, variance homogeneity, regression diagnostics
 - link to regression for model comparison
 - link to resamplingPerm, resamplingBootALM

Install required packages
-------------------------

[`car`](http://cran.r-project.org/package=car), [`multcomp`](http://cran.r-project.org/package=multcomp)


    wants <- c("car", "multcomp")
    has   <- wants %in% rownames(installed.packages())
    if(any(!has)) install.packages(wants[!has])


CR-$p$ ANOVA
-------------------------

### Simulate data


    set.seed(1.234)
    P     <- 4
    Nj    <- c(41, 37, 42, 40)
    muJ   <- rep(c(-1, 0, 1, 2), Nj)
    dfCRp <- data.frame(IV=factor(rep(LETTERS[1:P], Nj)),
                        DV=rnorm(sum(Nj), muJ, 6))



    plot.design(DV ~ IV, fun=mean, data=dfCRp,
                main="Mittelwerte getrennt nach Gruppen")

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3.png) 


### Using `oneway.test()`
#### Assuming variance homogeneity


    oneway.test(DV ~ IV, data=dfCRp, var.equal=TRUE)

    
    	One-way analysis of means
    
    data:  DV and IV 
    F = 1.139, num df = 3, denom df = 156, p-value = 0.3353
    


#### Generalized Welch-test without assumption of variance homogeneity


    oneway.test(DV ~ IV, data=dfCRp, var.equal=FALSE)

    
    	One-way analysis of means (not assuming equal variances)
    
    data:  DV and IV 
    F = 1.226, num df = 3.00, denom df = 85.85, p-value = 0.3053
    


### Using `aov()`


    aovCRp <- aov(DV ~ IV, data=dfCRp)
    summary(aovCRp)

                 Df Sum Sq Mean Sq F value Pr(>F)
    IV            3    101    33.6    1.14   0.34
    Residuals   156   4602    29.5               

    model.tables(aovCRp, type="means")

    Tables of means
    Grand mean
           
    0.5344 
    
     IV 
              A       B      C       D
        -0.4854  0.8903  1.594  0.1376
    rep 41.0000 37.0000 42.000 40.0000


### Model comparisons using `anova(lm())`


    (anovaCRp <- anova(lm(DV ~ IV, data=dfCRp)))

    Analysis of Variance Table
    
    Response: DV
               Df Sum Sq Mean Sq F value Pr(>F)
    IV          3    101    33.6    1.14   0.34
    Residuals 156   4602    29.5               



    anova(lm(DV ~ 1, data=dfCRp), lm(DV ~ IV, data=dfCRp))

    Analysis of Variance Table
    
    Model 1: DV ~ 1
    Model 2: DV ~ IV
      Res.Df  RSS Df Sum of Sq    F Pr(>F)
    1    159 4703                         
    2    156 4602  3       101 1.14   0.34



    anovaCRp["Residuals", "Sum Sq"]

    [1] 4602


Effect size estimates
-------------------------


    dfSSb <- anovaCRp["IV",        "Df"]
    SSb   <- anovaCRp["IV",        "Sum Sq"]
    MSb   <- anovaCRp["IV",        "Mean Sq"]
    SSw   <- anovaCRp["Residuals", "Sum Sq"]
    MSw   <- anovaCRp["Residuals", "Mean Sq"]



    (etaSq <- SSb / (SSb + SSw))

    [1] 0.02143

    (omegaSq <- dfSSb * (MSb-MSw) / (SSb + SSw + MSw))

    [1] 0.002595

    (f <- sqrt(etaSq / (1-etaSq)))

    [1] 0.148


Or from function `ezANOVA()` from package [`ez`](http://cran.r-project.org/package=ez)

Planned comparisons
-------------------------

### General contrasts using `glht()` from package `multcomp`


    cntrMat <- rbind("A-D"          =c(  1,   0,   0,  -1),
                     "1/3*(A+B+C)-D"=c(1/3, 1/3, 1/3,  -1),
                     "B-C"          =c(  0,   1,  -1,   0))
    library(multcomp)
    summary(glht(aovCRp, linfct=mcp(IV=cntrMat), alternative="less"),
            test=adjusted("none"))

    
    	 Simultaneous Tests for General Linear Hypotheses
    
    Multiple Comparisons of Means: User-defined Contrasts
    
    
    Fit: aov(formula = DV ~ IV, data = dfCRp)
    
    Linear Hypotheses:
                       Estimate Std. Error t value Pr(<t)
    A-D >= 0             -0.623      1.207   -0.52   0.30
    1/3*(A+B+C)-D >= 0    0.529      0.992    0.53   0.70
    B-C >= 0             -0.704      1.225   -0.57   0.28
    (Adjusted p values reported -- none method)
    


### Pairwise $t$-tests


    pairwise.t.test(dfCRp$DV, dfCRp$IV, p.adjust.method="bonferroni")

    
    	Pairwise comparisons using t tests with pooled SD 
    
    data:  dfCRp$DV and dfCRp$IV 
    
      A   B   C  
    B 1.0 -   -  
    C 0.5 1.0 -  
    D 1.0 1.0 1.0
    
    P value adjustment method: bonferroni 


### Tukey's simultaneous confidence intervals


    (tHSD <- TukeyHSD(aovCRp))

      Tukey multiple comparisons of means
        95% family-wise confidence level
    
    Fit: aov(formula = DV ~ IV, data = dfCRp)
    
    $IV
           diff    lwr   upr  p adj
    B-A  1.3757 -1.823 4.574 0.6796
    C-A  2.0794 -1.017 5.176 0.3047
    D-A  0.6230 -2.512 3.758 0.9551
    C-B  0.7037 -2.477 3.884 0.9395
    D-B -0.7527 -3.970 2.465 0.9296
    D-C -1.4564 -4.573 1.660 0.6191
    



    plot(tHSD)

![plot of chunk unnamed-chunk-15](figure/unnamed-chunk-15.png) 


Assess test assumptions
-------------------------


    Estud <- rstudent(aovCRp)
    qqnorm(Estud, pch=20, cex=2)
    qqline(Estud, col="gray60", lwd=2)

![plot of chunk unnamed-chunk-16](figure/unnamed-chunk-16.png) 



    shapiro.test(Estud)

    
    	Shapiro-Wilk normality test
    
    data:  Estud 
    W = 0.9945, p-value = 0.808
    



    plot(Estud ~ dfCRp$IV, main="Residuen vs. Stufen")

![plot of chunk unnamed-chunk-18](figure/unnamed-chunk-18.png) 



    library(car)
    leveneTest(aovCRp)

    Levene's Test for Homogeneity of Variance (center = median)
           Df F value Pr(>F)
    group   3    0.08   0.97
          156               


Detach (automatically) loaded packages (if possible)
-------------------------


    try(detach(package:car))
    try(detach(package:nnet))
    try(detach(package:MASS))
    try(detach(package:multcomp))
    try(detach(package:survival))
    try(detach(package:mvtnorm))
    try(detach(package:splines))


Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/anovaCRp.Rmd) | [markdown](https://github.com/dwoll/RExRepos/raw/master/md/anovaCRp.md) | [R code](https://github.com/dwoll/RExRepos/raw/master/R/anovaCRp.R) - ([all posts](https://github.com/dwoll/RExRepos))
