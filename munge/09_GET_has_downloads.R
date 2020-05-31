#purpose of script: extract logical for has_wiki


#select all repo_descriptions
all_has_downloads <- list.select(req_content, has_downloads)


#store as character vector for cbind.fill
has_downloads_logical <- purrr::map(all_has_downloads, as.logical) %>% unlist()

#cbind back to output_dataframe
output_dataframe <- as.data.frame(cbind.fill(output_dataframe, has_downloads_logical))

#rename column
colnames(output_dataframe)[10] <- "has_downloads"


#only print if has issues is NA
if (any(is.na(output_dataframe[, 10]))) {
  
  print(paste("There is no download status for: ",
              output_dataframe$course_repo_names[is.na(output_dataframe[, 10])]
  ))
  
}



remove(list = c('all_has_downloads',
                'has_downloads_logical'
                ))

