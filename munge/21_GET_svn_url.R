#purpose of script: extract logical for has_wiki


#select all repo_descriptions
all_svn_url <- list.select(req_content, svn_url)


#store as character vector for cbind.fill
svn_character <- purrr::map(all_svn_url, as.character) %>% unlist()

#cbind back to output_dataframe
output_dataframe <- as.data.frame(cbind.fill(output_dataframe, svn_character))

#rename column
colnames(output_dataframe)[22] <- "svn_url_address"


#only print if has issues is NA or "NULL"
if (any(is.na(output_dataframe[, 22]) | output_dataframe[, 22] == "NULL")) {
  
  print(paste("There is no available svn url address for: ",
              output_dataframe$course_repo_names[is.na(output_dataframe[, 22]) | output_dataframe[, 22] == "NULL"]
  ))
  
}



remove(list = c('all_svn_url',
                'svn_character',
                'req_content',
                'cbind.fill'
                ))

