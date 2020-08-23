"function of script: scrape course version number"

# iterate over the parsed_course_pages list to extract course version numbers
course_version_list <- lapply(parsed_course_pages, FUN = extract_version)

# This point would be a good opportunity to filter out any rows that represent
# repos that have not adopted standardised format.
parsed_course_pages <- parsed_course_pages[!is.na(course_version_list)]


# unlist to a numeric vector
course_versions_vector <- unlist(course_version_list)

print(paste("Course versions assigned: ", course_versions_vector))


# assign numeric vector to new column
output_dataframe$version_number <- course_versions_vector
# now also need to remove df rows where version no. is NA
output_dataframe <- output_dataframe %>% filter(!is.na(version_number))


remove(list = c(
  "course_version_list",
  "course_versions_vector",
  "extract_version"
))
