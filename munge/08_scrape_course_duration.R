# function of script: extract course durations
# lower case of all columns
lowered_output <- apply(
  output_dataframe,
  FUN = tolower,
  # iterate over columns
  MARGIN = 2
)

# find course duration pattern
# initiate variables for while loop
count <- 1
course_durations <- character()

# continue looping until every row iterated
while (count <= nrow(lowered_output)) {
  # find first instance of "course duration"
  start_index <- grep("course duration", lowered_output[count, ])[1] + 1
  #+1 for column following "course summary"
  # find first instance of "course summary"
  end_index <- grep("course summary", lowered_output[count, ])[1] - 1
  #-1 for column preceeding "learning outcome"

  # need additional logic to catch start / end index having a zero length / NA
  if (length(start_index) == 0 | is.na(start_index) &
    length(end_index) == 0 | is.na(end_index)) {
    course_durations <- c(course_durations, "course duration not found")
    print(paste("start index not found for iteration ", count))
    print(paste("end index not found for iteration ", count))
  } else if (
    length(start_index) == 1 & length(end_index) == 0 | is.na(end_index)) {

    # control flow based on missing end index
    # save the extracted value using start index
    course_durations <- c(course_durations,
                          output_dataframe[count, start_index])
    print(paste("Warning, end index not detected for iteration", count))
    print(paste("start index used is", start_index))
    print(paste("Output saved is", output_dataframe[count, start_index]))
  } else if (
    length(end_index) == 1 & length(start_index) == 0 | is.na(start_index)) {

    # control flow based on missing start index
    # save the extracted value using end index
    course_durations <- c(course_durations, output_dataframe[count, end_index])
    print(paste("Warning, start index not detected for iteration", count))
    print(paste("End index used is", end_index))
    print(paste("Output saved is", output_dataframe[count, end_index]))
  } else if (start_index == end_index) {

    # logic here relies on values for both indices
    # control flow based on difference between start & end index
    # save the extracted value from the matrix for this iteration
    course_durations <- c(course_durations,
                          output_dataframe[count, start_index])
    print(paste("start index used is", start_index))
    print(paste("Output saved is", output_dataframe[count, start_index]))
  } else {

    # if start index differs to end index, then use the range to paste values
    course_durations <- c(course_durations,
                          output_dataframe[count, start_index])
  }

  # output iteration number
  print(paste("Iteration number", count, "finishes"))

  # increment iteration by 1
  count <- count + 1
} # end of loop

# assign to a column in output dataframe
output_dataframe$course_duration <- course_durations

remove(
  list =
    "count",
  "course_durations",
  "end_index",
  "start_index"
)
