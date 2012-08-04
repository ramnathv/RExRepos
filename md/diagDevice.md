Graphics devices: Opening and saving diagrams
=========================




TODO
-------------------------

 - add regions and margins
 - more device types and options
 - pdf: multiple pages

Opening and closing a device
-------------------------


    dev.new(); dev.new(); dev.new()
    dev.list()

    pdf pdf pdf pdf 
      2   3   4   5 

    dev.cur()

    pdf 
      5 

    dev.set(3)

    pdf 
      3 

    dev.set(dev.next())

    pdf 
      4 

    dev.off()

    pdf 
      5 

    graphics.off()


Saving plots to a graphics file
-------------------------


    pdf("pdf_test.pdf")
    plot(1:10, rnorm(10))
    dev.off()



    plot(1:10, rnorm(10))
    dev.copy(jpeg, filename="copied.jpg", quality=90)
    graphics.off()


Get this post from github
----------------------------------------------

[R markdown](https://github.com/dwoll/RExRepos/raw/master/Rmd/diagDevice.Rmd) | [markdown](https://github.com/dwoll/RExRepos/raw/master/md/diagDevice.md) | [R code](https://github.com/dwoll/RExRepos/raw/master/R/diagDevice.R) - ([all posts](https://github.com/dwoll/RExRepos))
