# #purpose of script: Automated email of zipped output data
# #load cached email addresses
# source("git_ignore/email_addresses.R")
# 
# library(gmailr)
# 
# gm_auth_configure(path = "git_ignore/credentials.json")
# 
# 
# email_text <- paste("Automated email sent from dsca_course_catalogue_dev version", version_number, "Please find attached the latest version of DSCA course catalogue. Version", version_number+0.1, "to include informative Email content based on the reason for updating the website.")
# 
# 
# email_complete <- gm_mime() %>%
#   gm_to(recipients) %>%
#   gm_from(from_address) %>%
#   gm_subject("DSCA course catalogue update attached") %>%
#   gm_text_body(email_text) %>%
#   gm_attach_part(email_text) %>%
#   gm_attach_file(zip_folder_name)
# 
# 
# gm_send_message(email_complete)
# 
# remove(list = 'email_text',
#        'email_complete',
#        'github_token')
