#purpose of script: extract last updated



#select all html_url items and stack as dataframe
all_updated_dates <- list.stack(list.select(req_content, updated_at))

#apply the strptime function to the extracted dates. Need a custom funciton to handle the 
#format argument when applying.
updated_dates_posix <- lapply(all_updated_dates, function(.){strptime(., format = '%Y-%m-%dT%H:%M:%S')})

#store as character vector for cbind.fill
updated_dates_character <- as.character(updated_dates_posix$updated_at)

#cbind back to output_dataframe
output_dataframe <- as.data.frame(cbind.fill(output_dataframe, updated_dates_character))

#rename column
colnames(output_dataframe)[4] <- "updated_date"


#only print if updated date is absent
if (any(is.na(output_dataframe[, 4]))) {
  
  print(paste("There is no updated date available for: ",
              output_dataframe$course_repo_names[is.na(output_dataframe[, 4])]
  ))
  
}




remove(list = c('all_updated_dates',
                'updated_dates_posix',
                'updated_dates_character'
                ))
