
## @knitr unnamed-chunk-1
wants <- c("epitools")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])


## @knitr unnamed-chunk-2
set.seed(1.234)
(myLetters <- sample(LETTERS[1:5], 12, replace=TRUE))
(tab <- table(myLetters))
names(tab)
tab["B"]


## @knitr unnamed-chunk-3
barplot(tab, main="Counts")


## @knitr unnamed-chunk-4
(relFreq <- prop.table(tab))


## @knitr unnamed-chunk-5
cumsum(relFreq)


## @knitr unnamed-chunk-6
letFac <- factor(myLetters, levels=c(LETTERS[1:5], "Q"))
letFac
table(letFac)


## @knitr unnamed-chunk-7
(vec <- rep(rep(c("f", "m"), 3), c(1, 3, 2, 4, 1, 2)))


## @knitr unnamed-chunk-8
(res <- rle(vec))


## @knitr unnamed-chunk-9
length(res$lengths)


## @knitr unnamed-chunk-10
inverse.rle(res)


## @knitr unnamed-chunk-11
N    <- 10
(sex <- factor(sample(c("f", "m"), N, replace=TRUE)))
(work <- factor(sample(c("home", "office"), N, replace=TRUE)))
(cTab <- table(sex, work))


## @knitr unnamed-chunk-12
summary(cTab)


## @knitr unnamed-chunk-13
barplot(cTab, beside=TRUE, legend.text=rownames(cTab), ylab="absolute frequency")


## @knitr unnamed-chunk-14
counts   <- sample(0:5, N, replace=TRUE)
(persons <- data.frame(sex, work, counts))


## @knitr unnamed-chunk-15
xtabs(~ sex + work, data=persons)
xtabs(counts ~ sex + work, data=persons)


## @knitr unnamed-chunk-16
apply(cTab, MARGIN=1, FUN=sum)
colMeans(cTab)
addmargins(cTab, c(1, 2), FUN=mean)


## @knitr unnamed-chunk-17
(relFreq <- prop.table(cTab))


## @knitr unnamed-chunk-18
prop.table(cTab, 1)


## @knitr unnamed-chunk-19
prop.table(cTab, 2)


## @knitr unnamed-chunk-20
(group <- factor(sample(c("A", "B"), 10, replace=TRUE)))
ftable(work, sex, group, row.vars="work", col.vars=c("sex", "group"))


## @knitr unnamed-chunk-21
library(epitools)
expand.table(cTab)


## @knitr unnamed-chunk-22
as.data.frame(cTab, stringsAsFactors=TRUE)


## @knitr unnamed-chunk-23
(vec <- round(rnorm(10), 2))
Fn <- ecdf(vec)
Fn(vec)
100 * Fn(0.1)
Fn(sort(vec))
knots(Fn)


## @knitr unnamed-chunk-24
plot(Fn, main="cumulative frequencies")


## @knitr unnamed-chunk-25
try(detach(package:epitools))


