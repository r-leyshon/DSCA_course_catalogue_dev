#purpose of script: extract logical for has_wiki


#select all repo_descriptions
all_ssh_url <- list.select(req_content, ssh_url)


#store as character vector for cbind.fill
ssh_character <- purrr::map(all_ssh_url, as.character) %>% unlist()

#cbind back to output_dataframe
output_dataframe <- as.data.frame(cbind.fill(output_dataframe, ssh_character))

#rename column
colnames(output_dataframe)[20] <- "ssh_url_address"


#only print if has issues is NA or "NULL"
if (any(is.na(output_dataframe[, 20]) | output_dataframe[, 20] == "NULL")) {
  
  print(paste("There is no available ssh address for: ",
              output_dataframe$course_repo_names[is.na(output_dataframe[, 20]) | output_dataframe[, 20] == "NULL"]
  ))
  
}



remove(list = c('all_ssh_url',
                'ssh_character'
                ))

