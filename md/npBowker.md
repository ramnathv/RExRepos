Bowker-test
=========================


    categ <- factor(1:3, labels=c("lo", "med", "hi"))
    drug  <- rep(categ, c(30, 50, 20))
    plac  <- rep(rep(categ, length(categ)), c(14,7,9, 5,26,19, 1,7,12))
    cTab  <- table(drug, plac)
    addmargins(cTab)

         plac
    drug   lo med  hi Sum
      lo   14   7   9  30
      med   5  26  19  50
      hi    1   7  12  20
      Sum  20  40  40 100



    Q         <- nlevels(categ)
    sqDiffs   <- (cTab - t(cTab))^2 / (cTab + t(cTab))
    (chisqVal <- sum(sqDiffs[upper.tri(cTab)]))

    [1] 12.27

    (bowDf <- choose(Q, 2))

    [1] 3

    (pVal <- 1-pchisq(chisqVal, bowDf))

    [1] 0.006508


Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/npBowker.Rmd) | [markdown](https://github.com/dwoll/RExRepos/raw/master/md/npBowker.md) | [R code](https://github.com/dwoll/RExRepos/raw/master/R/npBowker.R) - ([all posts](https://github.com/dwoll/RExRepos))
