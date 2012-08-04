
## @knitr unnamed-chunk-1
opts_knit$set(self.contained=FALSE)
opts_chunk$set(tidy=FALSE, message=FALSE, warning=FALSE, comment="")


## @knitr unnamed-chunk-2
randVals <- round(rnorm(5), 2)
toString(randVals)


## @knitr unnamed-chunk-3
formatC(c(1, 2.345), width=5, format="f")


## @knitr unnamed-chunk-4
length("ABCDEF")
nchar("ABCDEF")
nchar(c("A", "BC", "DEF"))


## @knitr unnamed-chunk-5
paste("group", LETTERS[1:5], sep="_")
paste(1:5, palette()[1:5], sep=": ")
paste(1:5, letters[1:5], sep=".", collapse=" ")


## @knitr unnamed-chunk-6
N     <- 20
gName <- "A"
mVal  <- 14.2
sprintf("For %d particpants in group %s, the mean was %f", N, gName, mVal)
sprintf("%.3f", 1.23456)


## @knitr unnamed-chunk-7
cVar <- "A string"
cat(cVar, "with\n", 4, "\nwords\n", sep="+")


## @knitr unnamed-chunk-8
print(cVar, quote=FALSE)
noquote(cVar)


## @knitr unnamed-chunk-9
tolower(c("A", "BC", "DEF"))
toupper(c("ghi", "jk", "i"))


## @knitr unnamed-chunk-10
strReverse <- function(x) { sapply(lapply(strsplit(x, NULL), rev), paste, collapse="") }
strReverse(c("Lorem", "ipsum", "dolor", "sit"))


## @knitr unnamed-chunk-11
substring(c("ABCDEF", "GHIJK", "LMNO", "PQR"), first=4, last=5)


## @knitr unnamed-chunk-12
strsplit(c("abc_def_ghi", "jkl_mno"), split="_")
strsplit("Xylophon", split=NULL)


## @knitr unnamed-chunk-13
match(c("abc", "de", "f", "h"), c("abcde", "abc", "de", "fg", "ih"))
pmatch(c("abc", "de", "f", "h"), c("abcde", "abc", "de", "fg", "ih"))


## @knitr unnamed-chunk-14
grep( "A[BC][[:blank:]]", c("AB ", "AB", "AC ", "A "))
grepl("A[BC][[:blank:]]", c("AB ", "AB", "AC ", "A "))


## @knitr unnamed-chunk-15
pat    <- "[[:upper:]]+"
txt    <- c("abcDEFG", "ABCdefg", "abcdefg")
(start <- regexpr(pat, txt))


## @knitr unnamed-chunk-16
len <- attr(start, "match.length")
end <- start + len - 1
substring(txt, start, end)


## @knitr unnamed-chunk-17
glob2rx("asdf*.txt")


## @knitr unnamed-chunk-18
charVec <- c("ABCDEF", "GHIJK", "LMNO", "PQR")
substring(charVec, 4, 5) <- c("..", "xx", "++", "**"); charVec


## @knitr unnamed-chunk-19
sub("em", "XX", "Lorem ipsum dolor sit Lorem ipsum")
gsub("em", "XX", "Lorem ipsum dolor sit Lorem ipsum")


## @knitr unnamed-chunk-20
obj1 <- parse(text="3 + 4")
obj2 <- parse(text=c("vec <- c(1, 2, 3)", "vec^2"))
eval(obj1)
eval(obj2)


