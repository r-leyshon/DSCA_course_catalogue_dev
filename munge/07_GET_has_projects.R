#purpose of script: extract description. I believe this is the description created along with
#initial repo setup. Will call repo_description in output dataframe.


#select all repo_descriptions
all_has_projects <- list.select(req_content, has_projects)


#store as character vector for cbind.fill
has_projects_logical <- purrr::map(all_has_projects, as.logical) %>% unlist()

#cbind back to output_dataframe
output_dataframe <- as.data.frame(cbind.fill(output_dataframe, has_projects_logical))

#rename column
colnames(output_dataframe)[8] <- "has_projects"


#only print if has issues is NA
if (any(is.na(output_dataframe[, 8]))) {
  
  print(paste("There is no projects status for: ",
              output_dataframe$course_repo_names[is.na(output_dataframe[, 8])]
  ))
  
}



remove(list = c('all_has_projects',
                'has_projects_logical'
                ))

