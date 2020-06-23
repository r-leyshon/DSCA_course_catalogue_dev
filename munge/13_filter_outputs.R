#purpose of file: filter outputs to required specification

stop(TRUE)

output_dataframe <- output_dataframe %>% select(readme_title,
                                                version_number,
                                                course_summary,
                                                course_objective,
                                                learning_objective_detail,
                                                course_type = course_types,
                                                skill_level,
                                                site_link,
                                                lead_developer,
                                                course_reviewer,
                                                )


