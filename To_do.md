### v2.6

• Add warning message when approaching 100 results per page
• Issue on 14_scrape_lo_detail.R - list nodes keep changing format and resulting in length 0 issue. 
* Suggest using nested if statements to try and catch variability in list nodes. 
* Function is extract_lo_detail()
• Needed to change numerous times. Previous grep pattern was "tags"
• Now using "commits" pattern for grep
* Need more error handling and exception handling in regards to this.

### Parked
* schedule script execution on remote server
