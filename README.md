# Course Catalogue Scrape

Version Notes:

### 1.1
* Github search API results used to extract selection of repo metadata
* last updated script issue resolved
* 2 outputs: repo_catalogue.xlsx & course_catalogue.xlsx


## 1.0
* Github search API used to avoid issue in generalisation in identifying number of search result pages
* Now all open repos from DSC are available to scrape
* despite scopes configured for private repos - they do not appear
* last updated column script hashed out. Amend script logic for 1.1.

### 0.5:
* Work on generalising the page indexing function, to consider search results with larger number of pages. <ongoing>
* Current model only returns open repos, even when passed search results that contain a mix of open and private repos. 

### 0.4:
* Course text extracted from course location readmes. Results in a variable number of columns dependent upon longest readme in repositories. 

### 0.3: 
* last updated scraped from search result page as text.
* Repo names formatted - '/datasciencecampus/' removed from output data.


### 0.2:
* Error handling for cases where no readme is available. "No readme header is present" is recorded as the course title.
* Course location urls stored as column in output dataframe. 


### 0.1: 
* Base url to begin with is an advanced search of DSC repos, using search parameters repos including "DSCA" but not "dev"
* Repo names with format '/datasciencecampus/repo_name_here' extracted and used to build links to course pages.
* Course title scraped from first h1 header present in readme files. 