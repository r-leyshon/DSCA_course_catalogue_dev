# Course Catalogue Scrape

Version Notes:

### 2.6
* Lint each script - styler applied and linter guidance actioned.
* Include license detail available from Github API
* Improved efficiency by 35.56577 seconds by moving 'DSCA' pattern filter forward
* query parameter updated to include up to 100 results per page
* Added control logic to allow control over sending of Emails from initialise.R script
* Add logic to control previous run cache status on or off
* extract_course_description() required dynamic start index due to change in <p> node structure of website.
* Added warning message in 01_GET_repo_urls.R when repo number is approaching page limit.
* Repo description patter "(pending review)" filtered out in 01_GET_repo_urls.R
* Control flow in 06_cache_comparison.R revised to run gracefully when courses removed.


### 2.5

* Script 04_scrape_version now filters out any rows with no version number (~ equal to non standardised readme)
* extract_lo_detail() function grep pattern switched from "tags" to "commits"
• Including a status ovveride feature to ignore cache comparison and push scripts to conclusion.

### 2.4

* At start of script, look in zip folder and clear out if anything is present = stop stockpiling of zip folders
* cache course list & version numbers for comparison on successive runs
* write if statement to check on above conditions prior to Emailing
* output full dataframe to publishing, but create informative Email describing reason for update
* move updating 'if statement' towards front of script and only execute remainder when required


### 2.3

* Course duration script added
* Error in scrape_lo_detail adjusted. Structure of parsed course pages changed again. Keep an eye on this. Now using "n/          tags" +1 pattern to decide start index for LO detail.


### 2.2

* Git ignore updated to ensure expected folders can be cloned
* Changed function to output to excel, no dependency on Java.
* Adjusted script 15_zip_output so that readme was not sent in Email
* Adjusted order of columns sent to customer (customer request)

### 2.1

* Further error handling in instances of missing readmes

## 2.0

* Added scripts to scrape list content from readmes, including learning objectives & course type.


### 1.4

* Added scripts to scrape columns for learning outcome, lead developer, course reviewer(s) & skill level.


### 1.3

* Added data folders to .gitignore
* Moved filter to DSCA repos only from script 25 to script 01
* Deleted all surplus GET scripts and renumbered remaining scripts
* Script 04_extract_version.R added.
* reprex for method used to flexibly subset based on grep in tests folder.
* Script 06_scrape_course_summary.R added 

### 1.2

* zip folder name now incremented with Sys.time() to allow multiple runs on one day
* identify columns of interest in readme by name[NB]
* select columns of interest for website publication[NB]
* [NB] functionality is there but requires consistent readme formatting
* zip folder now saved to 'zipped_output' as incremental runs were saving multiple zipped folders


### 1.1

* Github search API results used to extract selection of repo metadata
* last updated script issue resolved
* 2 outputs: repo_catalogue.xlsx & course_catalogue.xlsx
* Conflict in message() with base and gmailr resolved
* Troubleshooting zipr behaviour: folder name requires increment. Used Sys.Date().


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