#purpose of file: filter outputs to required specification


output_dataframe <- output_dataframe %>% select(readme_title,
                                                version_number,
                                                course_duration,
                                                course_summary,
                                                course_objective,
                                                learning_objective_detail,
                                                course_type = course_types,
                                                skill_level,
                                                site_link,
                                                lead_developer,
                                                course_reviewer,
                                                license_name
                                                )


