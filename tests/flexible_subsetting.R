set.seed(100)
text1 <- sample(letters[1:10], 10)
text2 <- sample(letters[1:10], 10)
text3  <- c(letters[1:9], "a")



my_matrix <- rbind(text1, text2, text3)



# start_index <- apply(my_matrix,
#                      #find first instance of 'a'.
#                      FUN = function(x){grep("a", x)[1]},
#                      #iterate over columns
#                      MARGIN = 1)
# 
# end_index <- apply(my_matrix,
#                      #find last instance of 'a'.
#                      FUN = function(x){
#                        #determine the last index available for "a"
#                        occurences <- length(grep("a", x))
#                        #subset by the last index
#                        grep("a", x)[occurences]
#  
#                        },
#                    #iterate over rows
#                    MARGIN = 1)
# 
# 
# 
# 
# 
# my_matrix[1, 5]
# my_matrix[1, start_index[1]]
# 
# 
# paste(my_matrix[3, start_index[3]:end_index[3]])
#this works for a vector of indices but I will need to iterate, so will have to use which


# iterate -----------------------------------------------------------------
# iterate -----------------------------------------------------------------
# iterate -----------------------------------------------------------------

#initiate variables for while loop
count <- 1
required_output <- character()

#continue looping until every row iterated
while(count <= nrow(my_matrix)){
  #find first instance of "a"
  start_index <- grep("a", my_matrix[count, ])[1]
  #find last instance of "a"
  end_index <- grep("a", my_matrix[count, ])[length(grep("a", my_matrix[count, ]))]
  
  #control flow based on difference between start & end index
  if (start_index == end_index) {
  #save the extracted value from the matrix for this iteration
  required_output <- c(required_output, my_matrix[count, start_index+1])
  print(paste("start index used is", start_index))
  print(paste("Output saved is", my_matrix[count, start_index+1]))
  } else {
    required_output <- c(required_output, paste(my_matrix[count, (start_index+1):(end_index-1)], collapse = " "))
    print(paste("End index used is", start_index:end_index))
    print(paste("Output saved is", paste(my_matrix[count, (start_index+1):(end_index-1)], collapse = " ")))
  }
#output iteration number
print(paste("Iteration number", count, "finishes"))
#increment iteration by 1
count <- count + 1

}

"Fab!!! Start tomorrow by applying this logic to the working dtaaframe."
required_output[3]
