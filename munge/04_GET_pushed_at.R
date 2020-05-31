#purpose of script: extract pushed at date time 



#select all html_url items and stack as dataframe
all_pushed_dates <- list.stack(list.select(req_content, pushed_at))

#apply the strptime function to the extracted dates. Need a custom funciton to handle the 
#format argument when applying.
pushed_dates_posix <- lapply(all_pushed_dates, function(.){strptime(., format = '%Y-%m-%dT%H:%M:%S')})

#store as character vector for cbind.fill
pushed_dates_character <- as.character(pushed_dates_posix$pushed_at)

#cbind back to output_dataframe
output_dataframe <- as.data.frame(cbind.fill(output_dataframe, pushed_dates_character))

#rename column
colnames(output_dataframe)[5] <- "pushed_at"


#only print if updated date is absent
if (any(is.na(output_dataframe[, 5]))) {
  
  print(paste("There is no pushed at date available for: ",
              output_dataframe$course_repo_names[is.na(output_dataframe[, 5])]
  ))
  
}




remove(list = c('all_pushed_dates',
                'pushed_dates_posix',
                'pushed_dates_character'
                ))
