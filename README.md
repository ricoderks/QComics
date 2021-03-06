
<!-- README.md is generated from README.Rmd. Please edit that file -->

# QComics

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![Codecov test
coverage](https://codecov.io/gh/ricoderks/QComics/branch/main/graph/badge.svg)](https://app.codecov.io/gh/ricoderks/QComics?branch=main)
<!-- badges: end -->

The goal of the `QComics` package is to have a quick overview of the
quality of a metabolomics or lipidomics study. For this, a pooled sample
(QCpool) needs to measured in regular intervals during one or more
sequences. These QCpool samples need to be analysed with Sciex
Multiquant (> v3.0.3) software and exported to `txt` format.

## Installation

You can install the development version of QComics like so:

``` r
remotes::install_github("ricoderks/QComics")
```

## Usage

### Locally

From Rstudio run the app as:

``` r
QComics::run_app()
```

or if you want the app to run in the browser use:

``` r
QComics::run_in_browser()
```

### Shiny server

To run it from a shiny server you have to make sure the package is
installed and then you only have to create a file called `app.R` in the
folder where you want to run it from. The file `app.R` should only
contain:

``` r
QComics::run_app()
```
