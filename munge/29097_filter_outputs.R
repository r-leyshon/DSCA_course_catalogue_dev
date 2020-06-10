#purpose of file: filter outputs to required specification


stop(TRUE)



output_dataframe <- output_dataframe %>% select(readme_title,
                                                course_description = Paragraph_3,
                                                learning_outcome = Paragraph_8,
                                                course_type = Paragraph_11,
                                                skill_level = Paragraph_13,
                                    site_link)


