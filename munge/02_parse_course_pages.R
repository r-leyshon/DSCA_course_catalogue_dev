"function of script: parse all course pages to xml and store for further processing scripts"



#parse and store all course pages as a nested list object
#amendment at version 1.1. error here when using $ operator to select column. index ref now working.
parsed_course_pages <- lapply(output_dataframe[,2], read_html)
  
