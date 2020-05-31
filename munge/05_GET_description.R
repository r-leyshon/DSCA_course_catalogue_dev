#purpose of script: extract description. I believe this is the description created along with
#initial repo setup. Will call repo_description in output dataframe.


#select all repo_descriptions
all_descriptions <- list.select(req_content, description)


#store as character vector for cbind.fill
description_character <- purrr::map(all_descriptions, as.character) %>% unlist()

#cbind back to output_dataframe
output_dataframe <- as.data.frame(cbind.fill(output_dataframe, description_character))

#rename column
colnames(output_dataframe)[6] <- "repo_description"


#only print if course repo is NA or "NULL"
if (any(is.na(output_dataframe[, 6]) | output_dataframe[, 6] == "NULL")) {
  
  print(paste("There is no repo description available for: ",
              output_dataframe$course_repo_names[is.na(output_dataframe[, 6]) | output_dataframe[, 6] == "NULL"]
  ))
  
}






remove(list = c('all_descriptions',
                'description_character'
                ))

