Data transformations
=========================




TODO
-------------------------

 - `some()` from package [`car`](http://cran.r-project.org/package=car)
 - link to recode
 - link to sort data frames

Convert between data types
-------------------------

### Type hierarchy

Lower types can be uniquely converted to higher types.


    tfVec <- c(TRUE, FALSE, FALSE, TRUE)
    as.numeric(tfVec)

    [1] 1 0 0 1

    as.complex(tfVec)

    [1] 1+0i 0+0i 0+0i 1+0i

    as.character(tfVec)

    [1] "TRUE"  "FALSE" "FALSE" "TRUE" 


Higher types cannot be uniquely converted to lower types.


    as.logical(c(-1, 0, 1, 2))

    [1]  TRUE FALSE  TRUE  TRUE

    as.numeric(as.complex(c(3-2i, 3+2i, 0+1i, 0+0i)))

    Warning: imaginäre Teile verworfen in Umwandlung

    [1] 3 3 0 0

    as.numeric(c("21", "3.141", "abc"))

    Warning: NAs durch Umwandlung erzeugt

    [1] 21.000  3.141     NA


Change order of vector elements
-------------------------

### Sort vectors


    vec <- c(10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20)
    rev(vec)

     [1] 20 19 18 17 16 15 14 13 12 11 10

    vec <- c(10, 12, 1, 12, 7, 16, 6, 19, 10, 19)
    sort(vec)

     [1]  1  6  7 10 10 12 12 16 19 19

    (idxDec <- order(vec, decreasing=TRUE))

     [1]  8 10  6  2  4  1  9  5  7  3

    vec[idxDec]

     [1] 19 19 16 12 12 10 10  7  6  1

    sort(c("D", "E", "10", "A", "F", "E", "D", "4", "E", "A"))

     [1] "10" "4"  "A"  "A"  "D"  "D"  "E"  "E"  "E"  "F" 


### Randomly permute vector elements


    set.seed(1.234)
    myColors  <- c("red", "green", "blue", "yellow", "black")
    (randCols <- sample(myColors, length(myColors), replace=FALSE))

    [1] "green"  "black"  "yellow" "blue"   "red"   



    P   <- 3
    Nj  <- c(4, 3, 5)
    (IV <- rep(1:P, Nj))

     [1] 1 1 1 1 2 2 2 3 3 3 3 3

    (IVrand <- sample(IV, length(IV), replace=FALSE))

     [1] 3 3 2 2 1 1 3 1 3 1 3 2


Randomly place elements in $p$ groups of approximately equal size
-------------------------


    x <- c(18, 11, 15, 20, 19, 10, 14, 13, 10, 10)
    N <- length(x)
    P <- 3
    (sample(1:N, N, replace=FALSE) %% P) + 1

     [1] 2 2 2 3 3 1 2 3 1 1


Select random or systematic subsets of vector elements
-------------------------

### Random selection


    vec <- rep(c("rot", "gruen", "blau"), 10)
    sample(vec, 5, replace=FALSE)

    [1] "blau"  "gruen" "rot"   "gruen" "rot"  


### Select every 10th element


    selIdx1 <- seq(1, length(vec), by=10)
    vec[selIdx1]

    [1] "rot"   "gruen" "blau" 


### Select approximately every 10th element


    selIdx2 <- rbinom(length(vec), size=1, prob=0.1) == 1
    vec[selIdx2]

    [1] "gruen"


Transform old variables into new ones
-------------------------

### Element-wise arithmetic


    age <- c(18, 20, 30, 24, 23, 21)
    age/10

    [1] 1.8 2.0 3.0 2.4 2.3 2.1

    (age/2) + 5

    [1] 14.0 15.0 20.0 17.0 16.5 15.5

    vec1 <- c(3, 4, 5, 6)
    vec2 <- c(-2, 2, -2, 2)
    vec1*vec2

    [1]  -6   8 -10  12

    vec3 <- c(10, 100, 1000, 10000)
    (vec1 + vec2) / vec3

    [1] 1e-01 6e-02 3e-03 8e-04


### Recycling rule


    vec1 <- c(2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24)
    vec2 <- c(2, 4, 6, 8, 10)
    c(length(age), length(vec1), length(vec2))

    [1]  6 12  5

    vec1*age

     [1]  36  80 180 192 230 252 252 320 540 480 506 504

    vec2*age

    Warning: Länge des längeren Objektes ist kein Vielfaches der Länge des
    kürzeren Objektes

    [1]  36  80 180 192 230  42


### Standardize variables


    (zAge <- (age - mean(age)) / sd(age))

    [1] -1.11661 -0.63806  1.75467  0.31903  0.07976 -0.39879

    (zAge <- scale(age))

             [,1]
    [1,] -1.11661
    [2,] -0.63806
    [3,]  1.75467
    [4,]  0.31903
    [5,]  0.07976
    [6,] -0.39879
    attr(,"scaled:center")
    [1] 22.67
    attr(,"scaled:scale")
    [1] 4.179

    as.vector(zAge)

    [1] -1.11661 -0.63806  1.75467  0.31903  0.07976 -0.39879


### Move and scale variable


    newSd   <- 15
    newMean <- 100
    (newAge <- (as.vector(zAge)*newSd) + newMean)

    [1]  83.25  90.43 126.32 104.79 101.20  94.02

    mean(newAge)

    [1] 100

    sd(newAge)

    [1] 15


### Rank transformation


    rank(c(3, 1, 2, 3))

    [1] 3.5 1.0 2.0 3.5


### Transform old variables into new ones


    height <- c(1.78, 1.91, 1.89, 1.83, 1.64)
    weight <- c(65, 89, 91, 75, 73)
    (bmi   <- weight / (height^2))

    [1] 20.52 24.40 25.48 22.40 27.14



    quest1  <- c(FALSE, FALSE, FALSE, TRUE,  FALSE, TRUE, FALSE, TRUE)
    quest2  <- c(TRUE,  FALSE, FALSE, FALSE, TRUE,  TRUE, TRUE,  FALSE)
    quest3  <- c(TRUE,  TRUE,  TRUE,  TRUE,  FALSE, TRUE, FALSE, FALSE)
    (sumVar <- quest1 + quest2 + quest3)

    [1] 2 1 1 2 1 3 1 1


Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/transformData.Rmd) | [markdown](https://github.com/dwoll/RExRepos/raw/master/md/transformData.md) | [R code](https://github.com/dwoll/RExRepos/raw/master/R/transformData.R) - ([all posts](https://github.com/dwoll/RExRepos))
