#purpose of script: extract logical for has_wiki


#select all repo_descriptions
all_default_branch <- list.select(req_content, default_branch)


#store as character vector for cbind.fill
default_branch_character <- purrr::map(all_default_branch, as.character) %>% unlist()

#cbind back to output_dataframe
output_dataframe <- as.data.frame(cbind.fill(output_dataframe, default_branch_character))

#rename column
colnames(output_dataframe)[17] <- "default_branch_name"


#only print if has issues is NA or "NULL"
if (any(is.na(output_dataframe[, 17]) | output_dataframe[, 17] == "NULL")) {
  
  print(paste("There is no available default branch name for: ",
              output_dataframe$course_repo_names[is.na(output_dataframe[, 17]) | output_dataframe[, 17] == "NULL"]
  ))
  
}



remove(list = c('all_default_branch',
                'default_branch_character'
                ))

