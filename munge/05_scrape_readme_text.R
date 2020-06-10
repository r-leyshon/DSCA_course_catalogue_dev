#purpose of script: scrape first readme paragraph as course description


#apply the function to extract course descriptions from the parsed course list
course_desc_list <- lapply(parsed_course_pages, FUN = extract_course_description)

#extract the length of all elements in the course description list
n.obs <- sapply(course_desc_list, length)

#create a sequence based on the maximum number of observations
seq.max <- seq_len(max(n.obs))

#apply the subsetting function over each element in the list, using the seq.max to prevent
#recycling of variable vector length
description_matrix <- t(sapply(course_desc_list, "[", i = seq.max))


#This can then be cbind'ed to the output_dataframe.
output_dataframe <- cbind(output_dataframe, description_matrix)

#"Go back is not user created content so filter out"

output_dataframe[output_dataframe == "Go back"] <- NA 








"Working here"




#put a prefix in front of all text columns present
colnames(output_dataframe)[5:ncol(output_dataframe)] <-  paste0("Paragraph_", colnames(output_dataframe)[5:ncol(output_dataframe)])




remove(list = c('course_desc_list',
                'n.obs',
                'seq.max',
                'description_matrix',
                'extract_course_description',
                'parsed_course_pages'))



#print message highlighting all repos where there doesn't appear to be a readme description

#only print if readmes are absent
if (any(is.na(output_dataframe[, 5]))) {

print(paste("There is no readme description available for: ",
      output_dataframe$course_repo_names[is.na(output_dataframe[, 5])]
      ))

}






