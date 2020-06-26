#purpose of script - initialise project with defined parameters
version_number <- 2.3

paste("Version", version_number, "of the course catalogue scraping project. Please see Readme for more details.")


library('ProjectTemplate')
load.project(load_libraries = TRUE,
             libraries = c("dplyr, plyr, rvest, selectr, xml2, stringr, jsonlite, tidyr, purrr, httr,
                           httpuv, rlist"),
             munging = TRUE
             )


