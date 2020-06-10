#purpose of script: Automated email of zipped output data
#load cached email addresses
# source("git_ignore/email_addresses.R")
# 
# library(gmailr)
# 
# gm_auth_configure(path = "git_ignore/credentials.json")
# 
# 
# 
# email_text <- "Automated email sent from dsca_course_catalogue_dev - master. Please find attached
# the latest version of DSCA course catalogue and metadata for all DSC open repos."
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
