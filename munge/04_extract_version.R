"function of script: scrape course version number"

#iterate over the parsed_course_pages list and extract the course version numbers

course_version_list <- lapply(parsed_course_pages, FUN = extract_version)


#unlist to a numeric vector
course_versions_vector <- unlist(course_version_list)

print(paste("Course versions assigned: ", course_versions_vector))


#assign numeric vector to new column
output_dataframe$version_number <- course_versions_vector


remove(list = c('course_version_list', 'course_versions_vector', 'extract_version'))




