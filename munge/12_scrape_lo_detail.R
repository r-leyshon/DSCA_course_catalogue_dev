#purpose of script: scrape readme lists, extract & assign learning objective detail

#apply the function to extract course descriptions from the parsed course list
lo_detail_list <- lapply(parsed_course_pages, FUN = extract_lo_detail)

#rbind the list elements
lo_detail <- list.rbind(lo_detail_list)

#save as a column in dataframe
output_dataframe$learning_objective_detail <- lo_detail



remove(list = 'lo_detail',
       'lo_detail_list',
       'extract_lo_detail',
       'cbind.fill',
       'all_pages',
       'parsed_course_pages'
       )

