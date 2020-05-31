#purpose of script: extract logical for has_wiki


#select all repo_descriptions
all_clone_url <- list.select(req_content, clone_url)


#store as character vector for cbind.fill
clone_character <- purrr::map(all_clone_url, as.character) %>% unlist()

#cbind back to output_dataframe
output_dataframe <- as.data.frame(cbind.fill(output_dataframe, clone_character))

#rename column
colnames(output_dataframe)[21] <- "clone_url_address"


#only print if has issues is NA or "NULL"
if (any(is.na(output_dataframe[, 21]) | output_dataframe[, 21] == "NULL")) {
  
  print(paste("There is no available clone url address for: ",
              output_dataframe$course_repo_names[is.na(output_dataframe[, 21]) | output_dataframe[, 21] == "NULL"]
  ))
  
}



remove(list = c('all_clone_url',
                'clone_character'
                ))

