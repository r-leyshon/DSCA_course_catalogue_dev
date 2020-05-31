#purpose of script: extract logical for has_wiki


#select all repo_descriptions
all_forks_count <- list.select(req_content, forks_count)


#store as character vector for cbind.fill
forks_count_integer <- purrr::map(all_forks_count, as.integer) %>% unlist()

#cbind back to output_dataframe
output_dataframe <- as.data.frame(cbind.fill(output_dataframe, forks_count_integer))

#rename column
colnames(output_dataframe)[11] <- "forks_count"


#only print if has issues is NA
if (any(is.na(output_dataframe[, 11]))) {
  
  print(paste("There is no count of forks for: ",
              output_dataframe$course_repo_names[is.na(output_dataframe[, 11])]
  ))
  
}



remove(list = c('all_forks_count',
                'forks_count_integer'
                ))

