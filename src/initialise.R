#purpose of script - initialise project with defined parameters
version_number <- 2.5

paste("Version", version_number, "of the course catalogue scraping project. Please see Readme for more details.")

# Setting this to TRUE disables the cache comparison feature
status_override <- TRUE

library(ProjectTemplate)
load.project(load_libraries = TRUE,
             libraries = c("plyr, dplyr, rvest, selectr, xml2, stringr, jsonlite, tidyr, purrr, httr,
                           httpuv, rlist, gmailr"),
             munging = TRUE
             )



"script runs without asking for gmailr authentication. however cronr isn't playing
ball. need to crack this to automate"

"Email scripts are 5 & 18"