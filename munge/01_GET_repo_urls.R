#purpose of script:

"Scrape data from online github DSC repo. This script handles course titles"

#load custom functions
source('functions/functions.R')

#load Github API credentials file
source('git_ignore/api_credentials.R')

 # Get OAuth credentials
 github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

 # Use API
 gtoken <- config(token = github_token)
 
 ###################search api#####################

 "30 requests per minute"

 #request all repo content from datasciencecampus. Note that only public repos are detected.

 request_result <- GET("https://api.github.com/users/datasciencecampus/repos",
            gtoken,
            user_agent('richard.leyshon@ons.gov.uk  extracting repo metadata from employer organisation')
 )

 
 # Check request_result, print if error, extract content if none encountered
 if(http_error(request_result)){
   warning("The GET() request failed")
 } else {
   req_content <- content(request_result)
 }


#select all html_url items and stack as dataframe
 all_pages <- list.stack(list.select(req_content, html_url))

 "This method has identified 30 open rep addresses that could be used to build the address links object.
 Consider using this method for identification as avoids the issue with identifying last page"

#extract as a character vector
all_pages <- all_pages[,1]


print(paste("There are", length(all_pages),  "URLs to scrape link from: "))
print(all_pages)
 

#extract all course repo names from all_pages url vector
#must use unique as skeletor is appearing on two occasions for some reason, despite the skeletor
#public address not appearing in all_pages. 
course_repo_names <- unique(lapply(all_pages, extract_repo_names) %>% unlist(), fromLast = TRUE)


#cleanse the prefix from the repo name 
course_repo_names <- str_remove(course_repo_names, "/datasciencecampus/")

# verification messages to console
print(
   paste("There are", length(course_repo_names), "repos found. Here are the names: ")
)

#messages to console
print(paste(course_repo_names))

#initiate output dataframe
output_dataframe <- data.frame(course_repo_names)

#save these links as course names within the output dataframe
output_dataframe <- as.data.frame(cbind.fill(output_dataframe, all_pages))

#rename output_dataframe to site link

names(output_dataframe)[2] <- 'site_link'

#"In the case of missing course addresses for identified repo names (ref: skeletor-public), 
#we can construct the required url"

output_dataframe$site_link[is.na(output_dataframe$site_link)] <- paste0("https://github.com/datasciencecampus/", output_dataframe$course_repo_names[is.na(output_dataframe$site_link)])


#filter these urls to dsca rows only.
output_dataframe <- output_dataframe[grep("DSCA", output_dataframe$site_link), ]


#remove the defunct objects
remove(list = c(
                'extract_repo_names',
                'gtoken',
                'myapp',
                'request_result',
                'course_repo_names',
                'req_content')
       )
