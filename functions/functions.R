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


#########################03_scrape_course_names.R############extract_course_name#########################
#########################03_scrape_course_names.R############extract_course_name#########################
#########################03_scrape_course_names.R############extract_course_name#########################

#function to extract course titles from course pages. used in munge script 03.

extract_course_name <- function(pages) {
  
  #assign the output of the function with trycatch to deal with any course that doesn't have a readme
  function_output <- tryCatch(
    
    #course title extracted from 2nd h1 xpath. This is the try.
    {html_text(xml_find_all(pages, xpath = "//h1")[2])},
    
    #catch errors when readme is not available and assign a placeholder string
    error = function(cond) {
      base::message("Readme header does not appear to exist for course")

      base::message("Course title not extracted. Check 'output_dataframe' for clarification")
      # Return value in case of error
      return("No readme header is present.")
    }
    )
  #return output with course titles or placeholder string in cases where errors run
  return(function_output)
  
}


#########################04_extract_version.R############extract_version#########################
#########################04_extract_version.R############extract_version#########################
#########################04_extract_version.R############extract_version#########################

#function to extract course titles from course pages. used in munge script 03.



extract_version <- function(pages) {
  
  #assign the output of the function with trycatch to deal with any course that doesn't have a readme
  function_output <- tryCatch(
    
    #course title extracted from 2nd h3 xpath. This is the try.
    {html_text(xml_find_all(pages, xpath = "//h3")[2]) %>%
        #lower the text
        tolower() %>% 
        #remove version text
        str_remove("version ") %>% 
        #convert to numeric
        as.numeric()
      },
    
    #catch errors when readme is not available and assign NA
    error = function(cond) {
      base::message("Version number does not appear to exist for course")
      
      base::message("Course version number not extracted. Check 'output_dataframe' for clarification")
      # Return NA in case of error
      return(NA)
    }
  )
  #return output with course titles or placeholder string in cases where errors run
  return(function_output)
  
}




#########################05_scrape_readme_text.R############extract_course_desc#########################
#########################05_scrape_readme_text.R############extract_course_desc#########################
#########################05_scrape_readme_text.R############extract_course_desc#########################


extract_course_description <- function(pages){
  
  #assign parsed page
  paragraph_nodes <- pages %>% html_nodes("p") %>% html_text()
  
  #extract content of interest
  uncleansed_text <- paragraph_nodes[12:length(paragraph_nodes)]
  
  #replace all "\n" with a space
  cleansed_text <- str_replace_all(uncleansed_text, "\n", " ")
  
}


#########################11_scrape_readme_listnodes.R############extract_course_type#########################
#########################11_scrape_readme_listnodes.R############extract_course_type#########################
#########################11_scrape_readme_listnodes.R############extract_course_type#########################


extract_course_type <- function(pages){
  
  list_text <- pages %>% html_nodes("li") %>% html_text()
  
  #lower for pattern matching
  lowered_list_text <- list_text %>% tolower()
  
  #subset this character vector by:
  #start - find the first node containing e learning
  #find first index
  start_index <- grep("e learning", lowered_list_text)[length(grep("e learning", lowered_list_text))]
  
  #find end index containing face to face
  end_index <- grep("face to face", lowered_list_text)[length(grep("face to face", lowered_list_text))]
  
  
  #need to cover missing course types here
  if (length(start_index) == 0 | length(end_index) == 0){
    course_type <- "No course type detected"
  } else {
    
    #subset the character vector by these indices
    user_generated_li <- list_text[start_index:end_index]
    
    #pull the last 3 elements for course type 
    course_type_test <- paste(tail(user_generated_li, 3), collapse = "; ")
    
    #if any of these patterns are detected, assign the value to course type
    if (grepl("E learning", course_type_test) |
        grepl("Self learning", course_type_test) |
        grepl("Face to face", course_type_test)
    ){
      course_type <- course_type_test
    } else {
      #otherwise use placeholder text
      course_type <- "No course type found"
      
    }
  }
  
  return(course_type)
  
} #end of function



#########################12_scrape_lo_detail.R############extract_lo_detail#########################
#########################12_scrape_lo_detail.R############extract_lo_detail#########################
#########################12_scrape_lo_detail.R############extract_lo_detail#########################

#pages <- parsed_course_pages[[11]]

extract_lo_detail <- function(pages){
  
  list_text <- pages %>% html_nodes("li") %>% html_text()
  
  #lower for pattern matching
  lowered_list_text <- list_text %>% tolower()
  
  #subset this character vector by:
  #start  - the last text value that contains "\n                  tags" plus one
  #end - the first value that contains 'Github, Inc.' minus one
  #find first index
  start_index <- grep("\n                  tags", lowered_list_text)[length(grep("\n                  tags", lowered_list_text))] + 1
  
  #find end index
  end_index <- grep("github, inc.", lowered_list_text)[1] - 1
  
  #in the case of missing readmes, the above method of finding indexes can result in an end_index smaller
  #than start_index. Check for this condition and assign a placeholder
  
  if (start_index <= end_index){
    
    #subset the character vector by these indices
    user_generated_li <- list_text[start_index:end_index]
  } else {
    lo_detail <- "No readme found"
    return(lo_detail)
    next
  }
  
  
  #pull any list object that does not match a course type 
  lo_detail_test <- paste(user_generated_li[!(grepl("E learning", user_generated_li) |
                                                grepl("Self learning", user_generated_li) |
                                                grepl("Face to face", user_generated_li) |
                                                grepl("%\n", user_generated_li))], collapse = "; ")
  #some readme lists have \n linebreaks while others don't. Cleanse if present.
  lo_detail_test <- str_replace_all(lo_detail_test, "\n", " ")
  
  lo_detail <- lo_detail_test
  
  
  return(lo_detail)
  
} #end of function

