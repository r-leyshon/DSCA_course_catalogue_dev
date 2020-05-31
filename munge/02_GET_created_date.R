#purpose of script: extract created date

#select all html_url items and stack as dataframe
all_created_dates <- list.stack(list.select(req_content, created_at))

#apply the strptime function to the extracted dates. Need a custom funciton to handle the 
#format argument when applying.
created_dates_posix <- lapply(all_created_dates, function(.){strptime(., format = '%Y-%m-%dT%H:%M:%S')})

#store as character vector for cbind.fill
created_dates_character <- as.character(created_dates_posix$created_at)

#cbind back to output_dataframe
output_dataframe <- as.data.frame(cbind.fill(output_dataframe, created_dates_character))

#rename column
colnames(output_dataframe)[3] <- "created_date"


#print message highlighting all repos where no created date available

#only print if created_dates are absent
if (any(is.na(output_dataframe[, 3]))) {
  
  print(paste("There is no created date available for: ",
              output_dataframe$course_repo_names[is.na(output_dataframe[, 3])]
  ))
  
}



remove(list = c('all_created_dates',
                'created_dates_posix',
                'created_dates_character',
                'all_pages')
       )
