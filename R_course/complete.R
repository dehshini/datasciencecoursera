setwd("/Users/dehshini/code/R/intro_R")

complete <- function(directory, id = 1:332) {
    # Create an empty data frame to store the combined data
    complete_data <- data.frame(id = integer(), nobs = integer())

    # Loop through each monitor ID
    for (monitor_id in id) {
        # Generate the file path for each CSV file
        file_path <- file.path(directory, sprintf("%03d.csv", monitor_id))
        # Read the CSV file
        data <- read.csv(file_path)
        # count the rows with complete cases
        complete_count <- sum(complete.cases(data))
        # Add the monitor ID and the count of complete cases to the data frame
        complete_data <- rbind(complete_data, data.frame(id = monitor_id, nobs = complete_count))
    }
    return(complete_data)
}

#example usage
#print(complete("data/specdata", id = c(2, 4, 8, 10, 12)))

RNGversion("3.5.1")
set.seed(42)
cc <- complete("data/specdata", 332:1)
use <- sample(332, 10)
print(cc[use, "nobs"])
