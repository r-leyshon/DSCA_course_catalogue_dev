#purpose of script: extract logical for has_wiki


#select all repo_descriptions
all_stargazers <- list.select(req_content, stargazers_count)


#store as character vector for cbind.fill
stargazers_integer <- purrr::map(all_stargazers, as.integer) %>% unlist()

#cbind back to output_dataframe
output_dataframe <- as.data.frame(cbind.fill(output_dataframe, stargazers_integer))

#rename column
colnames(output_dataframe)[18] <- "stargazers_count"


#only print if has issues is NA or "NULL"
if (any(is.na(output_dataframe[, 18]) | output_dataframe[, 18] == "NULL")) {
  
  print(paste("There is no available count of stargazers for: ",
              output_dataframe$course_repo_names[is.na(output_dataframe[, 18]) | output_dataframe[, 18] == "NULL"]
  ))
  
}



remove(list = c('all_stargazers',
                'stargazers_integer'
                ))

