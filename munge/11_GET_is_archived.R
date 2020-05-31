#purpose of script: extract logical for has_wiki


#select all repo_descriptions
all_archived <- list.select(req_content, archived)


#store as character vector for cbind.fill
archived_logical <- purrr::map(all_archived, as.logical) %>% unlist()

#cbind back to output_dataframe
output_dataframe <- as.data.frame(cbind.fill(output_dataframe, archived_logical))

#rename column
colnames(output_dataframe)[12] <- "is_archived"


#only print if has issues is NA
if (any(is.na(output_dataframe[, 12]))) {
  
  print(paste("There is no archived status for: ",
              output_dataframe$course_repo_names[is.na(output_dataframe[, 12])]
  ))
  
}



remove(list = c('all_archived',
                'archived_logical'
                ))

