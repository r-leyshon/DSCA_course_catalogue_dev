"function of script: scrape course readme titles"




# iterate over the parsed_course_pages list and extract the course titles

course_titles_list <- lapply(parsed_course_pages, FUN = extract_course_name)


# unlist to a character vector
course_titles_vector <- unlist(course_titles_list)

print(paste("Course title assigned: ", course_titles_vector))


# assign character vector to new column
output_dataframe$readme_title <- course_titles_vector


remove(list = c(
  "course_titles_list",
  "course_titles_vector",
  "extract_course_name"
))
