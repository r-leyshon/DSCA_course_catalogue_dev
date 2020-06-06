#purpose of script: zip output files ready for emailing

# Read the 2 xlsx file names from output_data directory
files2zip <- dir('output_data', full.names = TRUE)

todays_date <- Sys.Date()
zip_folder_name <- paste0("output_data/course_catalogue_", todays_date, ".zip")

#zip files to folder
zip::zipr(zip_folder_name, files2zip)

remove(list = 'files2zip',
       'todays_date')
