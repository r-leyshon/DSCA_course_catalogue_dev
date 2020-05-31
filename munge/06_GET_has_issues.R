#purpose of script: extract description. I believe this is the description created along with
#initial repo setup. Will call repo_description in output dataframe.


#select all repo_descriptions
all_has_issues <- list.select(req_content, has_issues)


#store as character vector for cbind.fill
has_issues_logical <- purrr::map(all_has_issues, as.logical) %>% unlist()

#cbind back to output_dataframe
output_dataframe <- as.data.frame(cbind.fill(output_dataframe, has_issues_logical))

#rename column
colnames(output_dataframe)[7] <- "has_issues"


#only print if has issues is NA
if (any(is.na(output_dataframe[, 7]))) {
  
  print(paste("There is no issues status for: ",
              output_dataframe$course_repo_names[is.na(output_dataframe[, 7])]
  ))
  
}



remove(list = c('all_has_issues',
                'has_issues_logical'
                ))

