#purpose of script: extract last updated


#extract all course repo names from all_pages url vector
mr3_cleansed <- lapply(all_pages, extract_mr3) %>% unlist()


output_dataframe$last_updated <- mr3_cleansed


remove(list = c(
                'mr3_cleansed',
                'extract_mr3',
                'all_pages'))
