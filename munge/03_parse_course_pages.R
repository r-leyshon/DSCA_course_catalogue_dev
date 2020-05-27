"function of script: parse all course pages to xml and store for further processing scripts"



#parse and store all course pages as a nested list object

parsed_course_pages <- lapply(output_dataframe$site_link, read_html)
  



