Character strings
=========================




Create strings from existing objects
-------------------------
    

{% highlight r %}
randVals <- round(rnorm(5), 2)
toString(randVals)
{% endhighlight %}



{% highlight text %}
[1] "0.91, 1, -0.13, -2, -0.74"
{% endhighlight %}



{% highlight r %}
formatC(c(1, 2.345), width=5, format="f")
{% endhighlight %}



{% highlight text %}
[1] "1.0000" "2.3450"
{% endhighlight %}


Create new strings and control their output
-------------------------

### Create and format strings


{% highlight r %}
length("ABCDEF")
{% endhighlight %}



{% highlight text %}
[1] 1
{% endhighlight %}



{% highlight r %}
nchar("ABCDEF")
{% endhighlight %}



{% highlight text %}
[1] 6
{% endhighlight %}



{% highlight r %}
nchar(c("A", "BC", "DEF"))
{% endhighlight %}



{% highlight text %}
[1] 1 2 3
{% endhighlight %}



{% highlight r %}
paste("group", LETTERS[1:5], sep="_")
{% endhighlight %}



{% highlight text %}
[1] "group_A" "group_B" "group_C" "group_D" "group_E"
{% endhighlight %}



{% highlight r %}
paste(1:5, palette()[1:5], sep=": ")
{% endhighlight %}



{% highlight text %}
[1] "1: black"  "2: red"    "3: green3" "4: blue"   "5: cyan"  
{% endhighlight %}



{% highlight r %}
paste(1:5, letters[1:5], sep=".", collapse=" ")
{% endhighlight %}



{% highlight text %}
[1] "1.a 2.b 3.c 4.d 5.e"
{% endhighlight %}



{% highlight r %}
N     <- 20
gName <- "A"
mVal  <- 14.2
sprintf("For %d particpants in group %s, the mean was %f", N, gName, mVal)
{% endhighlight %}



{% highlight text %}
[1] "For 20 particpants in group A, the mean was 14.200000"
{% endhighlight %}



{% highlight r %}
sprintf("%.3f", 1.23456)
{% endhighlight %}



{% highlight text %}
[1] "1.235"
{% endhighlight %}


### String output with `cat()` and `print()`


{% highlight r %}
cVar <- "A string"
cat(cVar, "with\n", 4, "\nwords\n", sep="+")
{% endhighlight %}



{% highlight text %}
A string+with
+4+
words
{% endhighlight %}



{% highlight r %}
print(cVar, quote=FALSE)
{% endhighlight %}



{% highlight text %}
[1] A string
{% endhighlight %}



{% highlight r %}
noquote(cVar)
{% endhighlight %}



{% highlight text %}
[1] A string
{% endhighlight %}


Manipulate strings
-------------------------


{% highlight r %}
tolower(c("A", "BC", "DEF"))
{% endhighlight %}



{% highlight text %}
[1] "a"   "bc"  "def"
{% endhighlight %}



{% highlight r %}
toupper(c("ghi", "jk", "i"))
{% endhighlight %}



{% highlight text %}
[1] "GHI" "JK"  "I"  
{% endhighlight %}



{% highlight r %}
strReverse <- function(x) { sapply(lapply(strsplit(x, NULL), rev), paste, collapse="") }
strReverse(c("Lorem", "ipsum", "dolor", "sit"))
{% endhighlight %}



{% highlight text %}
[1] "meroL" "muspi" "rolod" "tis"  
{% endhighlight %}



{% highlight r %}
substring(c("ABCDEF", "GHIJK", "LMNO", "PQR"), first=4, last=5)
{% endhighlight %}



{% highlight text %}
[1] "DE" "JK" "O"  ""  
{% endhighlight %}



{% highlight r %}
strsplit(c("abc_def_ghi", "jkl_mno"), split="_")
{% endhighlight %}



{% highlight text %}
[[1]]
[1] "abc" "def" "ghi"

[[2]]
[1] "jkl" "mno"

{% endhighlight %}



{% highlight r %}
strsplit("Xylophon", split=NULL)
{% endhighlight %}



{% highlight text %}
[[1]]
[1] "X" "y" "l" "o" "p" "h" "o" "n"

{% endhighlight %}


Find substrings
-------------------------

### Basic pattern matching


{% highlight r %}
match(c("abc", "de", "f", "h"), c("abcde", "abc", "de", "fg", "ih"))
{% endhighlight %}



{% highlight text %}
[1]  2  3 NA NA
{% endhighlight %}



{% highlight r %}
pmatch(c("abc", "de", "f", "h"), c("abcde", "abc", "de", "fg", "ih"))
{% endhighlight %}



{% highlight text %}
[1]  2  3  4 NA
{% endhighlight %}


### Create and use regular expressions

See `?regex`


{% highlight r %}
grep( "A[BC][[:blank:]]", c("AB ", "AB", "AC ", "A "))
{% endhighlight %}



{% highlight text %}
[1] 1 3
{% endhighlight %}



{% highlight r %}
grepl("A[BC][[:blank:]]", c("AB ", "AB", "AC ", "A "))
{% endhighlight %}



{% highlight text %}
[1]  TRUE FALSE  TRUE FALSE
{% endhighlight %}



{% highlight r %}
pat    <- "[[:upper:]]+"
txt    <- c("abcDEFG", "ABCdefg", "abcdefg")
(start <- regexpr(pat, txt))
{% endhighlight %}



{% highlight text %}
[1]  4  1 -1
attr(,"match.length")
[1]  4  3 -1
attr(,"useBytes")
[1] TRUE
{% endhighlight %}



{% highlight r %}
len <- attr(start, "match.length")
end <- start + len - 1
substring(txt, start, end)
{% endhighlight %}



{% highlight text %}
[1] "DEFG" "ABC"  ""    
{% endhighlight %}



{% highlight r %}
glob2rx("asdf*.txt")
{% endhighlight %}



{% highlight text %}
[1] "^asdf.*\\.txt$"
{% endhighlight %}


Replace substrings
-------------------------


{% highlight r %}
charVec <- c("ABCDEF", "GHIJK", "LMNO", "PQR")
substring(charVec, 4, 5) <- c("..", "xx", "++", "**"); charVec
{% endhighlight %}



{% highlight text %}
[1] "ABC..F" "GHIxx"  "LMN+"   "PQR"   
{% endhighlight %}



{% highlight r %}
sub("em", "XX", "Lorem ipsum dolor sit Lorem ipsum")
{% endhighlight %}



{% highlight text %}
[1] "LorXX ipsum dolor sit Lorem ipsum"
{% endhighlight %}



{% highlight r %}
gsub("em", "XX", "Lorem ipsum dolor sit Lorem ipsum")
{% endhighlight %}



{% highlight text %}
[1] "LorXX ipsum dolor sit LorXX ipsum"
{% endhighlight %}


Evaluate strings as instructions
-------------------------


{% highlight r %}
obj1 <- parse(text="3 + 4")
obj2 <- parse(text=c("vec <- c(1, 2, 3)", "vec^2"))
eval(obj1)
{% endhighlight %}



{% highlight text %}
[1] 7
{% endhighlight %}



{% highlight r %}
eval(obj2)
{% endhighlight %}



{% highlight text %}
[1] 1 4 9
{% endhighlight %}


Useful packages
-------------------------

Package [`stringr`](http://cran.r-project.org/package=stringr) provides more functions for efficiently and consistently handling character strings.

Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/strings.Rmd) - [markdown](https://github.com/dwoll/RExRepos/raw/master/md/strings.md) - [R code](https://github.com/dwoll/RExRepos/raw/master/R/strings.R) - [all posts](https://github.com/dwoll/RExRepos)
