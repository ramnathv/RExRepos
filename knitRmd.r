####----------------------------------------------------------------------------
## knit all Rmd files to html
## first set the R working directory to the one containing this script
## setwd("c:/path/to/this/script")
####----------------------------------------------------------------------------

RmdPath  <- paste(getwd(), "/Rmd", sep="")
RmdFiles <- list.files(RmdPath, pattern="Rmd", full.names=TRUE)
setwd(RmdPath)

library(knitr)
library(markdown)

## set some knitr options
# opts_knit$set(self.contained=FALSE)
# render_markdown(strict=TRUE)
# render_jekyll()
# opts_chunk$set(tidy=FALSE, message=FALSE, warning=FALSE, comment="")

sapply(RmdPath, knit2html)
sapply(RmdPath, purl)
