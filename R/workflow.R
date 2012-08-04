
## @knitr unnamed-chunk-1
opts_chunk$set(tidy=FALSE, message=FALSE, warning=FALSE, comment="")


## @knitr unnamed-chunk-2
install.packages("RWordPress", repos="http://www.omegahat.org/R", build=TRUE)


## @knitr unnamed-chunk-3
library(RWordPress)
options(WordpressLogin=c(user="password"),
        WordpressURL="http://your_wp_installation.org/xmlrpc.php")


## @knitr unnamed-chunk-4
knit_hooks$set(output=function(x, options) paste("\\[code\\]\n", x, "\\[/code\\]\n", sep=""))
knit_hooks$set(source=function(x, options) paste("\\[code lang='r'\\]\n", x, "\\[/code\\]\n", sep=""))


## @knitr unnamed-chunk-5
knit2wp <- function(file) {
    require(XML)
    content <- readLines(file)
    content <- htmlTreeParse(content, trim=FALSE)
    content <- paste(capture.output(print(content$children$html$children$body,
                                          indent=FALSE, tagSeparator="")),
                     collapse="\n")
    content <- gsub("<?.body>", "", content)
    content <- gsub("<?pre><code class=\"r\">", "\\[code lang='r'\\]\\\n",
                    content)
    content <- gsub("<?pre><code class=\"no-highlight\">", "\\[code\\]\\\n",
                    content)
    content <- gsub("<?pre><code>", "\\[code\\]\\\n", content)
    content <- gsub("<?/code></pre>", "\\[/code\\]\\\n", content)
    return(content)
}


## @knitr unnamed-chunk-6
newPost(list(description=knit2wp('workflow.html'),
             title='Workflow: Post R markdown to WordPress',
             categories=c('R'),
             mt_keywords=c('WordPress', 'publish')),
        publish=FALSE)


