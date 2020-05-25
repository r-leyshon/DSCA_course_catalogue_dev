# #purpose of script: scrape commit username
# 
# 
# test_parse <- read_html('https://github.com/datasciencecampus/DSCA_Stats4DS')
# 
# test_parse %>% html_nodes(".user-mention") %>% html_text()
# 
# 
# 
# test <- html_nodes(test_parse, "a")
# 
# #read_html("https://github.com/tidyverse/ggplot2") %>%
# read_html("https://github.com/tylermorganwall/MusaMasterclass") %>% 
# #read_html("https://github.com/r-leyshon/education_scatter") %>% 
#   html_nodes(".user-mention") %>% 
#   html_text()


"really strange, it works for ggplot2 and TMW's MUSA masterclass repo, but not for DSCA or my own repos."


"To do:
1. Extracting original commit author not straight forward. Various options explored with no joy.
2. Search result pages are hard-coded. Will need to imrpove this with clickthrough webdriver.
"
