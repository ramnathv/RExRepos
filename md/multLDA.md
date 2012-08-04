Linear discriminant analysis (LDA)
=========================

TODO
-------------------------

 - link to logistic, ordinal/multinomial regression

Install required packages
-------------------------

[`mvtnorm`](http://cran.r-project.org/package=mvtnorm), [`MASS`](http://cran.r-project.org/package=MASS)


    wants <- c("mvtnorm", "MASS")
    has   <- wants %in% rownames(installed.packages())
    if(any(!has)) install.packages(wants[!has])


Conventional LDA
-------------------------

### Simulate data


    set.seed(1.234)
    library(mvtnorm)
    Nj    <- c(15, 25, 20)
    Sigma <- matrix(c(16,-2, -2,9), byrow=TRUE, ncol=2)
    mu1   <- c(-4,  4)
    mu2   <- c( 3,  3)
    mu3   <- c( 1, -1)
    Y1    <- rmvnorm(Nj[1], mean=mu1, sigma=Sigma)
    Y2    <- rmvnorm(Nj[2], mean=mu2, sigma=Sigma)
    Y3    <- rmvnorm(Nj[3], mean=mu3, sigma=Sigma)
    Y     <- rbind(Y1, Y2, Y3)
    IV    <- factor(rep(1:length(Nj), Nj))
    Ydf   <- data.frame(IV, DV1=Y[ , 1], DV2=Y[ , 2])


### Run the analysis


    library(MASS)
    (ldaRes <- lda(IV ~ DV1 + DV2, data=Ydf))

    Call:
    lda(IV ~ DV1 + DV2, data = Ydf)
    
    Prior probabilities of groups:
         1      2      3 
    0.2500 0.4167 0.3333 
    
    Group means:
         DV1     DV2
    1 -3.616  4.1624
    2  3.441  3.3288
    3  1.446 -0.6944
    
    Coefficients of linear discriminants:
            LD1     LD2
    DV1  0.2453 -0.1554
    DV2 -0.1465 -0.3330
    
    Proportion of trace:
       LD1    LD2 
    0.5726 0.4274 



    ldaP <- lda(IV ~ DV1 + DV2, CV=TRUE, data=Ydf)
    head(ldaP$posterior)

            1       2        3
    1 0.90665 0.03911 0.054233
    2 0.68389 0.18576 0.130343
    3 0.97073 0.02239 0.006878
    4 0.09603 0.85261 0.051354
    5 0.69575 0.24608 0.058178
    6 0.96937 0.02325 0.007379



    ldaPred <- predict(ldaRes, Ydf)
    ld      <- ldaPred$x
    head(ld)

          LD1      LD2
    1 -2.1103  0.54951
    2 -1.2980  0.09722
    3 -2.8259 -0.27999
    4 -0.2824 -1.43883
    5 -1.4589 -0.55884
    6 -2.7978 -0.26433


### Predicted classification


    cls <- ldaPred$class
    head(cls)

    [1] 1 1 1 2 1 1
    Levels: 1 2 3



    cTab <- table(IV, cls, dnn=c("IV", "ldaPred"))
    addmargins(cTab)

         ldaPred
    IV     1  2  3 Sum
      1   11  3  1  15
      2    2 19  4  25
      3    2  4 14  20
      Sum 15 26 19  60

    sum(diag(cTab)) / sum(cTab)

    [1] 0.7333



    anova(lm(ld[ , 1] ~ IV))

    Analysis of Variance Table
    
    Response: ld[, 1]
              Df Sum Sq Mean Sq F value  Pr(>F)    
    IV         2   40.6    20.3    20.3 2.2e-07 ***
    Residuals 57   57.0     1.0                    
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 

    anova(lm(ld[ , 2] ~ IV))

    Analysis of Variance Table
    
    Response: ld[, 2]
              Df Sum Sq Mean Sq F value  Pr(>F)    
    IV         2   30.3    15.2    15.2 5.2e-06 ***
    Residuals 57   57.0     1.0                    
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 



    priorP <- rep(1/nlevels(IV), nlevels(IV))
    ldaEq  <- lda(IV ~ DV1 + DV2, prior=priorP, data=Ydf)


Robust LDA
-------------------------


    library(MASS)
    (ldaRob <- lda(IV ~ DV1 + DV2, method="mve", data=Ydf))

    Call:
    lda(IV ~ DV1 + DV2, data = Ydf, method = "mve")
    
    Prior probabilities of groups:
         1      2      3 
    0.2500 0.4167 0.3333 
    
    Group means:
         DV1     DV2
    1 -3.616  4.1624
    2  3.441  3.3288
    3  1.446 -0.6944
    
    Coefficients of linear discriminants:
             LD1     LD2
    DV1  0.04588 -0.3019
    DV2 -0.44097 -0.1606
    
    Proportion of trace:
       LD1    LD2 
    0.5737 0.4263 

    predict(ldaRob)$class

     [1] 1 1 1 2 1 1 1 1 3 1 2 1 3 1 2 2 2 3 2 1 2 2 2 2 2 2 3 2 2 2 2 2 2 3 3
    [36] 2 2 2 1 2 3 3 3 3 3 2 2 3 3 2 3 3 2 3 3 3 3 3 3 3
    Levels: 1 2 3


Quadratic Discriminant Analysis
-------------------------


    library(MASS)
    (qdaRes <- qda(IV ~ DV1 + DV2, data=Ydf))

    Call:
    qda(IV ~ DV1 + DV2, data = Ydf)
    
    Prior probabilities of groups:
         1      2      3 
    0.2500 0.4167 0.3333 
    
    Group means:
         DV1     DV2
    1 -3.616  4.1624
    2  3.441  3.3288
    3  1.446 -0.6944

    predict(qdaRes)$class

     [1] 1 1 1 2 1 1 1 1 3 1 2 1 3 1 2 2 2 2 2 1 2 2 2 2 2 2 3 2 2 2 2 2 2 3 3
    [36] 2 2 2 1 2 3 3 3 3 3 2 2 3 3 2 3 3 2 3 3 3 3 3 3 3
    Levels: 1 2 3


Detach (automatically) loaded packages (if possible)
-------------------------


    try(detach(package:MASS))
    try(detach(package:mvtnorm))


Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/multLDA.Rmd) | [markdown](https://github.com/dwoll/RExRepos/raw/master/md/multLDA.md) | [R code](https://github.com/dwoll/RExRepos/raw/master/R/multLDA.R) - ([all posts](https://github.com/dwoll/RExRepos))
