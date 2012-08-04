
## @knitr unnamed-chunk-1
opts_knit$set(self.contained=FALSE)
opts_chunk$set(tidy=FALSE, message=FALSE, warning=FALSE, comment="")


## @knitr unnamed-chunk-2
dev.new(); dev.new(); dev.new()
dev.list()
dev.cur()
dev.set(3)
dev.set(dev.next())
dev.off()
graphics.off()


## @knitr unnamed-chunk-3
pdf("pdf_test.pdf")
plot(1:10, rnorm(10))
dev.off()


## @knitr unnamed-chunk-4
plot(1:10, rnorm(10))
dev.copy(jpeg, filename="copied.jpg", quality=90)
graphics.off()


