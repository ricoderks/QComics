# Building a Prod-Ready, Robust Shiny Application.
# 
# README: each step of the dev files is optional, and you don't have to 
# fill every dev scripts before getting started. 
# 01_start.R should be filled at start. 
# 02_dev.R should be used to keep track of your development during the project.
# 03_deploy.R should be used once you need to deploy your app.
# 
# 
###################################
#### CURRENT FILE: DEV SCRIPT #####
###################################

# Engineering

## Dependencies ----
## Add one line by package you want to add as dependency
usethis::use_package( "utils" )
usethis::use_package( "dplyr" )
usethis::use_dev_package( "ggCPM",
                          remote = "ricoderks/ggCPM" )
usethis::use_package( "sessioninfo" )
usethis::use_package( "rlang" )
usethis::use_package( "readr" )
usethis::use_package( "dplyr" )
usethis::use_package( "magrittr" )
usethis::use_package( "stringr" )
usethis::use_package( "tidyr" )
usethis::use_package( "stats" )
usethis::use_package( "forcats" )
usethis::use_package( "ggplot2" )
usethis::use_package( "rmarkdown" )

## Add modules ----
## Create a module infrastructure in R/
golem::add_module( name = "help" ) # help section
golem::add_module( name = "about" ) # about section
golem::add_module( name = "files" ) # files section
golem::add_module( name = "report" ) # report section
golem::add_module( name = "raw_data" ) # raw-data section
golem::add_module( name = "meta_data" ) # meta-data section
golem::add_module( name = "qc_tables" ) # QC overview tables
golem::add_module( name = "qc_graphs" ) # QC overview graphs

## Add helper functions ----
## Creates fct_* and utils_*
golem::add_fct( "files" )
golem::add_fct( "raw_data" )
golem::add_fct( "qc_tables" )
golem::add_fct( "qc_graphs" )
# golem::add_utils( "helpers" )

## External resources
## Creates .js and .css files at inst/app/www
# golem::add_js_file( "script" )
# golem::add_js_handler( "handlers" )
# golem::add_css_file( "custom" )

## Add internal datasets ----
## If you have data in your package
# usethis::use_data_raw( name = "my_dataset", open = FALSE ) 

## Tests ----
## Add one line by test you want to create
usethis::use_test( "meta_data" ) # tests for reading meta data
usethis::use_test( "mq_data" ) # tests for reading mq data
usethis::use_test( "merge_data" ) # test for merging data
usethis::use_test( "qc_calc" ) # test for the qc calculations
usethis::use_test( "qc_table" ) # test for creating the qc tables

# Documentation

## Vignette ----
# usethis::use_vignette("QComics")
# devtools::build_vignettes()

## Code Coverage----
## Set the code coverage service ("codecov" or "coveralls")
usethis::use_coverage()

# Create a summary readme for the testthat subdirectory
# covrpage::covrpage()

## CI ----
## Use this part of the script if you need to set up a CI
## service for your application
## 
## (You'll need GitHub there)
# usethis::use_github()

# GitHub Actions
# usethis::use_github_action() 
# Chose one of the three
# See https://usethis.r-lib.org/reference/use_github_action.html
# usethis::use_github_action_check_release() 
# usethis::use_github_action_check_standard() 
# usethis::use_github_action_check_full() 
# Add action for PR
# usethis::use_github_action_pr_commands()

# Travis CI
# usethis::use_travis() 
# usethis::use_travis_badge() 

# AppVeyor 
# usethis::use_appveyor() 
# usethis::use_appveyor_badge()

# Circle CI
# usethis::use_circleci()
# usethis::use_circleci_badge()

# Jenkins
# usethis::use_jenkins()

# GitLab CI
# usethis::use_gitlab_ci()

# You're now set! ----
# go to dev/03_deploy.R
rstudioapi::navigateToFile("dev/03_deploy.R")

