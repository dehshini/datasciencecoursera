setwd("/Users/dehshini/code/R/intro_R")
#source("scripts/complete.R")

corr  <- function(directory, threshold = 0) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0
    ## Return a numeric vector of correlations
    ## NOTE: Do not round the result!

    correlation  <-  numeric()
    complete_cases  <-  complete(directory)
    for (i in complete_cases$id) {
        if (complete_cases$nobs[i] > threshold) {
            thefiles  <-  list.files(directory, full.names = TRUE)[[i]]
            data  <-  read.csv(thefiles)
            cor.value <- cor(data$sulfate, data$nitrate, use = "complete.obs")
            correlation  <-  c(correlation, cor.value)
        }
    }
    return(correlation)
}


cr <- corr("data/specdata", 2000)
n <- length(cr)
cr <- corr("data/specdata", 1000)
cr <- sort(cr)
print(c(n, round(cr, 4)))