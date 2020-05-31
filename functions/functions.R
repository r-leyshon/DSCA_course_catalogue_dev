#purpose of script: house all required functions for workflow


#########################01_scrape_repo_names.R############extract_repo_names#########################
#########################01_scrape_repo_names.R############extract_repo_names#########################
#########################01_scrape_repo_names.R############extract_repo_names#########################



extract_repo_names <- function(urls) {
  
  #parse search page
  hrefs <-  urls %>% read_html() %>%
    #extract all 'a' nodes
    html_nodes("a") %>%
    #extract all href links
    html_attr('href')
  
  #filter only links with 2 "/" occurences
  repo_names_counted <- unique(hrefs[str_count(hrefs, "/") == 2])
  
  #filter these links to datasciencecampus repo name
  course_repo_names <- repo_names_counted[grepl("/datasciencecampus/", repo_names_counted)]

  
  course_repo_names
}


#########################01_scrape_repo_names.R############cbind.fill#########################
#########################01_scrape_repo_names.R############cbind.fill#########################
#########################01_scrape_repo_names.R############cbind.fill#########################


#cbind fill alternative as rowr package removed from CRAN 


cbind.fill <- function(...){
  nm <- list(...) 
  nm <- lapply(nm, as.matrix)
  n <- max(sapply(nm, nrow)) 
  do.call(cbind, lapply(nm, function (x) 
    rbind(x, matrix(, n-nrow(x), ncol(x))))) 
}


#########################04_scrape_course_names.R############extract_course_name#########################
#########################04_scrape_course_names.R############extract_course_name#########################
#########################04_scrape_course_names.R############extract_course_name#########################

#function to extract course titles from course pages. used in munge script 03.

extract_course_name <- function(pages) {
  
  #assign the output of the function with trycatch to deal with any course that doesn't have a readme
  function_output <- tryCatch(
    
    #course title extracted from 2nd h1 xpath. This is the try.
    {html_text(xml_find_all(pages, xpath = "//h1")[2])},
    
    #catch errors when readme is not available and assign a placeholder string
    error = function(cond) {
      message("Readme header does not appear to exist for course")

      message("Course title not extracted. Check 'output_dataframe' for clarification")
      # Return value in case of error
      return("No readme header is present.")
    }
    )
  #return output with course titles or placeholder string in cases where errors run
  return(function_output)
  course_title
  
}


#########################06_scrape_course_desc.R############extract_course_desc#########################
#########################06_scrape_course_desc.R############extract_course_desc#########################
#########################06_scrape_course_desc.R############extract_course_desc#########################


extract_course_description <- function(pages){
  
  #assign parsed page
  paragraph_nodes <- pages %>% html_nodes("p") %>% html_text()
  
  #extract content of interest
  uncleansed_text <- paragraph_nodes[12:length(paragraph_nodes)]
  
  #replace all "\n" with a space
  cleansed_text <- str_replace_all(uncleansed_text, "\n", " ")
  
}

