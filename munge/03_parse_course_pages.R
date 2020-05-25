"function of script: parse all course pages to xml and store for further processing scripts"

#base url string, to be combined with repo name url string:
github <- "https://github.com"




#construct course page with html parameters extracted from 01. repo_names script
course_pages <- paste0(github, course_repo_names)
#str(course_pages)
#character vector

#save these links as course names within the output dataframe
output_dataframe$course_location <- course_pages





#parse and store all course pages as a nested list object

parsed_course_pages <- lapply(course_pages, read_html)
  

#remove defunct objects
remove(list = c('github', 'course_pages', 'course_repo_names'))

