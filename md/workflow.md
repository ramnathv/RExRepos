Workflow: Reproducible blog posts using R
=========================

Write R markdown
-------------------------

To get started with writing R markdown documents, have a look at

 - [R markdown](http://www.rstudio.org/docs/r_markdown): text formatting with integrated [R](http://www.r-project.org/) commands
 - R package [knitr](http://yihui.name/knitr/) from Yihui Xie: convert R markdown to markdown
 - R package [markdown](http://cran.r-project.org/package=markdown): convert markdown to html (alternative: [pandoc](http://johnmacfarlane.net/pandoc/))
 - Integrated development environment [RStudio](http://www.rstudio.org/): great support for knitr and markdown
 - [A good introduction](http://jeromyanglim.blogspot.de/2012/05/getting-started-with-r-markdown-knitr.html) from Jeromy Anglim
 - [A good introduction](http://www.rstudio.org/docs/authoring/using_markdown) from the RStudio folks

I use these knitr chunk options for my posts:


    opts_chunk$set(tidy=FALSE, message=FALSE, warning=FALSE, comment="")


When using the markdown package outside of RStudio, I have problems with german umlauts when transforming markdown documents to html. Using RStudio's built-in markdown support gets rid of this issue.

Set up R and WordPress
-------------------------

For blogging from R to WP, I recommend:

 - [SyntaxHighlighter](http://wordpress.org/extend/plugins/syntaxhighlighter/) plugin for WordPress for code boxes with R syntax highlighting
 - [MathJax](http://wordpress.org/extend/plugins/mathjax-latex/) plugin for WordPress for nice math rendering using $\LaTeX$ syntax
 - [RWordPress](http://www.omegahat.org/RWordPress/) R package for uploading posts from R to WP

You will need to build RWordPress yourself, even on Windows. RWordPress depends on the packages RCurl, XML, and XMLRPC, which are available as Windows binary packages from [Prof. Ripley's site](http://www.stats.ox.ac.uk/pub/RWin/bin/windows/contrib/2.15/). On Linux, all build tools should already be installed, on Windows, download `Rtools<version>.exe` and follow instructions from [Building R for Windows](http://cran.r-project.org/bin/windows/Rtools/). Then build and install RWordPress:


    install.packages("RWordPress", repos="http://www.omegahat.org/R", build=TRUE)


Set up RWordPress with your login credentials and the site URL.


    library(RWordPress)
    options(WordpressLogin=c(user="password"),
            WordpressURL="http://your_wp_installation.org/xmlrpc.php")


To make syntax highlighting work in WP with the [SyntaxHighlighter](http://wordpress.org/extend/plugins/syntaxhighlighter/) plugin, R code should be enclosed in WP-shortcode instead of the knitr html output default `<pre><code class="r">...</code></pre>` like so:

```
[code lang='r']...[/code]
```

One option is to set up knitr itself to wrap code into WP-shortcode format. The downside to this option is that the output html is only usable within WP, but not as standalone html page. Adapted from [Carl Boettiger](http://www.carlboettiger.info/wordpress/archives/3974):

<!--
knit_patterns$set(chunk.begin = '^\\[code lang="r", (.*)\\]',
chunk.end = '^\\[/code\\]')

I did not test them, though. There are patterns for other elements
such as inline R code; if you just want to borrow the syntax for HTML,
you can first

knit_patterns$set(all_patterns$html) 
-->


    knit_hooks$set(output=function(x, options) paste("\\[code\\]\n", x, "\\[/code\\]\n", sep=""))
    knit_hooks$set(source=function(x, options) paste("\\[code lang='r'\\]\n", x, "\\[/code\\]\n", sep=""))


As an alternative, you can use the XML package to extract the html body produced by knitr and clean it to make it work for WordPress. Adapted with small modifications from [William K. Morris](http://wkmor1.wordpress.com/2012/07/01/rchievement-of-the-day-3-bloggin-from-r-14/):


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


Send the post from R to WordPress
-------------------------

In WP, you have to enable the "XML-RPC" option in Settings -> Writing -> Remote Publishing.

In R, first set the working directory to the one containing the html page. Then use `newPost(..., publish=FALSE)` to stage the post in WP as a draft to actually publish later from the dashboard. This uses `knit2wp()` as defined above:


    newPost(list(description=knit2wp('workflow.html'),
                 title='Workflow: Post R markdown to WordPress',
                 categories=c('R'),
                 mt_keywords=c('WordPress', 'publish')),
            publish=FALSE)


For me, this works only if I perform some strange WP vodoo (that I don't understand). I need to make sure the draft is opened first with the WP html editor, not the visual editor. So the html editor has to be "active", i.e., was used last. After openening the draft with the html editor, I have to switch to the visual editor,and then hit "publish". Publishing the post while still in the html editor does not work. Further switching between visual and html editor messes everything up.

Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/workflow.Rmd) | [markdown](https://github.com/dwoll/RExRepos/raw/master/md/workflow.md) | [R code](https://github.com/dwoll/RExRepos/raw/master/R/workflow.R) - ([all posts](https://github.com/dwoll/RExRepos))