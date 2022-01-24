
<!-- README.md is generated from README.Rmd. Please edit that file -->

# happign <a href="https://paul-carteron.github.io/happign/"><img src="man/figures/logo.png" align="right" height="139" /></a>

# happign - IGN API for R

<!-- badges: start -->

[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/happign)](https://cran.r-project.org/package=happign)
[![R-CMD-check](https://github.com/paul-carteron/happign/workflows/R-CMD-check/badge.svg)](https://github.com/paul-carteron/happign/actions)
[![license](https://img.shields.io/badge/license-GPL--3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.en.html)
[![Codecov test
coverage](https://codecov.io/gh/paul-carteron/happign/branch/main/graph/badge.svg)](https://app.codecov.io/gh/paul-carteron/happign?branch=main)
<!-- badges: end -->

The goal of happign is to facilitate the use of Application Programming
Interface from the French National Institute of Geographic and Forestry
Information to retrieve their free ressources. `happign` allow
downloading of :

-   Shapefile via use of WFS service
-   Raster via use of WMS raster service

### Installation

You can install the released version of happign from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("happign")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("paul-carteron/happign")
```

### Vignettes

-   Package vignettes :
    [first](https://paul-carteron.github.io/happign/articles/Getting_started.html),
    [second](https://paul-carteron.github.io/happign/articles/Non_functional_APIs.html)

### Future features

IGN offers other services. Their implementation in R is under
development :

-   Calculation of isochron and isodistance
-   Routing calculation
-   REST API Carto compatible with the OpenAPI specification (easy and
    quick downloading for WFS)

### Problems and Issues

-   Please report any issues or bugs you may encounter on the [dedicated
    page on github](https://github.com/paul-carteron/happign/issues).

### System Requirements

`happign` requires [`R`](https://cran.r-project.org) v \>= 4.1.0.

### Code of Conduct

Please note that the happign project is released with a [Contributor
Code of
Conduct](https://paul-carteron.github.io/happign/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
