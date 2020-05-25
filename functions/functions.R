#purpose of script: house all required functions for workflow



#######################01_scrape_repo_names.R############extract_last_page_number#########################
#########################01_scrape_repo_names.R############extract_last_page_number#########################
#########################01_scrape_repo_names.R############extract_last_page_number#########################



get_last_page <- function(html) {
  
  #extract all href attributes on search result page
  
  search_result_links <- html %>% read_html() %>% html_nodes("a") %>% html_text()
  
  #node of interest here is node 82. Positive indexing will change dependent upon number of pages
  #but negative indexing should be correct regardless of number of pages in search return
  
  #need to subtract from length of the character vector,as negative indexing not playing ball
  search_result_links[(length(search_result_links)-16)] %>% 
    #take the raw string
    unname() %>% 
    #convert to a number %>% 
    as.numeric()
  
}


#########################01_scrape_repo_names.R############generate_urls#########################
#########################01_scrape_repo_names.R############generate_urls#########################
#########################01_scrape_repo_names.R############generate_urls#########################



generate_urls <- function(url_suffix){
  
  valid_urls <- str_c(url_prefix, 1:last_page, url_suffix)
  

}



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
  
  #cleanse the links. First step- remove all search links
  cleansed_hrefs <- hrefs[!grepl("search", hrefs)]
  
  #these links include an assortment of unrelated links. Filter only to relevant:
  course_repo_names <- cleansed_hrefs[grepl("datasciencecampus", cleansed_hrefs)]
  course_repo_names
}



#########################02_scrape_last_updated.R############extract_mr3#########################
#########################02_scrape_last_updated.R############extract_mr3#########################
#########################02_scrape_last_updated.R############extract_mr3#########################




#applicable function for extracting cleansed 'mr3' xpath

extract_mr3 <- function(urls) {
  #parse search page
  mr3s <-  urls %>%
    read_html() %>% 
    #extract all mr3 xpaths
    xml_find_all(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "mr-3", " " ))]') %>% 
    #extract all text
    html_text() 
  
  #subset this text by strings containing "updated"
  updated_mr3 <- mr3s[grep("Updated", mr3s)]
  
  #remove the standard tag format
  mr3_cleansed <- str_remove(updated_mr3, "\n            Updated ")
  
  mr3_cleansed
  
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

