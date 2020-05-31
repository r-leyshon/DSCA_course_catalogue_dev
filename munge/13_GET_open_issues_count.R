#purpose of script: extract logical for has_wiki


#select all repo_descriptions
all_open_issues_count <- list.select(req_content, open_issues_count)


#store as character vector for cbind.fill
open_issues_integer <- purrr::map(all_open_issues_count, as.integer) %>% unlist()

#cbind back to output_dataframe
output_dataframe <- as.data.frame(cbind.fill(output_dataframe, open_issues_integer))

#rename column
colnames(output_dataframe)[14] <- "open_issues_count"


#only print if has issues is NA
if (any(is.na(output_dataframe[, 14]))) {
  
  print(paste("There is no count of open issues for: ",
              output_dataframe$course_repo_names[is.na(output_dataframe[, 14])]
  ))
  
}



remove(list = c('all_open_issues_count',
                'open_issues_integer'
                ))

