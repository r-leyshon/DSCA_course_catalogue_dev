#purpose of file: write output data to file



saveRDS(output_dataframe, "cache/course_catalogue.rds")


#write data to file
writexl::write_xlsx(output_dataframe, "output_data/course_catalogue.xlsx"
                 # sheetName = paste(Sys.Date()),
                 # row.names = FALSE
                 )
