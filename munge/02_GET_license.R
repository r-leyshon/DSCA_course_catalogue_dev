#purpose of script: extract logical for has_wiki

# filter req_content full_name to "DSCA" only
dsca_content <- req_content[grep("DSCA", req_content)]

#select all repo_descriptions
all_licenses <- list.select(dsca_content, license$name)


#store as character vector for cbind.fill
license_name_text <- purrr::map(all_licenses, as.character) %>% unlist()

#cbind back to output_dataframe
output_dataframe <- as.data.frame(cbind.fill(output_dataframe, license_name_text))

#rename column
colnames(output_dataframe)[3] <- "license_name"


#only print if has issues is NA or "NULL"
if (any(is.na(output_dataframe[, 3]) | output_dataframe[, 3] == "NULL")) {
  
  print(paste("There is no license information for: ",
              output_dataframe$course_repo_names[is.na(output_dataframe[, 3]) | output_dataframe[, 3] == "NULL"]
  ))
  
}



remove(list = c('all_licenses',
                'license_name_text',
                'req_content',
                'dsca_content'
                ))

