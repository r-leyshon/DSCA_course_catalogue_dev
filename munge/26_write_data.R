#purpose of file: write output data to file


saveRDS(output_dataframe, "cache/repo_catalogue.rds")


#write data to file
xlsx::write.xlsx(output_dataframe, "output_data/repo_catalogue.xlsx",
                 sheetName = paste(Sys.Date()),
                 row.names = FALSE)



saveRDS(course_dataframe, "cache/course_catalogue.rds")


#write data to file
xlsx::write.xlsx(course_dataframe, "output_data/course_catalogue.xlsx",
                 sheetName = paste(Sys.Date()),
                 row.names = FALSE)
