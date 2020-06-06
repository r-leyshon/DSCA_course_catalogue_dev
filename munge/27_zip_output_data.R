#purpose of script: zip output files ready for emailing

# Read the 2 xlsx file names from output_data directory
files2zip <- dir('output_data', full.names = TRUE)

#zip folder appears to not like spaces in filename
current_time <- str_replace_all(as.character(Sys.time()), ":", "-")
current_time <- str_replace_all(current_time, " ", "_")

current_directory <- getwd()

zip_folder_name <- paste0(current_directory,"/zipped_output/dsca_cc_", current_time, ".zip")

#zip files to folder
zip::zipr(zip_folder_name, files2zip)

remove(list = 'files2zip',
       'current_time',
       'current_directory')
