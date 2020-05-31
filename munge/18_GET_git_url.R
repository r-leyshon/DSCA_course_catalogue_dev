#purpose of script: extract logical for has_wiki


#select all repo_descriptions
all_git_url <- list.select(req_content, git_url)


#store as character vector for cbind.fill
git_character <- purrr::map(all_git_url, as.character) %>% unlist()

#cbind back to output_dataframe
output_dataframe <- as.data.frame(cbind.fill(output_dataframe, git_character))

#rename column
colnames(output_dataframe)[19] <- "git_url_address"


#only print if has issues is NA or "NULL"
if (any(is.na(output_dataframe[, 19]) | output_dataframe[, 19] == "NULL")) {
  
  print(paste("There is no available git url address for: ",
              output_dataframe$course_repo_names[is.na(output_dataframe[, 19]) | output_dataframe[, 19] == "NULL"]
  ))
  
}



remove(list = c('all_git_url',
                'git_character'
                ))

