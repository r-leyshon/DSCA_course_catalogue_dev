#purpose of script: Automated email of zipped output data

# if prior_state_ignore has been set to TRUE, use this as the status condition
#105 cache comparison override
if(prior_state_ignore == TRUE){
  current_status <- 105
  status_message <- paste0("Comparison with previous catalogue state has been diabled by the developer.")
}



email_text <- paste("Automated email sent from dsca_course_catalogue_dev version",
                    version_number,
                    ". Please find attached the latest version of DSCA course catalogue.",
                    " Status Condition =",
                    current_status,
                    ". Status message =",
                    status_message,
                    ". Status override condition =",
                    status_override)


email_complete <- gm_mime() %>%
  gm_to(recipients) %>%
  gm_from(from_address) %>%
  gm_subject("DSCA course catalogue update attached") %>%
  gm_text_body(email_text) %>%
  gm_attach_part(email_text) %>%
  gm_attach_file(zip_folder_name)


gm_send_message(email_complete)

remove(list = 'email_text',
       'email_complete',
       'github_token')
