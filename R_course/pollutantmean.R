setwd("/Users/dehshini/code/R/intro_R")

pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files. its in the data directory.
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  ## NOTE: Do not round the result!
  thefiles  <-  list.files(directory, full.names = TRUE)[id]

  ## Read the files
  ## Combine the files into a single data frame
  thedata  <-  lapply(thefiles, function(x) read.csv(x)[[pollutant]])
  df_list  <-  unlist(thedata)
  # Calculate mean and return it to parent environment
  average  <-  mean(df_list, na.rm = TRUE)
  print(average)
}

# Example usage
sulfate_mean <- pollutantmean(
   "./data/specdata",
   "sulfate",
   id = 1:10
)

pollutantmean("data/specdata", "nitrate", id = 70:72)
pollutantmean("data/specdata", "sulfate", 34)
pollutantmean("data/specdata", "nitrate")

# nitrate_mean <- pollutantmean(
#   "./data/specdata",
#   "nitrate",
#   id = c(5, 8, 12, 15)
# )
