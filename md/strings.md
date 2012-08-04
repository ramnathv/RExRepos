Character strings
=========================




Create strings from existing objects
-------------------------
    

    randVals <- round(rnorm(5), 2)
    toString(randVals)

    [1] "0.91, 1, -0.13, -2, -0.74"



    formatC(c(1, 2.345), width=5, format="f")

    [1] "1.0000" "2.3450"


Create new strings and control their output
-------------------------

### Create and format strings


    length("ABCDEF")

    [1] 1

    nchar("ABCDEF")

    [1] 6

    nchar(c("A", "BC", "DEF"))

    [1] 1 2 3



    paste("group", LETTERS[1:5], sep="_")

    [1] "group_A" "group_B" "group_C" "group_D" "group_E"

    paste(1:5, palette()[1:5], sep=": ")

    [1] "1: black"  "2: red"    "3: green3" "4: blue"   "5: cyan"  

    paste(1:5, letters[1:5], sep=".", collapse=" ")

    [1] "1.a 2.b 3.c 4.d 5.e"



    N     <- 20
    gName <- "A"
    mVal  <- 14.2
    sprintf("For %d particpants in group %s, the mean was %f", N, gName, mVal)

    [1] "For 20 particpants in group A, the mean was 14.200000"

    sprintf("%.3f", 1.23456)

    [1] "1.235"


### String output with `cat()` and `print()`


    cVar <- "A string"
    cat(cVar, "with\n", 4, "\nwords\n", sep="+")

    A string+with
    +4+
    words



    print(cVar, quote=FALSE)

    [1] A string

    noquote(cVar)

    [1] A string


Manipulate strings
-------------------------


    tolower(c("A", "BC", "DEF"))

    [1] "a"   "bc"  "def"

    toupper(c("ghi", "jk", "i"))

    [1] "GHI" "JK"  "I"  



    strReverse <- function(x) { sapply(lapply(strsplit(x, NULL), rev), paste, collapse="") }
    strReverse(c("Lorem", "ipsum", "dolor", "sit"))

    [1] "meroL" "muspi" "rolod" "tis"  



    substring(c("ABCDEF", "GHIJK", "LMNO", "PQR"), first=4, last=5)

    [1] "DE" "JK" "O"  ""  



    strsplit(c("abc_def_ghi", "jkl_mno"), split="_")

    [[1]]
    [1] "abc" "def" "ghi"
    
    [[2]]
    [1] "jkl" "mno"
    

    strsplit("Xylophon", split=NULL)

    [[1]]
    [1] "X" "y" "l" "o" "p" "h" "o" "n"
    


Find substrings
-------------------------

### Basic pattern matching


    match(c("abc", "de", "f", "h"), c("abcde", "abc", "de", "fg", "ih"))

    [1]  2  3 NA NA

    pmatch(c("abc", "de", "f", "h"), c("abcde", "abc", "de", "fg", "ih"))

    [1]  2  3  4 NA


### Create and use regular expressions

See `?regex`


    grep( "A[BC][[:blank:]]", c("AB ", "AB", "AC ", "A "))

    [1] 1 3

    grepl("A[BC][[:blank:]]", c("AB ", "AB", "AC ", "A "))

    [1]  TRUE FALSE  TRUE FALSE



    pat    <- "[[:upper:]]+"
    txt    <- c("abcDEFG", "ABCdefg", "abcdefg")
    (start <- regexpr(pat, txt))

    [1]  4  1 -1
    attr(,"match.length")
    [1]  4  3 -1
    attr(,"useBytes")
    [1] TRUE



    len <- attr(start, "match.length")
    end <- start + len - 1
    substring(txt, start, end)

    [1] "DEFG" "ABC"  ""    



    glob2rx("asdf*.txt")

    [1] "^asdf.*\\.txt$"


Replace substrings
-------------------------


    charVec <- c("ABCDEF", "GHIJK", "LMNO", "PQR")
    substring(charVec, 4, 5) <- c("..", "xx", "++", "**"); charVec

    [1] "ABC..F" "GHIxx"  "LMN+"   "PQR"   



    sub("em", "XX", "Lorem ipsum dolor sit Lorem ipsum")

    [1] "LorXX ipsum dolor sit Lorem ipsum"

    gsub("em", "XX", "Lorem ipsum dolor sit Lorem ipsum")

    [1] "LorXX ipsum dolor sit LorXX ipsum"


Evaluate strings as instructions
-------------------------


    obj1 <- parse(text="3 + 4")
    obj2 <- parse(text=c("vec <- c(1, 2, 3)", "vec^2"))
    eval(obj1)

    [1] 7

    eval(obj2)

    [1] 1 4 9


Useful packages
-------------------------

Package [`stringr`](http://cran.r-project.org/package=stringr) provides more functions for efficiently and consistently handling character strings.

Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/strings.Rmd) | [markdown](https://github.com/dwoll/RExRepos/raw/master/md/strings.md) | [R code](https://github.com/dwoll/RExRepos/raw/master/R/strings.R) - ([all posts](https://github.com/dwoll/RExRepos))
