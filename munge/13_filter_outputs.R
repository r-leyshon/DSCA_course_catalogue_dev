#purpose of file: filter outputs to required specification



output_dataframe <- output_dataframe %>% select(readme_title,
                                                course_summary,
                                                course_objective,
                                                course_type = course_types,
                                                skill_level,
                                                site_link,
                                                lead_developer,
                                                course_reviewer,
                                                learning_objectives)


