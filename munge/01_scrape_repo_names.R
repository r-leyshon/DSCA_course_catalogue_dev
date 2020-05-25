#purpose of script:

"Scrape data from online github DSC repo. This script handles course titles"


source('functions/functions.R')

#search result used, parameter to specify contains 'DSCA' but not 'dev'
search_result <- "https://github.com/search?q=org%3Adatasciencecampus+DSCA++NOT+_dev&type=Repositories" #public repos
url_prefix <- 'https://github.com/search?p='
url_suffix <- '&q=org%3Adatasciencecampus+DSCA++NOT+_dev&type=Repositories' # public repos


################working here######################
################working here######################
################working here######################

# "Attempt to get the course page urls from the github esarch api (up to 1000 results).
# May also be good for the author / contributors."
# 
# source('git_ignore/api_credentials.R')
# 
# # Get OAuth credentials
# github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
# 
# # Use API
# gtoken <- config(token = github_token)
# req <- GET("https://api.github.com/users/r-leyshon/repos", gtoken)
# 
# #authenticated rate limit is up to 5,000 requests per hour
# Sys.sleep(0.7)
# 
# # Take action on http error
# stop_for_status(req)
# 
# # Extract content from a request
# json1 = content(req)
# 
# # Convert to a data.frame
# gitDF = jsonlite::fromJSON(jsonlite::toJSON(json1))
# class(gitDF)
# 
# # Subset data.frame
# gitDF[gitDF$full_name == "jtleek/datasharing", "created_at"] 
# 
# 
# 
# 
# 
# ###################search api#####################
# 
# "30 requests per minute"
# #curl https://api.github.com/search/users?q=tom+repos:%3E42+followers:%3E1000
# #https://github.com/search?q=org%3Adatasciencecampus+DSCA++NOT+_dev&type=Repositories
# gtoken <- config(token = github_token)
# 
# req <- GET('https://api.github.com/search/users?q=datasciencecampus',
#            gtoken,
#            user_agent('leyshonrr@hotmail.co.uk  testing access to search api'))
# 
# req_content <- content(req)
# 
# Sys.sleep(1)
# 
# #From the above content:
# "https://api.github.com/users/datasciencecampus"
# 
# req <- GET("https://api.github.com/users/datasciencecampus",
#            gtoken,
#            user_agent('richard.leyshon@ons.gov.uk  extracting repo metadata from employer organisation')
# )
# 
# req_content <- content(req)
# 
# 
# #repo content
# 
# request_result <- GET("https://api.github.com/users/datasciencecampus/repos",
#            gtoken,
#            user_agent('richard.leyshon@ons.gov.uk  extracting repo metadata from employer organisation')
# )
# 
# # Check request_result
# if(http_error(request_result)){
#   warning("The request failed")
# } else {
#   req_content <- content(request_result)
# }
# 
# class(req_content)
# 
# writeLines(content(request_result, as = "text"))
# 
# content(request_result, as = "text")
# 
# 
# test <- content(request_result, max.level = 4)
# "html_url pull these nodes to generate addresses for all open repos?"
# 
# test1 <- list.select(req_content, html_url)
# 
# 
# test2 <- list.stack(list.select(req_content, html_url))
# 
# "This method has identified 30 open rep addresses that could be used to build the address links object.
# Consider using this method for identification as avoids the issue with identifying last page"




#need a generalised method for identifying last page in search result
# test_url <- 'https://github.com/search?p=1&q=org%3Adatasciencecampus+DSCA++NOT+_dev&type=Repositories'
# 
# read_html(test_url) %>% html_nodes(".next_page") %>% html_attrs() %>% unlist()
# 
# 
# test_url <- 'https://github.com/search?p=2&q=org%3Adatasciencecampus+DSCA++NOT+_dev&type=Repositories'
# 
# read_html(test_url) %>%
#   html_nodes(".next_page") %>%
#   html_attrs() %>%
#   unlist() %>% 
#   str_detect("disabled") %>% 
#   any()
# 
# check_urls <- str_c(url_prefix, 1:10, url_suffix)
# 
# get_last_page <- function(urls_to_check){
# if(read_html(urls_to_check) %>%
#    html_nodes(".next_page") %>%
#    html_attrs() %>%
#    unlist() %>%
#    str_detect("disabled") %>%
#    any()
# ) {
#   urls_to_check
# } else {
#   
#   print("stopped")
# }
#   
# }
# 
# 
# 
# lapply(check_urls, get_last_page)
# 
# 
# "need to create a loop that continues until it meets a false case and then outputs
# that iteration's element"

################working here######################
################working here######################
################working here######################


#use function to extract the last page from the search result as numeric
last_page <- get_last_page(search_result)

"hard code all_pages object until generalised method identified"
last_page <- 2

print(paste("Total number of pages in search result: ", last_page))




# #generalised function for generating urls to scrape search result pages  
all_pages <- generate_urls(url_suffix)



paste("Page URL to scrape links from: ", all_pages)


#extract all course repo names from all_pages url vector
course_repo_names <- lapply(all_pages, extract_repo_names) %>% unlist()

#need a generalised function to use in lapply. 

# verification messages to console
print(
  paste("There are", length(course_repo_names), "courses found. Here are the repo names: ")
)

#messages to console
print(paste(course_repo_names))

output_dataframe <- data.frame(course_repo_names)


output_dataframe$course_repo_names <- str_remove(output_dataframe$course_repo_names, "/datasciencecampus/")


#remove the defunct objects
remove(list = c(
                'search_result',
                'url_prefix',
                'url_suffix',
                'last_page',
                'get_last_page',
                'extract_repo_names',
                'generate_urls')
       )
