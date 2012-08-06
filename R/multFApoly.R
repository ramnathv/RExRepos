
## @knitr unnamed-chunk-1
wants <- c("mvtnorm", "psych", "polycor")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])


## @knitr unnamed-chunk-2
set.seed(1.234)
N <- 200                             # number of observations
P <- 6                               # number of variables
Q <- 2                               # number of factors

# true P x Q loading matrix -> variable-factor correlations
Lambda <- matrix(c(0.7,-0.4, 0.8,0, -0.2,0.9, -0.3,0.4, 0.3,0.7, -0.8,0.1),
                 nrow=P, ncol=Q, byrow=TRUE)


## @knitr unnamed-chunk-3
library(mvtnorm)                      # for rmvnorm()
FF  <- rmvnorm(N, mean=c(5, 15), sigma=diag(Q))    # factor scores (uncorrelated factors)
E   <- rmvnorm(N, rep(0, P), diag(P)) # matrix with iid, mean 0, normal errors
X   <- FF %*% t(Lambda) + E           # matrix with variable values
dfX <- data.frame(X)                  # data also as a data frame


## @knitr unnamed-chunk-4
# categorize variables into a list of ordered factors
lOrd <- lapply(dfX, function(x) {
               cut(x, breaks=quantile(x), include.lowest=TRUE,
                   ordered=TRUE, labels=LETTERS[1:4]) })
dfOrd  <- data.frame(lOrd)            # combine list into a data frame
ordNum <- data.matrix(dfOrd)          # categorized data as a numeric matrix


## @knitr unnamed-chunk-5
library(polycor)                      # for hetcor()
pc <- hetcor(dfOrd, ML=TRUE)          # polychoric corr matrix


## @knitr unnamed-chunk-6
library(psych)
faPC <- fa(r=pc$correlations, nfactors=2, n.obs=N, rotate="varimax")
faPC$loadings


## @knitr unnamed-chunk-7
faPCdirect <- fa.poly(ordNum, nfactors=2, rotate="varimax")    # polychoric FA


## @knitr unnamed-chunk-8
faPCdirect$fa$loadings        # loadings are the same as above ...


## @knitr rerMultFApoly01
factor.plot(faPCdirect$fa, cut=0.5)
fa.diagram(faPCdirect)


## @knitr rerMultFApoly02
fap <- fa.parallel.poly(ordNum)      # parallel analysis for dichotomous data


## @knitr rerMultFApoly03
fap
vss(pc$correlations, n.obs=N, rotate="varimax")   # very simple structure


## @knitr unnamed-chunk-9
try(detach(package:psych))
try(detach(package:polycor))
try(detach(package:sfsmisc))
try(detach(package:mvtnorm))


