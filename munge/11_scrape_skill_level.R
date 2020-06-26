#function of script: extract skill level



#find skill level pattern


# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
# -------------------------------------------------------------------------



#initiate variables for while loop
count <- 1
skill_levels <- character()

#continue looping until every row iterated
while(count <= nrow(lowered_output)){
  #find first instance of "skill level"
  start_index <- grep("skill level", lowered_output[count, ])[1]+1 #+1 for column following "course summary"
  #find first instance of "pre req"
  end_index <- grep("pre req", lowered_output[count, ])[1]-1 #-1 for column preceeding "learning outcome"
  
  #need additional logic to catch start / end index having a zero length / NA
  if (length(start_index) == 0 | is.na(start_index) &
      length(end_index) == 0 | is.na(end_index)){
    
    skill_levels <- c(skill_levels, "Skill level not found")
    print(paste("start index not found for iteration ", count))
    print(paste("end index not found for iteration ", count))
    
    } else if (length(start_index) == 1 & length(end_index) == 0 | is.na(end_index)){
      
      #control flow based on missing end index
      #save the extracted value using start index
      skill_levels <- c(skill_levels, output_dataframe[count, start_index])
      print(paste("Warning, end index not detected for iteration", count))
      print(paste("start index used is", start_index))
      print(paste("Output saved is", output_dataframe[count, start_index]))
      
      } else if (length(end_index) == 1 & length(start_index) == 0 | is.na(start_index)){
        
        #control flow based on missing start index
        #save the extracted value using end index
        skill_levels <- c(skill_levels, output_dataframe[count, end_index])
        print(paste("Warning, start index not detected for iteration", count))
        print(paste("End index used is", end_index))
        print(paste("Output saved is", output_dataframe[count, end_index]))
        
        } else if (start_index == end_index) {
          
          #logic here relies on values for both indices
          #control flow based on difference between start & end index
          #save the extracted value from the matrix for this iteration
          skill_levels <- c(skill_levels, output_dataframe[count, start_index])
          print(paste("start index used is", start_index))
          print(paste("Output saved is", output_dataframe[count, start_index]))
          
          } else {
            
            # if start index differs to end index, then use the range to paste values
            skill_levels <- c(skill_levels, paste(output_dataframe[count, (start_index):(end_index)], collapse = " "))
            print(paste("End index used is", start_index:end_index))
            print(paste("Output saved is", paste(output_dataframe[count, start_index:end_index], collapse = " ")))
            
            }
  
  #output iteration number 
  print(paste("Iteration number", count, "finishes"))
  
  #increment iteration by 1
  count <- count + 1
  
  } # end of loop


# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
# -------------------------------------------------------------------------



#assign to a column in output dataframe
output_dataframe$skill_level <- skill_levels


remove(list =
         'count',
       'skill_levels',
       'end_index',
       'start_index',
       'lowered_output'
       )

