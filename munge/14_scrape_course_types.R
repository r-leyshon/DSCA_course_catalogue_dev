# purpose of script: scrape readme lists, extract & assign course type


# apply the function to extract course descriptions from the parsed course list
course_type_list <- lapply(parsed_course_pages, FUN = extract_course_type)

# rbind the list elements
course_types <- list.rbind(course_type_list)

# save as a column in dataframe
output_dataframe$course_types <- course_types



remove(
  list = "extract_course_type",
  "course_types",
  "course_type_list"
)
