## teaching

Materials for R trainings I've done.

* intro-R

    An R proof of concept, with self-contained examples for creating MS Word documents, HTML presentations and reports, mass producing documents and presentations, and creating web applications.

    If you are using R for the first time, you will need to download [R](https://mirrors.nics.utk.edu/cran/) and [RStudio](https://www.rstudio.com/products/rstudio/download2/), selecting the appropriate operating system (Windows/Mac) at each step.

    Once you have installed R and RStudio, you will need to install the following R packages to run the examples:
    
    * [readr](https://github.com/hadley/readr), a package for reading in tabular data
    * [tidyr](https://blog.rstudio.org/2014/07/22/introducing-tidyr/) and [dplyr](https://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html), packages for data wrangling
    * [leaflet](https://rstudio.github.io/leaflet/), a package for creating interactive maps
    * [ggplot2](http://ggplot2.org/), a package for creating graphics
    * [ggvis](http://ggvis.rstudio.com/), a package for creating interactive graphics
    * [googleVis](https://github.com/mages/googleVis), an R interface for the [Google Charts](https://developers.google.com/chart/) API
    * [shiny](http://shiny.rstudio.com/), a package for creating interactive web applications

    <br>

    You can do this by running the following code in the prompt:

    `install.packages(c("readr", "tidyr", "dplyr", "leaflet", "ggplot2", "ggvis", "googleVis", "shiny"))`

    Run each example by opening its .Rproj folder.
