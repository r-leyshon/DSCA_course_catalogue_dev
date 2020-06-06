#purpose of file: filter outputs to required specification


#filter data to course catalogue
course_dataframe <- output_dataframe[grep("DSCA", output_dataframe$course_repo_names), ]


course_dataframe <- course_dataframe %>% select(readme_title,
                                                course_description = Paragraph_3,
                                                learning_outcome = Paragraph_8,
                                                course_type = Paragraph_11,
                                                skill_level = Paragraph_13,
                                    site_link)


