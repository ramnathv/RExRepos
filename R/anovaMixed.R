
## @knitr unnamed-chunk-1
wants <- c("lme4", "nlme")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])


## @knitr unnamed-chunk-2
set.seed(1.234)
P     <- 2               # Xb1
Q     <- 2               # Xb2
R     <- 3               # Xw1
S     <- 3               # Xw2
Njklm <- 20              # obs per cell
Njk   <- Njklm*P*Q       # number of subjects
N     <- Njklm*P*Q*R*S   # number of observations
id    <- gl(Njk,         R*S, N, labels=c(paste("s", 1:Njk, sep="")))
Xb1   <- gl(P,   Njklm*Q*R*S, N, labels=c("CG", "T"))
Xb2   <- gl(Q,   Njklm  *R*S, N, labels=c("f", "m"))
Xw1   <- gl(R,             S, N, labels=c("A", "B", "C"))
Xw2   <- gl(S,   1,           N, labels=c("-", "o", "+"))


## @knitr unnamed-chunk-3
mu      <- 100
eB1     <- c(-5, 5)
eB2     <- c(-5, 5)
eW1     <- c(-5, 0, 5)
eW2     <- c(-5, 0, 5)
eB1B2   <- c(-5, 5, 5, -5)
eB1W1   <- c(-5, 5, 2, -2, 3, -3)
eB1W2   <- c(-5, 5, 2, -2, 3, -3)
eB2W1   <- c(-5, 5, 2, -2, 3, -3)
eB2W2   <- c(-5, 5, 2, -2, 3, -3)
eW1W2   <- c(-5, 2, 3, 2, 3, -5, 2, -5, 3)
eB1B2W1 <- c(-5, 5, 5, -5, 2, -2, -2, 2, 3, -3, -3, 3)
eB1B2W2 <- c(-5, 5, 5, -5, 2, -2, -2, 2, 3, -3, -3, 3)
eB1W1W2 <- c(-5, 5, 2, -2, 3, -3, 3, -3, -5, 5, 2, -2, 2, -2, 3, -3, -5, 5)
eB2W1W2 <- c(-5, 5, 2, -2, 3, -3, 3, -3, -5, 5, 2, -2, 2, -2, 3, -3, -5, 5)
# no 3rd-order interaction B1xB2xW1xW2


## @knitr unnamed-chunk-4
names(eB1)     <- levels(Xb1)
names(eB2)     <- levels(Xb2)
names(eW1)     <- levels(Xw1)
names(eW2)     <- levels(Xw2)
names(eB1B2)   <- levels(interaction(Xb1, Xb2))
names(eB1W1)   <- levels(interaction(Xb1, Xw1))
names(eB1W2)   <- levels(interaction(Xb1, Xw2))
names(eB2W1)   <- levels(interaction(Xb2, Xw1))
names(eB2W2)   <- levels(interaction(Xb2, Xw2))
names(eW1W2)   <- levels(interaction(Xw1, Xw2))
names(eB1B2W1) <- levels(interaction(Xb1, Xb2, Xw1))
names(eB1B2W2) <- levels(interaction(Xb1, Xb2, Xw2))
names(eB1W1W2) <- levels(interaction(Xb1, Xw1, Xw2))
names(eB2W1W2) <- levels(interaction(Xb2, Xw1, Xw2))


## @knitr unnamed-chunk-5
muJKLM <- mu +
          eB1[Xb1] + eB2[Xb2] + eW1[Xw1] + eW2[Xw2] +
          eB1B2[interaction(Xb1, Xb2)] +
          eB1W1[interaction(Xb1, Xw1)] +
          eB1W2[interaction(Xb1, Xw2)] +
          eB2W1[interaction(Xb2, Xw1)] +
          eB2W2[interaction(Xb2, Xw2)] +
          eW1W2[interaction(Xw1, Xw2)] +
          eB1B2W1[interaction(Xb1, Xb2, Xw1)] +
          eB1B2W2[interaction(Xb1, Xb2, Xw2)] +
          eB1W1W2[interaction(Xb1, Xw1, Xw2)] +
          eB2W1W2[interaction(Xb2, Xw1, Xw2)]
muId  <- rep(rnorm(Njk, 0, 3), each=R*S)
mus   <- muJKLM + muId
sigma <- 50

Y  <- round(rnorm(N, mus, sigma), 1)
d2 <- data.frame(id, Xb1, Xb2, Xw1, Xw2, Y)


## @knitr unnamed-chunk-6
d1 <- aggregate(Y ~ id + Xw1 + Xb1 + Xb2, data=d2, FUN=mean)


## @knitr unnamed-chunk-7
summary(aov(Y ~ Xw1 + Error(id/Xw1), data=d1))


## @knitr unnamed-chunk-8
library(nlme)
anova(lme(Y ~ Xw1, random=~1 | id, method="ML", data=d1))


## @knitr unnamed-chunk-9
lmeFit <- lme(Y ~ Xw1, random=~1 | id, correlation=corCompSymm(form=~1|id),
              method="ML", data=d1)
anova(lmeFit)


## @knitr unnamed-chunk-10
anova(lme(Y ~ Xw1, random=list(id=pdCompSymm(~Xw1-1)), method="REML", data=d1))


## @knitr unnamed-chunk-11
library(lme4)
anova(lmer(Y ~ Xw1 + (1|id), data=d1))


## @knitr unnamed-chunk-12
library(multcomp)
contr <- glht(lmeFit, linfct=mcp(Xw1="Tukey"))
summary(contr)
confint(contr)


## @knitr unnamed-chunk-13
summary(aov(Y ~ Xw1*Xw2 + Error(id/(Xw1*Xw2)), data=d2))


## @knitr unnamed-chunk-14
anova(lme(Y ~ Xw1*Xw2, random=list(id=pdBlocked(list(~1, pdIdent(~Xw1-1), pdIdent(~Xw2-1)))),
          method="ML", data=d2))


## @knitr unnamed-chunk-15
anova(lme(Y ~ Xw1*Xw2,
          random=list(id=pdBlocked(list(~1, pdCompSymm(~Xw1-1), pdCompSymm(~Xw2-1)))),
          method="ML", data=d2))


## @knitr unnamed-chunk-16
anova(lmer(Y ~ Xw1*Xw2 + (1|id) + (1|Xw1:id) + (1|Xw2:id), data=d2))


## @knitr unnamed-chunk-17
summary(aov(Y ~ Xb1*Xw1 + Error(id/Xw1), data=d1))


## @knitr unnamed-chunk-18
anova(lme(Y ~ Xb1*Xw1, random=~1 | id, method="ML", data=d1))


## @knitr unnamed-chunk-19
anova(lme(Y ~ Xb1*Xw1, random=~1 | id, correlation=corCompSymm(form=~1|id),
          method="ML", data=d1))


## @knitr unnamed-chunk-20
anova(lme(Y ~ Xb1*Xw1, random=list(id=pdCompSymm(~Xw1-1)), method="REML", data=d1))


## @knitr unnamed-chunk-21
anova(lmer(Y ~ Xb1*Xw1 + (1|id), data=d1))


## @knitr unnamed-chunk-22
summary(aov(Y ~ Xb1*Xb2*Xw1 + Error(id/Xw1), data=d1))


## @knitr unnamed-chunk-23
anova(lme(Y ~ Xb1*Xb2*Xw1, random=~1 | id, method="ML", data=d1))


## @knitr unnamed-chunk-24
anova(lme(Y ~ Xb1*Xb2*Xw1, random=~1 | id,
          correlation=corCompSymm(form=~1 | id), method="ML", data=d1))


## @knitr unnamed-chunk-25
anova(lme(Y ~ Xb1*Xb2*Xw1,
          random=list(id=pdBlocked(list(~1, pdCompSymm(~Xw1-1)))),
          method="ML", data=d1))


## @knitr unnamed-chunk-26
anova(lmer(Y ~ Xb1*Xb2*Xw1 + (1|id), data=d1))


## @knitr unnamed-chunk-27
summary(aov(Y ~ Xb1*Xw1*Xw2 + Error(id/(Xw1*Xw2)), data=d2))


## @knitr unnamed-chunk-28
anova(lme(Y ~ Xb1*Xw1*Xw2,
          random=list(id=pdBlocked(list(~1, pdIdent(~Xw1-1), pdIdent(~Xw2-1)))),
          method="ML", data=d2))


## @knitr unnamed-chunk-29
anova(lme(Y ~ Xb1*Xw1*Xw2,
          random=list(id=pdBlocked(list(~1, pdCompSymm(~Xw1-1), pdCompSymm(~Xw2-1)))),
          method="ML", data=d2))


## @knitr unnamed-chunk-30
anova(lmer(Y ~ Xb1*Xw1*Xw2 + (1|id) + (1|Xw1:id) + (1|Xw2:id), data=d2))


## @knitr unnamed-chunk-31
summary(aov(Y ~ Xb1*Xb2*Xw1*Xw2 + Error(id/(Xw1*Xw2)), data=d2))


## @knitr unnamed-chunk-32
anova(lme(Y ~ Xb1*Xb2*Xw1*Xw2,
          random=list(id=pdBlocked(list(~1, pdIdent(~Xw1-1), pdIdent(~Xw2-1)))),
          method="ML", data=d2))


## @knitr unnamed-chunk-33
anova(lme(Y ~ Xb1*Xb2*Xw1*Xw2,
          random=list(id=pdBlocked(list(~1, pdCompSymm(~Xw1-1), pdCompSymm(~Xw2-1)))),
          method="ML", data=d2))


## @knitr unnamed-chunk-34
anova(lmer(Y ~ Xb1*Xb2*Xw1*Xw2 + (1|id) + (1|Xw1:id) + (1|Xw2:id), data=d2))


## @knitr unnamed-chunk-35
try(detach(package:lme4))
try(detach(package:nlme))
try(detach(package:Matrix))
try(detach(package:lattice))


