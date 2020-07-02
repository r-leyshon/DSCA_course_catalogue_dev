# purpose of script: compare current state with cached versions
# generate state conditions to use in Gmailr Email message


#Need some condition statuses to print and Email
#100 no change detected
#101 course added and course removed
#102 new course detected
#103 course removed
#104 course version changed

condition_statuses <- c(100, 101, 102, 103, 104)


"Need to create a concatenation of course name & version number to compare against 
previous caches"



# create variables to compare ---------------------------------------------

newstate_course_names <- output_dataframe$readme_title

newstate_course_versions <- paste(output_dataframe$readme_title, output_dataframe$version_number,
                                  sep = " - Version ")

#course names from last run
prior_state_course_names <- readRDS("cache/prior_coursenames.rds")

#course name versions from last run
prior_state_course_versions <- readRDS("cache/prior_courseversions.rds")


# conditional flow create email message -----------------------------------


if (all(newstate_course_versions == prior_state_course_versions)) {
  
  current_status <- condition_statuses[1]
  status_message <- "Course catalogue script run. No change detected."
  print(current_status)
  print(status_message)
  
} else if (length(setdiff(x = newstate_course_names, y = prior_state_course_names)) > 0 &
           length(setdiff(x = prior_state_course_names, y = newstate_course_names)) > 0) {
  
  new_course <-  setdiff(x = newstate_course_names, y = prior_state_course_names)
  removed_course <-  setdiff(x = prior_state_course_names, y = newstate_course_names)
  current_status <- condition_statuses[2]
  print(current_status)
  status_message <- paste0(
    "The following course(s) have been added: ", paste0(new_course, collapse = ", "),
    ". In addition, the following course(s) have been removed: ", paste0(removed_course, collapse = ", ")
  )
  print(status_message)
  
  } else if (length(setdiff(x = newstate_course_names, y = prior_state_course_names)) > 0 &
             length(setdiff(x = prior_state_course_names, y = newstate_course_names)) == 0) {
    
    new_course <-  setdiff(x = newstate_course_names, y = prior_state_course_names)
    current_status <- condition_statuses[3]
    print(current_status)
    status_message <- paste0(
      "The following course(s) have been added: ",
      paste0(new_course, collapse = ", ")
      )
    print(status_message)
    
  } else if (length(setdiff(x = newstate_course_names, y = prior_state_course_names)) == 0 &
             length(setdiff(x = prior_state_course_names, y = newstate_course_names)) > 0) {
    
    removed_course <-  setdiff(x = prior_state_course_names, y = newstate_course_names)
    current_status <- condition_statuses[4]
    print(current_status)
    status_message <- paste0(
      "The following course(s) have been removed: ",
      paste0(removed_course, collapse = ", ")
    )
    print(status_message)  
  
  } else {
    
    updated_course <- setdiff(x = newstate_course_versions, y = prior_state_course_versions)
    current_status <- condition_statuses[5]
    print(current_status)
    status_message <- paste0(
      "The following course version(s) have been updated: ",
      paste0(updated_course, collapse = ", ")
    )
    print(status_message)
  }




# update prior version & prior course names -------------------------------

saveRDS(object = current_status, file = "cache/prior_status.rds")

saveRDS(object = status_message, file = "cache/prior_status_message.rds")

saveRDS(object = newstate_course_names, file = "cache/prior_coursenames.rds")

saveRDS(object = newstate_course_versions, file = "cache/prior_courseversions.rds")




stop(TRUE)

"left off here. now an if stetement that executes an email if status 100 then stops. 
else continue and use message in gmailr at end"

