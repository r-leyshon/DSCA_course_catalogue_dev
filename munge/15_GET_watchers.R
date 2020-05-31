#purpose of script: extract logical for has_wiki


#select all repo_descriptions
all_watchers <- list.select(req_content, watchers)


#store as character vector for cbind.fill
watchers_integer <- purrr::map(all_watchers, as.integer) %>% unlist()

#cbind back to output_dataframe
output_dataframe <- as.data.frame(cbind.fill(output_dataframe, watchers_integer))

#rename column
colnames(output_dataframe)[16] <- "watcher_count"


#only print if has issues is NA or "NULL"
if (any(is.na(output_dataframe[, 16]) | output_dataframe[, 16] == "NULL")) {
  
  print(paste("There is no available count of watchers for: ",
              output_dataframe$course_repo_names[is.na(output_dataframe[, 16]) | output_dataframe[, 16] == "NULL"]
  ))
  
}



remove(list = c('all_watchers',
                'watchers_integer'
                ))

