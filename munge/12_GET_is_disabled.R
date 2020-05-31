#purpose of script: extract logical for has_wiki


#select all repo_descriptions
all_disabled <- list.select(req_content, disabled)


#store as character vector for cbind.fill
disabled_logical <- purrr::map(all_disabled, as.logical) %>% unlist()

#cbind back to output_dataframe
output_dataframe <- as.data.frame(cbind.fill(output_dataframe, disabled_logical))

#rename column
colnames(output_dataframe)[13] <- "is_disabled"


#only print if has issues is NA
if (any(is.na(output_dataframe[, 13]))) {
  
  print(paste("There is no disabled status for: ",
              output_dataframe$course_repo_names[is.na(output_dataframe[, 13])]
  ))
  
}



remove(list = c('all_disabled',
                'disabled_logical'
                ))

