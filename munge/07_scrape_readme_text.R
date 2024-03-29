# purpose of script: scrape  readme paragraph text


# apply the function to extract course descriptions from the parsed course list
course_desc_list <- lapply(parsed_course_pages,
  FUN = extract_course_description
)

# extract the length of all elements in the course description list
n_obs <- sapply(course_desc_list, length)

# create a sequence based on the maximum number of observations
seq.max <- seq_len(max(n_obs))

# apply the subsetting function over each element in the list, using the seq.max
# to prevent recycling of variable vector length
description_matrix <- t(sapply(course_desc_list, "[", i = seq.max))


# This can then be cbind'ed to the output_dataframe.
output_dataframe <- cbind(output_dataframe, description_matrix)

# "Go back is not user created content so filter out"
output_dataframe[output_dataframe == "Go back"] <- NA



# put a prefix in front of all text columns present
colnames(output_dataframe)[(grep(
  "version_number",
  names(output_dataframe)
) + 1):ncol(
  output_dataframe
)] <- paste0(
  "Paragraph_",
  colnames(output_dataframe)[6:ncol(
    output_dataframe
  )]
)

remove(list = c(
  "course_desc_list",
  "n_obs",
  "seq.max",
  "description_matrix",
  "extract_course_description"
))

# print message highlighting all repos where there doesn't appear to be a readme
# description. only print if readmes are absent
if (any(is.na(output_dataframe[, 5]))) {
  print(paste(
    "There is no readme description available for: ",
    output_dataframe$course_repo_names[is.na(output_dataframe[, 5])]
  ))
}
