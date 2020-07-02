"function of script: scrape course version number"

#iterate over the parsed_course_pages list and extract the course version numbers

course_version_list <- lapply(parsed_course_pages, FUN = extract_version)


#unlist to a numeric vector
course_versions_vector <- unlist(course_version_list)

print(paste("Course versions assigned: ", course_versions_vector))


#assign numeric vector to new column
output_dataframe$version_number <- course_versions_vector



"Need to store the number of courses for decision on whether to execute script later"

newstate_ncourses <- nrow(output_dataframe)



"Also need to create a concatenation of course name & version number to compare against 
previous caches"

newstate_course_versions <- paste(output_dataframe$readme_title, output_dataframe$version_number,
                                  sep = "-")



remove(list = c('course_version_list', 'course_versions_vector', 'extract_version'))




