Combinatorics
=========================

TODO
-------------------------

 - link to sets

Install required packages
-------------------------

[`e1071`](http://cran.r-project.org/package=e1071), [`permute`](http://cran.r-project.org/package=permute)


    wants <- c("e1071", "permute")
    has   <- wants %in% rownames(installed.packages())
    if(any(!has)) install.packages(wants[!has])


Combinations
-------------------------

### Number of $k$-combinations

${n \choose k}$


    myN <- 5
    myK <- 4
    choose(myN, myK)

    [1] 5

    factorial(myN) / (factorial(myK)*factorial(myN-myK))

    [1] 5


### Enumerate all combinations


    combn(c("a", "b", "c", "d", "e"), myK)

         [,1] [,2] [,3] [,4] [,5]
    [1,] "a"  "a"  "a"  "a"  "b" 
    [2,] "b"  "b"  "b"  "c"  "c" 
    [3,] "c"  "c"  "d"  "d"  "d" 
    [4,] "d"  "e"  "e"  "e"  "e" 

    combn(c(1, 2, 3, 4), 3)

         [,1] [,2] [,3] [,4]
    [1,]    1    1    1    2
    [2,]    2    2    3    3
    [3,]    3    4    4    4



    combn(c(1, 2, 3, 4), 3, sum)

    [1] 6 7 8 9

    combn(c(1, 2, 3, 4), 3, weighted.mean, w=c(0.5, 0.2, 0.3))

    [1] 1.8 2.1 2.3 2.8


Permutations
-------------------------

### Number of permutations


    factorial(7)

    [1] 5040


### Random permutation


    set.seed(1.234)
    set <- LETTERS[1:10]
    sample(set, length(set), replace=FALSE)

     [1] "C" "D" "E" "G" "B" "H" "I" "F" "J" "A"



    library(permute)
    shuffle(length(set))

     [1]  3  2  6 10  5  7  8  4  1  9


### Enumerate all permutations
#### All permutations at once

    set <- LETTERS[1:3]
    len <- length(set)
    library(e1071)
    (mat <- permutations(len))

         [,1] [,2] [,3]
    [1,]    1    2    3
    [2,]    2    1    3
    [3,]    2    3    1
    [4,]    1    3    2
    [5,]    3    1    2
    [6,]    3    2    1

    apply(mat, 1, function(x) set[x])

         [,1] [,2] [,3] [,4] [,5] [,6]
    [1,] "A"  "B"  "B"  "A"  "C"  "C" 
    [2,] "B"  "A"  "C"  "C"  "A"  "B" 
    [3,] "C"  "C"  "A"  "B"  "B"  "A" 


#### Each permutation individually


    (grp <- rep(letters[1:3], each=3))

    [1] "a" "a" "a" "b" "b" "b" "c" "c" "c"

    N      <- length(grp)
    nPerms <- 100
    library(permute)
    pCtrl <- permControl(nperm=nPerms, complete=FALSE)
    for(i in 1:5) {
        perm <- permute(i, n=N, control=pCtrl)
        print(grp[perm])
    }

    [1] "c" "a" "b" "a" "c" "c" "b" "a" "b"
    [1] "b" "c" "b" "a" "a" "c" "b" "a" "c"
    [1] "c" "b" "b" "c" "c" "a" "a" "b" "a"
    [1] "b" "b" "c" "a" "c" "a" "a" "c" "b"
    [1] "a" "b" "c" "c" "c" "a" "b" "a" "b"


#### Restricted permutations


    Njk    <- 4                                 # Zellbesetzung
    P      <- 2                                 # Anzahl Stufen Faktor A
    Q      <- 3                                 # Anzahl Stufen Faktor B
    N      <- Njk*P*Q
    nPerms <- 10             # Anzahl Permutationen
    id     <- 1:(Njk*P*Q)
    IV1    <- factor(rep(1:P,  each=Njk*Q))     # Faktor A
    IV2    <- factor(rep(1:Q, times=Njk*P))     # Faktor B
    (myDf  <- data.frame(id, IV1, IV2))

       id IV1 IV2
    1   1   1   1
    2   2   1   2
    3   3   1   3
    4   4   1   1
    5   5   1   2
    6   6   1   3
    7   7   1   1
    8   8   1   2
    9   9   1   3
    10 10   1   1
    11 11   1   2
    12 12   1   3
    13 13   2   1
    14 14   2   2
    15 15   2   3
    16 16   2   1
    17 17   2   2
    18 18   2   3
    19 19   2   1
    20 20   2   2
    21 21   2   3
    22 22   2   1
    23 23   2   2
    24 24   2   3

    
    # lege Permutationsschema fuer Test von A, B fest
    library(permute)                                                # fuer permControl(), permute()
    pCtrlA <- permControl(strata=IV2, complete=FALSE, nperm=nPerms) # only permute across A (within B)
    pCtrlB <- permControl(strata=IV1, complete=FALSE, nperm=nPerms) # only permute across B (within A)


fuehre Permutationen fuer Test von A, B, Interaktion durch

    for(i in 1:3) {
        perm <- permute(i, n=N, control=pCtrlA)
        print(myDf[perm, ])
    }



    for(i in 1:3) {
        perm <- permute(i, n=N, control=pCtrlB)
        print(myDf[perm, ])
    }


Enumerate all combinations of elements from different sets
-------------------------


    IV1 <- c("control", "treatment")
    IV2 <- c("f", "m")
    IV3 <- c(1, 2)
    expand.grid(IV1, IV2, IV3)

           Var1 Var2 Var3
    1   control    f    1
    2 treatment    f    1
    3   control    m    1
    4 treatment    m    1
    5   control    f    2
    6 treatment    f    2
    7   control    m    2
    8 treatment    m    2


Apply a function to all pairs of elements from two sets
-------------------------


    outer(1:5, 1:5, FUN="*")

         [,1] [,2] [,3] [,4] [,5]
    [1,]    1    2    3    4    5
    [2,]    2    4    6    8   10
    [3,]    3    6    9   12   15
    [4,]    4    8   12   16   20
    [5,]    5   10   15   20   25


Detach (automatically) loaded packages (if possible)
-------------------------


    try(detach(package:e1071))
    try(detach(package:class))
    try(detach(package:permute))


Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/combinatorics.Rmd) | [markdown](https://github.com/dwoll/RExRepos/raw/master/md/combinatorics.md) | [R code](https://github.com/dwoll/RExRepos/raw/master/R/combinatorics.R) - ([all posts](https://github.com/dwoll/RExRepos))
