#purpose of script: zip output files ready for emailing

# Read the 2 xlsx file names from output_data directory
files2zip <- paste0("output_data//", list.files(path = 'output_data', pattern = 'xlsx$'))
  

#zip folder appears to not like spaces and can't have colons in filename
current_time <- str_replace_all(as.character(Sys.time()), ":", "-")
current_time <- str_replace_all(current_time, " ", "_")

current_directory <- getwd()

#create the folder name, using the sys.time to increment
zip_folder_name <- paste0(current_directory,"/zipped_output/dsca_cc_", current_time, ".zip")


#step to clear out any previous zipped folder prior to running
fold <- 'zipped_output'

# get all files in the directories, recursively, apart from the readme
f <- grep(list.files(path = fold, include.dirs = F, full.names = T, recursive = T, pattern = 'zip$'),
          pattern = 'zipped_output_readme.md', invert = TRUE, value = TRUE)

# remove the files
file.remove(f)



#zip files to folder
zip::zipr(zip_folder_name, files2zip)

remove(list = 'files2zip',
       'current_time',
       'current_directory')
