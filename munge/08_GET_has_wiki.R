#purpose of script: extract logical for has_wiki


#select all repo_descriptions
all_has_wiki <- list.select(req_content, has_wiki)


#store as character vector for cbind.fill
has_wiki_logical <- purrr::map(all_has_wiki, as.logical) %>% unlist()

#cbind back to output_dataframe
output_dataframe <- as.data.frame(cbind.fill(output_dataframe, has_wiki_logical))

#rename column
colnames(output_dataframe)[9] <- "has_wiki"


#only print if has issues is NA
if (any(is.na(output_dataframe[, 9]))) {
  
  print(paste("There is no wiki status for: ",
              output_dataframe$course_repo_names[is.na(output_dataframe[, 9])]
  ))
  
}



remove(list = c('all_has_wiki',
                'has_wiki_logical'
                ))

